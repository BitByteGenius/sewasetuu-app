import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sewasetu/app/routes/app_routes.dart';
import 'package:sewasetu/app/theme/app_colors.dart';
import 'package:sewasetu/app/theme/app_radius.dart';
import 'package:sewasetu/app/theme/app_spacing.dart';
import 'package:sewasetu/app/theme/app_text_styles.dart';
import 'package:sewasetu/core/services/location_service.dart';
import 'package:sewasetu/modules/home/presentation/controllers/home_controller.dart';
import 'package:sewasetu/modules/home/presentation/widgets/location_selector_modal.dart';
import 'package:sewasetu/shared/widgets/app_network_image.dart';

/// Top Header with Interactive Location Selector, Notification Bell with badge, and Profile Avatar
class HomeHeaderWidget extends StatelessWidget {
  const HomeHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final locationService = Get.find<LocationService>();
    final homeController = Get.find<HomeController>();

    return Padding(
      padding: AppSpacing.screenPadding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Location Selector
          Expanded(
            child: GestureDetector(
              onTap: () => LocationSelectorModal.show(context),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: isDark ? AppColors.surfaceVariantDark : AppColors.primaryContainer,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.location_on_rounded,
                      size: 20,
                      color: isDark ? AppColors.primaryLight : AppColors.primary,
                    ),
                  ),
                  AppSpacing.gapH8,
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Location',
                              style: AppTextStyles.labelSmall(isDark),
                            ),
                            const SizedBox(width: 4),
                            Icon(
                              Icons.keyboard_arrow_down_rounded,
                              size: 16,
                              color: isDark ? AppColors.textMutedDark : AppColors.textMutedLight,
                            ),
                          ],
                        ),
                        Obx(() {
                          return Text(
                            locationService.selectedCity.value,
                            style: AppTextStyles.titleMedium(isDark).copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          );
                        }),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          AppSpacing.gapH12,

          // Notification Bell with badge
          GestureDetector(
            onTap: () => Get.toNamed(AppRoutes.notifications),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
                shape: BoxShape.circle,
                border: Border.all(
                  color: isDark ? AppColors.borderDark : AppColors.borderLight,
                ),
              ),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Icon(
                    Icons.notifications_outlined,
                    size: 20,
                    color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                  ),
                  Obx(() {
                    if (homeController.unreadNotificationCount.value > 0) {
                      return Positioned(
                        top: -2,
                        right: -2,
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: AppColors.secondary,
                            shape: BoxShape.circle,
                          ),
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  }),
                ],
              ),
            ),
          ),
          AppSpacing.gapH8,

          // Profile Avatar (Tap opens Profile tab)
          GestureDetector(
            onTap: () => homeController.switchNavTab(4),
            child: ClipRRect(
              borderRadius: AppRadius.radiusPill,
              child: const AppNetworkImage(
                imageUrl: 'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?auto=format&fit=crop&w=120&q=80',
                width: 38,
                height: 38,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
