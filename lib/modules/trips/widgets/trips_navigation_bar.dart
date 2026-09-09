import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sewasetu/app/theme/app_colors.dart';
import 'package:sewasetu/modules/trips/controllers/trips_navigation_controller.dart';
import 'trips_navigation_item.dart';

/// Adventurous curved floating navigation bar for the Tours & Trips module
class TripsNavigationBar extends StatelessWidget {
  const TripsNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final controller = Get.isRegistered<TripsNavigationController>()
        ? Get.find<TripsNavigationController>()
        : Get.put(TripsNavigationController());

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
                      TripsNavigationItem(
                        outlineIcon: Icons.explore_outlined,
                        activeIcon: Icons.explore_rounded,
                        label: 'Discover',
                        isSelected: activeIndex == 0,
                        onTap: () => controller.changeTab(0),
                      ),
                      TripsNavigationItem(
                        outlineIcon: Icons.map_outlined,
                        activeIcon: Icons.map_rounded,
                        label: 'Destinations',
                        isSelected: activeIndex == 1,
                        onTap: () => controller.changeTab(1),
                      ),
                      TripsNavigationItem(
                        outlineIcon: Icons.flight_takeoff_outlined,
                        activeIcon: Icons.flight_takeoff_rounded,
                        label: 'My Trips',
                        isSelected: activeIndex == 2,
                        onTap: () => controller.changeTab(2),
                      ),
                      TripsNavigationItem(
                        outlineIcon: Icons.bookmark_border_rounded,
                        activeIcon: Icons.bookmark_rounded,
                        label: 'Saved',
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
