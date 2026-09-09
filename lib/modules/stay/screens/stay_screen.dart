import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sewasetu/app/routes/app_routes.dart';
import 'package:sewasetu/app/theme/app_spacing.dart';
import 'package:sewasetu/core/services/location_service.dart';
import 'package:sewasetu/modules/home/widgets/featured_stays_carousel_widget.dart';
import 'package:sewasetu/modules/home/widgets/nearby_stays_widget.dart';
import 'package:sewasetu/modules/home/widgets/popular_destinations_widget.dart';
import 'package:sewasetu/modules/home/widgets/recently_viewed_widget.dart';
import 'package:sewasetu/modules/home/widgets/recommended_stays_widget.dart';
import 'package:sewasetu/modules/stay/widgets/stay_category_selector_widget.dart';
import 'package:sewasetu/modules/stay/controllers/stay_controller.dart';
import 'package:sewasetu/shared/enums/view_state.dart';
import 'package:sewasetu/shared/widgets/app_skeleton.dart';

class StayScreen extends GetView<StayController> {
  const StayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final locationService = Get.find<LocationService>();

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Category Selector
          StayCategorySelectorWidget(
            onCategorySelected: controller.onSelectStayType,
          ),
          AppSpacing.gapV24,

          // 2. State-driven Content
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

                // Recommended Stays
                RecommendedStaysWidget(
                  stays: controller.recommendedStays,
                  onStayTap: (stay) => Get.toNamed(
                    AppRoutes.stayDetails,
                    arguments: stay.id,
                  ),
                  onViewAll: () => Get.toNamed(AppRoutes.stayList),
                ),
                AppSpacing.gapV24,

                // Popular Destinations
                PopularDestinationsWidget(
                  onSelectDestination: controller.onSelectDestination,
                ),
                AppSpacing.gapV24,

                // Nearby Stays
                NearbyStaysWidget(
                  stays: controller.nearbyStays,
                  currentCity: locationService.selectedCity.value,
                  onStayTap: (stay) => Get.toNamed(
                    AppRoutes.stayDetails,
                    arguments: stay.id,
                  ),
                  onViewAll: () => Get.toNamed(AppRoutes.stayList),
                ),
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
              ],
            );
          }),
        ],
      ),
    );
  }
}

typedef StayListPage = StayScreen;