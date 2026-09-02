import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sewasetu/app/theme/app_colors.dart';
import 'package:sewasetu/app/theme/app_shadows.dart';
import 'package:sewasetu/modules/bookings/bookings.dart';
import 'package:sewasetu/modules/home/controllers/home_controller.dart';
import 'package:sewasetu/modules/home/screens/home_screen.dart';
import 'package:sewasetu/modules/profile/profile.dart';
import 'package:sewasetu/modules/stay/stay.dart';
import 'package:sewasetu/modules/wishlist/wishlist.dart';

/// Root App Shell hosting persistent bottom navigation bar across primary features.
class MainNavigationShell extends GetView<HomeController> {
  const MainNavigationShell({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final pages = const [
      HomeScreen(),
      StayScreen(),
      BookingsScreen(),
      WishlistScreen(),
      ProfileScreen(),
    ];

    return Scaffold(
      body: Obx(() {
        return IndexedStack(
          index: controller.selectedNavIndex.value,
          children: pages,
        );
      }),
      bottomNavigationBar: Obx(() {
        return Container(
          decoration: BoxDecoration(
            color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
            boxShadow: isDark ? AppShadows.darkCard : AppShadows.bottomNav,
            border: Border(
              top: BorderSide(
                color: isDark ? AppColors.borderDark : AppColors.borderLight,
                width: 1,
              ),
            ),
          ),
          child: NavigationBar(
            selectedIndex: controller.selectedNavIndex.value,
            onDestinationSelected: controller.switchNavTab,
            backgroundColor: Colors.transparent,
            elevation: 0,
            indicatorColor: isDark
                ? AppColors.primaryContainerDark
                : AppColors.primaryContainer,
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.home_outlined),
                selectedIcon: Icon(Icons.home_rounded, color: AppColors.primary),
                label: 'Home',
              ),
              NavigationDestination(
                icon: Icon(Icons.apartment_outlined),
                selectedIcon: Icon(Icons.apartment_rounded, color: AppColors.primary),
                label: 'Stays',
              ),
              NavigationDestination(
                icon: Icon(Icons.calendar_today_outlined),
                selectedIcon: Icon(Icons.calendar_today_rounded, color: AppColors.primary),
                label: 'Bookings',
              ),
              NavigationDestination(
                icon: Icon(Icons.favorite_border_rounded),
                selectedIcon: Icon(Icons.favorite_rounded, color: AppColors.primary),
                label: 'Wishlist',
              ),
              NavigationDestination(
                icon: Icon(Icons.person_outline_rounded),
                selectedIcon: Icon(Icons.person_rounded, color: AppColors.primary),
                label: 'Profile',
              ),
            ],
          ),
        );
      }),
    );
  }
}
