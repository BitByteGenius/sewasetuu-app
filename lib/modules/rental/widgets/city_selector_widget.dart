import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_radius.dart';
import '../../../app/theme/app_spacing.dart';
import '../../../app/theme/app_text_styles.dart';
import '../bindings/rental_binding.dart';
import '../controllers/rental_city_controller.dart';
import '../screens/cities_screen.dart';

/// Interactive city selector button / badge displayed in headers and search bars.
class CitySelectorWidget extends StatelessWidget {
  final bool isCompact;
  final VoidCallback? onTap;

  const CitySelectorWidget({
    super.key,
    this.isCompact = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    RentalBinding.ensureInitialized();
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cityCtrl = Get.find<RentalCityController>();

    return Obx(() {
      final city = cityCtrl.selectedCity.value;
      final cityName = city?.name ?? 'Select City';
      final stateName = city?.state ?? '';

      return Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap ?? () => Get.to(() => const CitiesScreen()),
          borderRadius: AppRadius.radiusFull,
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: isCompact ? AppSpacing.md : AppSpacing.lg,
              vertical: isCompact ? AppSpacing.xs + 2 : AppSpacing.sm + 2,
            ),
            decoration: BoxDecoration(
              color: isDark
                  ? AppColors.surfaceVariantDark.withAlpha((255 * 0.7).round())
                  : AppColors.primaryContainer.withAlpha((255 * 0.55).round()),
              borderRadius: AppRadius.radiusFull,
              border: Border.all(
                color: isDark ? AppColors.borderDark : AppColors.primaryLight.withAlpha((255 * 0.3).round()),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.location_on,
                  size: 18,
                  color: AppColors.primary,
                ),
                const SizedBox(width: AppSpacing.xs),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (!isCompact && stateName.isNotEmpty)
                      Text(
                        'RENTAL CITY',
                        style: TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.8,
                          color: isDark ? AppColors.textMutedDark : AppColors.textSecondaryLight,
                        ),
                      ),
                    Text(
                      cityName,
                      style: (isCompact
                              ? AppTextStyles.titleMedium(isDark)
                              : AppTextStyles.titleLarge(isDark))
                          .copyWith(
                        fontWeight: FontWeight.w700,
                        color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: AppSpacing.xs),
                Icon(
                  Icons.keyboard_arrow_down_rounded,
                  size: 20,
                  color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
