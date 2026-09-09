import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sewasetu/app/theme/app_colors.dart';
import '../controllers/rental_navigation_controller.dart';
import 'rental_navigation_item.dart';

/// Cockpit-styled floating navigation bar for the Vehicle Rental module
class RentalNavigationBar extends StatelessWidget {
  final RentalNavigationController controller;

  const RentalNavigationBar({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
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
                  final currentIndex = controller.currentIndex.value;

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      // 0: Explore
                      RentalNavigationItem(
                        outlineIcon: Icons.explore_outlined,
                        activeIcon: Icons.explore_rounded,
                        label: 'Explore',
                        isSelected: currentIndex == 0,
                        onTap: () => controller.changeTab(0),
                        activeColor: themeAccent,
                      ),

                      // 1: Vehicles
                      RentalNavigationItem(
                        outlineIcon: Icons.directions_car_outlined,
                        activeIcon: Icons.directions_car_rounded,
                        label: 'Vehicles',
                        isSelected: currentIndex == 1,
                        onTap: () => controller.changeTab(1),
                        activeColor: themeAccent,
                      ),

                      // 2: Bookings
                      RentalNavigationItem(
                        outlineIcon: Icons.calendar_month_outlined,
                        activeIcon: Icons.calendar_month_rounded,
                        label: 'Bookings',
                        isSelected: currentIndex == 2,
                        onTap: () => controller.changeTab(2),
                        activeColor: themeAccent,
                      ),

                      // 3: Favorites
                      RentalNavigationItem(
                        outlineIcon: Icons.favorite_outline_rounded,
                        activeIcon: Icons.favorite_rounded,
                        label: 'Favorites',
                        isSelected: currentIndex == 3,
                        onTap: () => controller.changeTab(3),
                        activeColor: themeAccent,
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
