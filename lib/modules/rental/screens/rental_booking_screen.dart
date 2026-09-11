import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_radius.dart';
import '../../../app/theme/app_shadows.dart';
import '../../../app/theme/app_spacing.dart';
import '../../../shared/widgets/app_bar/app_bar.dart';
import '../bindings/rental_binding.dart';
import '../bindings/rental_booking_binding.dart';
import '../controllers/rental_booking_controller.dart';
import '../widgets/pickup_dropoff_widget.dart';
import '../widgets/rental_addons_widget.dart';
import '../widgets/rental_booking_summary_widget.dart';
import '../widgets/rental_price_breakdown_widget.dart';
import 'rental_confirmation_screen.dart';

/// Checkout and booking finalization screen for vehicle reservations.
class RentalBookingScreen extends StatelessWidget {
  const RentalBookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    RentalBinding.ensureInitialized();
    if (!Get.isRegistered<RentalBookingController>()) {
      RentalBookingBinding().dependencies();
    }

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bookingCtrl = Get.find<RentalBookingController>();

    final formKey = GlobalKey<FormState>();

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      appBar: const SewaAppBar(
        titleText: 'Rental Checkout',
        showBackButton: true,
      ),
      body: Obx(() {
        final vehicle = bookingCtrl.vehicle.value;
        final searchModel = bookingCtrl.searchModel.value;

        if (vehicle == null) {
          return const Center(child: Text('No vehicle selected for booking.'));
        }

        return Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 1. Vehicle & Trip Summary
                      RentalBookingSummaryWidget(
                        vehicle: vehicle,
                        searchModel: searchModel,
                      ),

                      const SizedBox(height: AppSpacing.lg),

                      // 2. Pickup & Dropoff Options
                      const PickupDropoffWidget(),

                      const SizedBox(height: AppSpacing.lg),

                      // 3. Add-ons & Protection Plans
                      const RentalAddonsWidget(),

                      const SizedBox(height: AppSpacing.lg),

                      // 4. Primary Driver Details Form
                      Text(
                        'PRIMARY DRIVER DETAILS',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.7,
                          color: isDark ? AppColors.textMutedDark : AppColors.textSecondaryLight,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.sm),

                      Container(
                        padding: const EdgeInsets.all(AppSpacing.md),
                        decoration: BoxDecoration(
                          color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
                          borderRadius: AppRadius.radiusLg,
                          border: Border.all(
                            color: isDark ? AppColors.borderDark : AppColors.borderLight,
                          ),
                        ),
                        child: Column(
                          children: [
                            TextFormField(
                              initialValue: bookingCtrl.driverName.value,
                              decoration: InputDecoration(
                                labelText: 'Full Name (as on Driving License)',
                                prefixIcon: const Icon(Icons.person_outline, size: 20),
                                isDense: true,
                                border: OutlineInputBorder(
                                  borderRadius: AppRadius.radiusMd,
                                ),
                              ),
                              validator: (val) =>
                                  val == null || val.isEmpty ? 'Please enter full name' : null,
                              onChanged: (val) => bookingCtrl.driverName.value = val,
                            ),
                            const SizedBox(height: AppSpacing.md),
                            TextFormField(
                              initialValue: bookingCtrl.driverPhone.value,
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                labelText: 'Contact Phone Number',
                                prefixIcon: const Icon(Icons.phone_outlined, size: 20),
                                isDense: true,
                                border: OutlineInputBorder(
                                  borderRadius: AppRadius.radiusMd,
                                ),
                              ),
                              validator: (val) =>
                                  val == null || val.length < 10 ? 'Enter valid phone number' : null,
                              onChanged: (val) => bookingCtrl.driverPhone.value = val,
                            ),
                            const SizedBox(height: AppSpacing.md),
                            TextFormField(
                              initialValue: bookingCtrl.driverLicense.value,
                              decoration: InputDecoration(
                                labelText: 'Driving License Number',
                                prefixIcon: const Icon(Icons.badge_outlined, size: 20),
                                isDense: true,
                                border: OutlineInputBorder(
                                  borderRadius: AppRadius.radiusMd,
                                ),
                              ),
                              validator: (val) =>
                                  val == null || val.isEmpty ? 'Enter driving license number' : null,
                              onChanged: (val) => bookingCtrl.driverLicense.value = val,
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: AppSpacing.lg),

                      // 5. Price Breakdown & Coupon
                      RentalPriceBreakdownWidget(
                        pricing: bookingCtrl.pricing,
                      ),

                      const SizedBox(height: AppSpacing.xxl),
                    ],
                  ),
                ),
              ),
            ),

            // Sticky Bottom Confirmation Bar
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.lg,
                vertical: AppSpacing.md,
              ),
              decoration: BoxDecoration(
                color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
                boxShadow: AppShadows.floating,
                border: Border(
                  top: BorderSide(
                    color: isDark ? AppColors.borderDark : AppColors.borderLight,
                  ),
                ),
              ),
              child: SafeArea(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'TOTAL PAYABLE',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.6,
                            color: isDark ? AppColors.textMutedDark : AppColors.textSecondaryLight,
                          ),
                        ),
                        Text(
                          '₹${bookingCtrl.pricing.totalPayable.toInt()}',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: bookingCtrl.isSubmitting.value
                          ? null
                          : () async {
                              if (formKey.currentState?.validate() ?? false) {
                                final booking = await bookingCtrl.submitBooking();
                                if (booking != null) {
                                  Get.off(() => const RentalConfirmationScreen());
                                }
                              }
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.xl,
                          vertical: AppSpacing.md,
                        ),
                        shape: const RoundedRectangleBorder(
                          borderRadius: AppRadius.radiusFull,
                        ),
                        elevation: 0,
                      ),
                      child: bookingCtrl.isSubmitting.value
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                            )
                          : const Row(
                              children: [
                                Icon(Icons.lock_outline, size: 16),
                                SizedBox(width: 6),
                                Text(
                                  'Confirm & Book',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
