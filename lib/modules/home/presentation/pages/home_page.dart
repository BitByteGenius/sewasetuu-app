import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sewasetu/app/routes/app_routes.dart';
import 'package:sewasetu/app/theme/app_colors.dart';
import 'package:sewasetu/app/theme/app_spacing.dart';
import 'package:sewasetu/core/services/location_service.dart';
import 'package:sewasetu/shared/enums/view_state.dart';
import 'package:sewasetu/shared/widgets/app_loader.dart';
import 'package:sewasetu/modules/stay/filter/presentation/widgets/stay_filter_bottom_sheet.dart';
import 'package:sewasetu/modules/home/presentation/controllers/home_controller.dart';
import 'package:sewasetu/modules/home/presentation/widgets/featured_stays_carousel_widget.dart';
import 'package:sewasetu/modules/home/presentation/widgets/home_header_widget.dart';
import 'package:sewasetu/modules/home/presentation/widgets/home_search_bar_widget.dart';
import 'package:sewasetu/modules/home/presentation/widgets/nearby_stays_widget.dart';
import 'package:sewasetu/modules/home/presentation/widgets/popular_destinations_widget.dart';
import 'package:sewasetu/modules/home/presentation/widgets/secondary_services_widget.dart';
import 'package:sewasetu/modules/home/presentation/widgets/stay_category_selector_widget.dart';

/// Main Marketplace Home Page with Stay prioritised as the core business.
class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final locationService = Get.find<LocationService>();

    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: controller.loadHomeData,
          color: isDark ? AppColors.primaryLight : AppColors.primary,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. Premium Greeting & Location Selector
                const HomeHeaderWidget(),
                AppSpacing.gapV8,

                // 2. Search & Filter Bar
                HomeSearchBarWidget(
                  onFilterTap: () {
                    StayFilterBottomSheet.show(
                      context,
                      onApply: (criteria) {
                        Get.toNamed(AppRoutes.stayList);
                      },
                    );
                  },
                ),
                AppSpacing.gapV24,

                // 3. Primary Stay Categories (Rooms, PG, Mess, Homestay, Hotel)
                StayCategorySelectorWidget(
                  onSelectCategory: controller.onSelectStayType,
                ),
                AppSpacing.gapV24,

                // State-driven Content (Featured + Nearby)
                Obx(() {
                  if (controller.state.value == ViewState.loading) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 40),
                      child: Center(child: AppLoader(message: 'Curating top accommodation...')),
                    );
                  }

                  return Column(
                    children: [
                      // 4. Featured Accommodations
                      FeaturedStaysCarouselWidget(
                        stays: controller.featuredStays,
                        onStayTap: (stay) => Get.toNamed(
                          AppRoutes.stayDetails,
                          arguments: stay.id,
                        ),
                        onViewAll: () => Get.toNamed(AppRoutes.stayList),
                      ),
                      AppSpacing.gapV24,

                      // 5. Popular Destinations (Goa, Manali, Shillong, Jaipur)
                      PopularDestinationsWidget(
                        onSelectDestination: controller.onSelectDestination,
                      ),
                      AppSpacing.gapV24,

                      // 6. Nearby Stays in selected city
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

                      // 7. Secondary Services Banner (Services, Rentals, Trips)
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
