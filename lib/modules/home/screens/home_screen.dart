import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sewasetu/app/routes/app_routes.dart';
import 'package:sewasetu/app/theme/app_colors.dart';
import 'package:sewasetu/app/theme/app_spacing.dart';
import 'package:sewasetu/core/services/location_service.dart';
import 'package:sewasetu/modules/home/bindings/home_binding.dart';
import 'package:sewasetu/modules/home/controllers/home_controller.dart';
import 'package:sewasetu/modules/home/widgets/featured_stays_carousel_widget.dart';
import 'package:sewasetu/modules/home/widgets/home_dynamic_search_bar_widget.dart';
import 'package:sewasetu/modules/home/widgets/home_location_header_widget.dart';
import 'package:sewasetu/modules/home/widgets/home_service_switcher_widget.dart';
import 'package:sewasetu/modules/home/widgets/nearby_stays_widget.dart';
import 'package:sewasetu/modules/home/widgets/popular_destinations_widget.dart';
import 'package:sewasetu/modules/home/widgets/recently_viewed_widget.dart';
import 'package:sewasetu/modules/home/widgets/recommended_stays_widget.dart';
import 'package:sewasetu/modules/home/widgets/secondary_services_widget.dart';
import 'package:sewasetu/modules/home/widgets/service_tab.dart';
import 'package:sewasetu/modules/home/widgets/stay_category_selector_widget.dart';
import 'package:sewasetu/shared/enums/view_state.dart';
import 'package:sewasetu/shared/widgets/app_skeleton.dart';

/// Main Marketplace Home Page with Swiggy-Style Service Switcher.
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
    final locationService = Get.find<LocationService>();

    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
        ),
        child: RefreshIndicator(
          onRefresh: controller.loadHomeData,
          color: isDark ? AppColors.primaryLight : AppColors.primary,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // This section remains fully scrollable with the page content!
                const ServiceTab(),
                AppSpacing.gapV20,

                // 2. Primary Stay Categories (Rooms, PG, Mess, Homestay, Hotel)
                StayCategorySelectorWidget(
                  onCategorySelected: controller.onSelectStayType,
                ),
                AppSpacing.gapV24,

                // 3. State-driven Content (Featured + Recommended + Nearby + Destinations + Recently Viewed)
                Obx(() {
                  if (controller.state.value == ViewState.loading) {
                    return Padding(
                      padding: AppSpacing.screenPadding,
                      child: Column(
                        children: const [
                          StayCardSkeleton(),
                          AppSpacing.gapV16,
                          StayCardSkeleton(),
                        ],
                      ),
                    );
                  }

                  return Column(
                    children: [
                      // Featured Accommodations
                      FeaturedStaysCarouselWidget(
                        stays: controller.featuredStays,
                        onStayTap: (stay) => Get.toNamed(
                          AppRoutes.stayDetails,
                          arguments: stay.id,
                        ),
                        onViewAll: () => Get.toNamed(AppRoutes.stayList),
                      ),
                      AppSpacing.gapV24,

                      // Recommended Stays (Top Picks)
                      RecommendedStaysWidget(
                        stays: controller.recommendedStays,
                        onStayTap: (stay) => Get.toNamed(
                          AppRoutes.stayDetails,
                          arguments: stay.id,
                        ),
                        onViewAll: () => Get.toNamed(AppRoutes.stayList),
                      ),
                      AppSpacing.gapV24,

                      // Popular Destinations (Goa, Manali, Shillong, Jaipur)
                      PopularDestinationsWidget(
                        onSelectDestination: controller.onSelectDestination,
                      ),
                      AppSpacing.gapV24,

                      // Nearby Stays in selected city
                      Obx(() {
                        return NearbyStaysWidget(
                          stays: controller.nearbyStays,
                          currentCity: locationService.selectedCity.value,
                          onStayTap: (stay) => Get.toNamed(
                            AppRoutes.stayDetails,
                            arguments: stay.id,
                          ),
                          onViewAll: () => Get.toNamed(AppRoutes.stayList),
                        );
                      }),
                      AppSpacing.gapV24,

                      // Recently Viewed Stays
                      RecentlyViewedWidget(
                        stays: controller.recentlyViewedStays,
                        onStayTap: (stay) => Get.toNamed(
                          AppRoutes.stayDetails,
                          arguments: stay.id,
                        ),
                      ),
                      AppSpacing.gapV24,

                      // Secondary Services Banner (Services, Rentals, Trips)
                      const SecondaryServicesWidget(),
                      AppSpacing.gapV32,
                    ],
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}



typedef HomePage = HomeScreen;
