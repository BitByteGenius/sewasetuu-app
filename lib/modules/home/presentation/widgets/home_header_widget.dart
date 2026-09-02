import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../app/routes/app_routes.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_radius.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../core/services/location_service.dart';
import '../../../../core/services/notification_service.dart';

/// Top App Header with Greeting, Location Selector trigger modal, and Notification count indicator.
class HomeHeaderWidget extends StatelessWidget {
  const HomeHeaderWidget({super.key});

  void _showCitySelector(BuildContext context, LocationService locationService) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    showModalBottomSheet(
      context: context,
      backgroundColor: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
      shape: const RoundedRectangleBorder(borderRadius: AppRadius.topXxl),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: AppSpacing.edgeInsetsLg,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Select City / Region',
                  style: AppTextStyles.headlineSmall(isDark),
                ),
                AppSpacing.gapV16,
                ...locationService.availableCities.map((city) {
                  final isSelected = locationService.selectedCity.value == city;
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(
                      Icons.location_city_rounded,
                      color: isSelected ? (isDark ? AppColors.primaryLight : AppColors.primary) : null,
                    ),
                    title: Text(
                      city,
                      style: AppTextStyles.bodyLarge(isDark).copyWith(
                        fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                        color: isSelected ? (isDark ? AppColors.primaryLight : AppColors.primary) : null,
                      ),
                    ),
                    trailing: isSelected
                        ? Icon(Icons.check_circle_rounded, color: isDark ? AppColors.primaryLight : AppColors.primary)
                        : null,
                    onTap: () {
                      locationService.updateCity(city);
                      Navigator.pop(context);
                    },
                  );
                }),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final locationService = Get.find<LocationService>();
    final notificationService = Get.find<NotificationService>();

    return Padding(
      padding: AppSpacing.screenPadding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Greeting & Location
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Good day 👋',
                  style: AppTextStyles.bodySmall(isDark).copyWith(
                    color: isDark ? AppColors.textMutedDark : AppColors.textMutedLight,
                  ),
                ),
                AppSpacing.gapV4,
                GestureDetector(
                  onTap: () => _showCitySelector(context, locationService),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.location_on_rounded,
                        size: 18,
                        color: isDark ? AppColors.primaryLight : AppColors.primary,
                      ),
                      const SizedBox(width: 4),
                      Flexible(
                        child: Obx(() {
                          return Text(
                            locationService.selectedCity.value,
                            style: AppTextStyles.titleMedium(isDark).copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          );
                        }),
                      ),
                      const SizedBox(width: 4),
                      Icon(
                        Icons.keyboard_arrow_down_rounded,
                        size: 18,
                        color: isDark ? AppColors.textMutedDark : AppColors.textMutedLight,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Notification Bell
          GestureDetector(
            onTap: () => Get.toNamed(AppRoutes.notifications),
            child: Stack(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.surfaceVariantDark : AppColors.surfaceVariantLight,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isDark ? AppColors.borderDark : AppColors.borderLight,
                    ),
                  ),
                  child: Icon(
                    Icons.notifications_outlined,
                    size: 22,
                    color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                  ),
                ),
                Obx(() {
                  final unread = notificationService.unreadCount;
                  if (unread == 0) return const SizedBox.shrink();
                  return Positioned(
                    top: 2,
                    right: 2,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: AppColors.error,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        unread.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
