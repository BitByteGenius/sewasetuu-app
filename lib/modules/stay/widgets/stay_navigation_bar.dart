import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sewasetu/app/theme/app_colors.dart';
import 'package:sewasetu/modules/stay/controllers/stay_navigation_controller.dart';
import 'stay_navigation_item.dart';

/// Premium floating navigation bar for the Stay module
class StayNavigationBar extends StatelessWidget {
  const StayNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final controller = Get.isRegistered<StayNavigationController>()
        ? Get.find<StayNavigationController>()
        : Get.put(StayNavigationController());

    final themeAccent = isDark ? AppColors.primaryLight : AppColors.primary;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Container(
          height: 66,
          decoration: BoxDecoration(
            color: isDark
                ? AppColors.surfaceDark.withValues(alpha: 0.96)
                : AppColors.surfaceLight.withValues(alpha: 0.96),
            borderRadius: BorderRadius.circular(33),
            border: Border.all(
              color: isDark
                  ? themeAccent.withValues(alpha: 0.25)
                  : themeAccent.withValues(alpha: 0.16),
              width: 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: themeAccent.withValues(alpha: isDark ? 0.14 : 0.08),
                blurRadius: 18,
                offset: const Offset(0, 6),
                spreadRadius: 1,
              ),
              BoxShadow(
                color: Colors.black.withValues(alpha: isDark ? 0.35 : 0.06),
                blurRadius: 12,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(33),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                child: Obx(() {
                  final activeIndex = controller.selectedIndex.value;
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      StayNavigationItem(
                        outlineIcon: Icons.explore_outlined,
                        activeIcon: Icons.explore_rounded,
                        label: 'Explore',
                        isSelected: activeIndex == 0,
                        onTap: () => controller.changeTab(0),
                      ),
                      StayNavigationItem(
                        outlineIcon: Icons.search_outlined,
                        activeIcon: Icons.search_rounded,
                        label: 'Search',
                        isSelected: activeIndex == 1,
                        onTap: () => controller.changeTab(1),
                      ),
                      StayNavigationItem(
                        outlineIcon: Icons.favorite_border_rounded,
                        activeIcon: Icons.favorite_rounded,
                        label: 'Saved',
                        isSelected: activeIndex == 2,
                        onTap: () => controller.changeTab(2),
                      ),
                      StayNavigationItem(
                        outlineIcon: Icons.calendar_month_outlined,
                        activeIcon: Icons.calendar_month_rounded,
                        label: 'Bookings',
                        isSelected: activeIndex == 3,
                        onTap: () => controller.changeTab(3),
                      ),
                    ],
                  );
                }),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
