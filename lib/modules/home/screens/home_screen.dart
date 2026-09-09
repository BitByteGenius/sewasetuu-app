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
      body: Obx(() {
        final isMainFeed = controller.isMainFeedActive;

        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: isMainFeed ? Brightness.light : (isDark ? Brightness.light : Brightness.dark),
            statusBarBrightness: isMainFeed ? Brightness.dark : (isDark ? Brightness.dark : Brightness.light),
          ),
          child: Column(
            children: [
              // 1. Sticky Location Header - slot 0 is never shifted, avoiding child re-indexing
              isMainFeed
                  ? _buildStickyLocationHeader()
                  : const SizedBox.shrink(),

              // 2. Main Content
              // NestedScrollView is permanently mounted so the 4 heavy module screens
              // (StayScreen, TripsScreen, ShopScreen, RentalScreen) are NEVER unmounted
              // or re-inflated when switching tabs.
              Expanded(
                key: const ValueKey('home_main_expanded'),
                child: NestedScrollView(
                  key: const ValueKey('home_nested_scroll_view'),
                  headerSliverBuilder: (context, innerBoxIsScrolled) {
                    if (!isMainFeed) {
                      return const [];
                    }
                    return const [
                      SliverToBoxAdapter(
                        child: ServiceTab(),
                      ),
                    ];
                  },
                  body: MediaQuery.removePadding(
                    context: context,
                    removeTop: isMainFeed,
                    child: _buildServiceStack(),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildStickyLocationHeader() {
    return Container(
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
    );
  }

  Widget _buildServiceStack() {
    return RepaintBoundary(
      child: Obx(() {
        return IndexedStack(
          key: const ValueKey('service_stack_indexed'),
          index: controller.selectedService.value.index,
          children: const [
            StayScreen(),
            TripsScreen(),
            ShopScreen(),
            RentalScreen(),
          ],
        );
      }),
    );
  }
}

typedef HomePage = HomeScreen;
