import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sewasetu/app/theme/app_colors.dart';
import 'package:sewasetu/app/theme/app_radius.dart';
import 'package:sewasetu/app/theme/app_spacing.dart';
import 'package:sewasetu/app/theme/app_text_styles.dart';
import 'package:sewasetu/core/services/location_service.dart';
import 'package:sewasetu/shared/widgets/app_bottom_sheet.dart';

/// Modal bottom sheet for choosing user city location
class LocationSelectorModal extends StatelessWidget {
  const LocationSelectorModal({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const LocationSelectorModal(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final locationService = Get.find<LocationService>();

    return AppBottomSheet(
      title: 'Select City / Location',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Use Current GPS Location option
          InkWell(
            onTap: () async {
              await locationService.useCurrentGpsLocation();
              if (context.mounted) Navigator.of(context).pop();
            },
            borderRadius: AppRadius.radiusMd,
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: isDark ? AppColors.surfaceVariantDark : AppColors.primaryContainer.withAlpha(80),
                borderRadius: AppRadius.radiusMd,
                border: Border.all(
                  color: isDark ? AppColors.borderDark : AppColors.primaryLight.withAlpha(100),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.my_location_rounded,
                    color: isDark ? AppColors.primaryLight : AppColors.primary,
                  ),
                  AppSpacing.gapH12,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Use Current Location',
                          style: AppTextStyles.titleMedium(isDark).copyWith(
                            fontWeight: FontWeight.w700,
                            color: isDark ? AppColors.primaryLight : AppColors.primary,
                          ),
                        ),
                        Text(
                          'GPS automatic location detection',
                          style: AppTextStyles.bodySmall(isDark),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          AppSpacing.gapV24,

          Text(
            'Supported Cities & Regions',
            style: AppTextStyles.labelMedium(isDark).copyWith(
              fontWeight: FontWeight.w700,
              color: isDark ? AppColors.textMutedDark : AppColors.textMutedLight,
            ),
          ),
          AppSpacing.gapV12,

          // Cities List
          ...LocationService.popularCities.map((city) {
            return Obx(() {
              final isSelected = locationService.selectedCity.value == city;

              return ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                leading: Icon(
                  Icons.location_city_rounded,
                  color: isSelected
                      ? (isDark ? AppColors.primaryLight : AppColors.primary)
                      : (isDark ? AppColors.textMutedDark : AppColors.textMutedLight),
                ),
                title: Text(
                  city,
                  style: AppTextStyles.titleMedium(isDark).copyWith(
                    fontWeight: isSelected ? FontWeight.w800 : FontWeight.w500,
                    color: isSelected
                        ? (isDark ? AppColors.primaryLight : AppColors.primary)
                        : null,
                  ),
                ),
                trailing: isSelected
                    ? Icon(
                        Icons.check_circle_rounded,
                        color: isDark ? AppColors.primaryLight : AppColors.primary,
                      )
                    : null,
                onTap: () {
                  locationService.setCity(city);
                  Navigator.of(context).pop();
                },
              );
            });
          }),
        ],
      ),
    );
  }
}
