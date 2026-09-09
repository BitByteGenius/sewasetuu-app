import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sewasetu/app/theme/app_colors.dart';
import 'package:sewasetu/modules/home/bindings/home_binding.dart';
import 'package:sewasetu/modules/home/controllers/home_controller.dart';
import 'package:sewasetu/modules/home/widgets/service_tab.dart';
import 'package:sewasetu/modules/rental/screens/rentals_screen.dart';
import 'package:sewasetu/modules/shop/screens/shop_screen.dart';
import 'package:sewasetu/modules/stay/screens/stay_screen.dart';
import 'package:sewasetu/modules/trips/screens/trips_screen.dart';

/// Main Marketplace Home Page with sticky Swiggy-Style Service Switcher.
/// The 4 primary services (Stay, Tours & Trips, Shop, Vehicle Rental)
/// behave like tabs, switching between each module's primary screen in-place.
class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  HomeController get controller {
    if (!Get.isRegistered<HomeController>()) {
      HomeBinding().dependencies();
    }
    return super.controller;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
        ),
        child: Column(
          children: [
            // 1. Sticky Service Tab Header (Location, Switcher & Dynamic Search Bar)
            const ServiceTab(),

            // 2. Service Tab Screens (Stay, Tours & Trips, Shop, Vehicle Rental)
            Expanded(
              child: MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: Obx(() {
                  return IndexedStack(
                    index: controller.selectedService.value.index,
                    children: const [
                      StayScreen(),
                      TripsScreen(),
                      ShopScreen(),
                      RentalScreen(),
                    ],
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

typedef HomePage = HomeScreen;
