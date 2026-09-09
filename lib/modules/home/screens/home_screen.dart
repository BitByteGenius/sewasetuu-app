import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sewasetu/app/theme/app_colors.dart';
import 'package:sewasetu/modules/home/bindings/home_binding.dart';
import 'package:sewasetu/modules/home/controllers/home_controller.dart';
import 'package:sewasetu/modules/home/widgets/home_location_header_widget.dart';
import 'package:sewasetu/modules/home/widgets/service_tab.dart';
import 'package:sewasetu/modules/rental/screens/rentals_screen.dart';
import 'package:sewasetu/modules/shop/screens/shop_screen.dart';
import 'package:sewasetu/modules/stay/screens/stay_screen.dart';
import 'package:sewasetu/modules/trips/screens/trips_screen.dart';

/// Main Marketplace Home Page with sticky Location Header.
/// Only the location header remains sticky at the top, while the service switcher,
/// search bar, and module screen content scroll smoothly underneath.
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
            // 1. Only Home Location Header remains sticky at the very top
            Container(
              decoration: const BoxDecoration(
                color: Color(0xFF090D16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: const SafeArea(
                bottom: false,
                child: Padding(
                  padding: EdgeInsets.only(top: 6, bottom: 4),
                  child: HomeLocationHeaderWidget(),
                ),
              ),
            ),

            // 2. Rest of the content (Service Switcher, Search Bar & Tabs) scrolls
            Expanded(
              child: NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) {
                  return [
                    const SliverToBoxAdapter(
                      child: ServiceTab(),
                    ),
                  ];
                },
                body: MediaQuery.removePadding(
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
            ),
          ],
        ),
      ),
    );
  }
}

typedef HomePage = HomeScreen;
