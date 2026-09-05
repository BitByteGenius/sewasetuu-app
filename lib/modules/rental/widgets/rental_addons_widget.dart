import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_radius.dart';
import '../../../app/theme/app_spacing.dart';
import '../../../app/theme/app_text_styles.dart';
import '../controllers/rental_booking_controller.dart';

/// Interactive add-ons and protection selector list during checkout.
class RentalAddonsWidget extends StatelessWidget {
  const RentalAddonsWidget({super.key});

  IconData _resolveAddonIcon(String iconName) {
    switch (iconName) {
      case 'verified_user':
        return Icons.verified_user_rounded;
      case 'local_shipping':
        return Icons.local_shipping_rounded;
      case 'sports_motorsports':
        return Icons.sports_motorsports_rounded;
      case 'shield':
        return Icons.shield_rounded;
      case 'child_friendly':
        return Icons.child_friendly_rounded;
      case 'group_add':
        return Icons.group_add_rounded;
      case 'phone_android':
        return Icons.phone_android_rounded;
      default:
        return Icons.extension_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bookingCtrl = Get.find<RentalBookingController>();

    return Obx(() {
      final addons = bookingCtrl.availableAddons;
      final durationDays = bookingCtrl.durationDays;

      if (addons.isEmpty) {
        return const SizedBox.shrink();
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'PROTECTION & ADD-ONS',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.7,
              color: isDark ? AppColors.textMutedDark : AppColors.textSecondaryLight,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          ...addons.map((addon) {
            final isSelected = bookingCtrl.isAddonSelected(addon.id);
            final cost = addon.calculateCost(durationDays);

            return Container(
              margin: const EdgeInsets.only(bottom: AppSpacing.sm),
              decoration: BoxDecoration(
                color: isSelected
                    ? (isDark
                        ? AppColors.primaryContainerDark.withAlpha((255 * 0.4).round())
                        : AppColors.primaryContainer.withAlpha((255 * 0.35).round()))
                    : (isDark ? AppColors.surfaceDark : AppColors.surfaceLight),
                borderRadius: AppRadius.radiusLg,
                border: Border.all(
                  color: isSelected
                      ? AppColors.primary
                      : (isDark ? AppColors.borderDark : AppColors.borderLight),
                  width: isSelected ? 1.5 : 1.0,
                ),
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => bookingCtrl.toggleAddon(addon),
                  borderRadius: AppRadius.radiusLg,
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(AppSpacing.sm),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.primary
                                : (isDark ? AppColors.surfaceVariantDark : AppColors.surfaceVariantLight),
                            borderRadius: AppRadius.radiusMd,
                          ),
                          child: Icon(
                            _resolveAddonIcon(addon.iconName),
                            size: 20,
                            color: isSelected ? Colors.white : AppColors.primary,
                          ),
                        ),
                        const SizedBox(width: AppSpacing.md),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      addon.name,
                                      style: AppTextStyles.titleMedium(isDark).copyWith(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    addon.oneTimeFee > 0
                                        ? '₹${cost.toInt()} flat'
                                        : '₹${addon.pricePerDay.toInt()}/day',
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w800,
                                      color: isSelected ? AppColors.primary : null,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 3),
                              Text(
                                addon.description,
                                style: TextStyle(
                                  fontSize: 12,
                                  height: 1.3,
                                  color: isDark ? AppColors.textMutedDark : AppColors.textSecondaryLight,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        Checkbox(
                          value: isSelected,
                          activeColor: AppColors.primary,
                          shape: const RoundedRectangleBorder(
                            borderRadius: AppRadius.radiusXs,
                          ),
                          onChanged: (_) => bookingCtrl.toggleAddon(addon),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
        ],
      );
    });
  }
}
