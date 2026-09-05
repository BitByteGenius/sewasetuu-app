import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_radius.dart';
import '../../../app/theme/app_shadows.dart';
import '../../../app/theme/app_spacing.dart';
import '../../../app/theme/app_text_styles.dart';
import '../controllers/rental_booking_controller.dart';
import 'rental_bookings_screen.dart';
import 'rentals_screen.dart';

/// Celebration and confirmation screen presented upon successful vehicle reservation.
class RentalConfirmationScreen extends StatelessWidget {
  const RentalConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bookingCtrl = Get.find<RentalBookingController>();
    final booking = bookingCtrl.confirmedBooking.value;

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: AppSpacing.xl),

              // 1. Animated Success Icon
              Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  color: AppColors.successLight,
                  shape: BoxShape.circle,
                  boxShadow: AppShadows.floating,
                ),
                child: const Icon(
                  Icons.check_circle_rounded,
                  size: 56,
                  color: AppColors.success,
                ),
              ),

              const SizedBox(height: AppSpacing.lg),

              // 2. Title & Booking ID
              Text(
                'Booking Confirmed!',
                style: AppTextStyles.headlineLarge(isDark).copyWith(
                  fontWeight: FontWeight.w800,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                'Your vehicle has been reserved successfully.',
                style: TextStyle(
                  fontSize: 13,
                  color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                ),
              ),
              const SizedBox(height: AppSpacing.md),

              if (booking != null)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
                    borderRadius: AppRadius.radiusFull,
                    border: Border.all(
                      color: isDark ? AppColors.borderDark : AppColors.borderLight,
                    ),
                  ),
                  child: Text(
                    'Booking ID: ${booking.bookingNumber}',
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.8,
                      color: AppColors.primary,
                    ),
                  ),
                ),

              const SizedBox(height: AppSpacing.xl),

              // 3. Trip Summary Card
              if (booking != null) ...[
                Container(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
                    borderRadius: AppRadius.radiusXl,
                    boxShadow: AppShadows.soft,
                    border: Border.all(
                      color: isDark ? AppColors.borderDark : AppColors.borderLight,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            booking.vehicle?.fullName ?? 'Reserved Vehicle',
                            style: AppTextStyles.titleMedium(isDark).copyWith(
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: AppColors.successLight,
                              borderRadius: AppRadius.radiusXs,
                            ),
                            child: const Text(
                              'CONFIRMED',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w800,
                                color: Color(0xFF065F46),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      const Divider(height: 1),
                      const SizedBox(height: AppSpacing.sm),
                      _buildRow(isDark, 'City', booking.cityName),
                      _buildRow(
                        isDark,
                        'Pickup',
                        '${booking.pickupDateTime.day}/${booking.pickupDateTime.month}, ${booking.pickupDateTime.hour.toString().padLeft(2, "0")}:${booking.pickupDateTime.minute.toString().padLeft(2, "0")}',
                      ),
                      _buildRow(
                        isDark,
                        'Return',
                        '${booking.returnDateTime.day}/${booking.returnDateTime.month}, ${booking.returnDateTime.hour.toString().padLeft(2, "0")}:${booking.returnDateTime.minute.toString().padLeft(2, "0")}',
                      ),
                      _buildRow(isDark, 'Location', booking.pickupLocation),
                      _buildRow(
                        isDark,
                        'Paid Total',
                        '₹${booking.pricing.totalPayable.toInt()}',
                        color: AppColors.primary,
                        isBold: true,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: AppSpacing.lg),

                // 4. Pickup Guidance Note
                Container(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  decoration: BoxDecoration(
                    color: (isDark ? AppColors.surfaceVariantDark : AppColors.primaryContainer)
                        .withAlpha((255 * 0.4).round()),
                    borderRadius: AppRadius.radiusLg,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.directions_car_outlined, size: 16, color: AppColors.primary),
                          SizedBox(width: 6),
                          Text(
                            'WHAT NEXT?',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w800,
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        '1. Please carry your original Driving License and valid Government Photo ID.\n'
                        '2. Contact our SewaSetu Hub Manager at +91 98765 43210 for airport/station coordination.\n'
                        '3. A digital inspection checklist will be signed upon handover.',
                        style: TextStyle(
                          fontSize: 12,
                          height: 1.4,
                          color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                        ),
                      ),
                    ],
                  ),
                ),
              ],

              const SizedBox(height: AppSpacing.xxl),

              // 5. Action Buttons
              ElevatedButton(
                onPressed: () {
                  Get.off(() => const RentalBookingsScreen());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  minimumSize: const Size.fromHeight(50),
                  shape: const RoundedRectangleBorder(
                    borderRadius: AppRadius.radiusFull,
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'View My Bookings',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                ),
              ),

              const SizedBox(height: AppSpacing.sm),

              OutlinedButton(
                onPressed: () {
                  Get.offAll(() => const RentalScreen());
                },
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  shape: const RoundedRectangleBorder(
                    borderRadius: AppRadius.radiusFull,
                  ),
                  side: BorderSide(
                    color: isDark ? AppColors.borderDark : AppColors.borderLight,
                  ),
                ),
                child: const Text(
                  'Back to Rental Home',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRow(bool isDark, String label, String value, {Color? color, bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: isDark ? AppColors.textMutedDark : AppColors.textSecondaryLight,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 13,
              fontWeight: isBold ? FontWeight.w800 : FontWeight.w600,
              color: color ?? (isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight),
            ),
          ),
        ],
      ),
    );
  }
}
