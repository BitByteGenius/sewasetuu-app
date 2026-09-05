import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_radius.dart';
import '../../../app/theme/app_spacing.dart';
import '../../../app/theme/app_text_styles.dart';
import '../controllers/rental_booking_controller.dart';

/// Interactive selector for Hub Self-Pickup versus Doorstep Delivery & Return.
class PickupDropoffWidget extends StatelessWidget {
  final bool isBookingCheckout;

  const PickupDropoffWidget({
    super.key,
    this.isBookingCheckout = true,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bookingCtrl = Get.find<RentalBookingController>();

    return Obx(() {
      final isDoorstep = bookingCtrl.isDoorstepDelivery.value;

      return Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
          borderRadius: AppRadius.radiusLg,
          border: Border.all(
            color: isDark ? AppColors.borderDark : AppColors.borderLight,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'PICKUP & DELIVERY MODE',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.6,
                color: isDark ? AppColors.textMutedDark : AppColors.textSecondaryLight,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),

            // Mode Selector: Self-Pickup Hub vs Doorstep
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () => bookingCtrl.toggleDoorstepDelivery(false),
                    borderRadius: AppRadius.radiusMd,
                    child: Container(
                      padding: const EdgeInsets.all(AppSpacing.sm + 2),
                      decoration: BoxDecoration(
                        color: !isDoorstep
                            ? AppColors.primary.withAlpha((255 * 0.12).round())
                            : (isDark ? AppColors.surfaceVariantDark : AppColors.surfaceVariantLight),
                        borderRadius: AppRadius.radiusMd,
                        border: Border.all(
                          color: !isDoorstep ? AppColors.primary : Colors.transparent,
                          width: 1.5,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              Icon(Icons.storefront_outlined, size: 16, color: AppColors.primary),
                              SizedBox(width: 4),
                              Text(
                                'Hub Pickup',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'FREE at City Hub',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: isDark ? AppColors.textMutedDark : AppColors.textSecondaryLight,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: AppSpacing.sm),

                Expanded(
                  child: InkWell(
                    onTap: () => bookingCtrl.toggleDoorstepDelivery(true),
                    borderRadius: AppRadius.radiusMd,
                    child: Container(
                      padding: const EdgeInsets.all(AppSpacing.sm + 2),
                      decoration: BoxDecoration(
                        color: isDoorstep
                            ? AppColors.primary.withAlpha((255 * 0.12).round())
                            : (isDark ? AppColors.surfaceVariantDark : AppColors.surfaceVariantLight),
                        borderRadius: AppRadius.radiusMd,
                        border: Border.all(
                          color: isDoorstep ? AppColors.primary : Colors.transparent,
                          width: 1.5,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              Icon(Icons.local_shipping_outlined, size: 16, color: AppColors.primary),
                              SizedBox(width: 4),
                              Text(
                                'Doorstep',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 2),
                          Text(
                            '+₹399 Convenience',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: isDark ? AppColors.textMutedDark : AppColors.textSecondaryLight,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: AppSpacing.md),

            // Location description or text field
            if (isDoorstep) ...[
              TextField(
                onChanged: (val) => bookingCtrl.deliveryAddress.value = val,
                decoration: InputDecoration(
                  labelText: 'Delivery & Pickup Address',
                  hintText: 'Enter your hotel, residence or airport address',
                  prefixIcon: const Icon(Icons.pin_drop_outlined, size: 20),
                  filled: true,
                  fillColor: isDark ? AppColors.surfaceVariantDark : AppColors.surfaceVariantLight,
                  border: OutlineInputBorder(
                    borderRadius: AppRadius.radiusMd,
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                ),
                style: AppTextStyles.bodyMedium(isDark),
              ),
            ] else ...[
              Container(
                padding: const EdgeInsets.all(AppSpacing.sm),
                decoration: BoxDecoration(
                  color: isDark ? AppColors.surfaceVariantDark : AppColors.surfaceVariantLight,
                  borderRadius: AppRadius.radiusMd,
                ),
                child: Row(
                  children: [
                    const Icon(Icons.info_outline, size: 16, color: AppColors.info),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: Text(
                        'Pickup from: SewaSetu Hub, Paltan Bazar / Airport Counter. Detailed instructions sent upon booking.',
                        style: TextStyle(
                          fontSize: 11,
                          color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      );
    });
  }
}
