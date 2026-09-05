import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_radius.dart';
import '../../../app/theme/app_spacing.dart';
import '../../../app/theme/app_text_styles.dart';
import '../bindings/rental_binding.dart';
import '../controllers/rental_city_controller.dart';
import '../controllers/rental_controller.dart';
import '../models/vehicle_model.dart';
import '../widgets/premium_vehicle_card.dart';
import '../widgets/rental_banner_carousel.dart';
import '../widgets/rental_empty_state.dart';
import '../widgets/rental_header_widget.dart';
import '../widgets/rental_loading_skeleton.dart';
import '../widgets/rental_search_card.dart';
import '../widgets/vehicle_card.dart';
import '../widgets/vehicle_type_selector.dart';
import 'vehicle_list_screen.dart';

/// The central flagship home screen for the SewaSetu Rental module.
class RentalScreen extends StatelessWidget {
  const RentalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Ensure dependencies are always registered if navigated directly
    RentalBinding.ensureInitialized();

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final rentalCtrl = Get.find<RentalController>();
    final cityCtrl = Get.find<RentalCityController>();

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            await rentalCtrl.loadDashboardData();
          },
          color: AppColors.primary,
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics(),
            ),
            slivers: [
              // 1. Automotive Header
              const SliverToBoxAdapter(
                child: RentalHeaderWidget(),
              ),

              // 2. Hero Animated Banner Carousel (Mandatory)
              SliverToBoxAdapter(
                child: Obx(() {
                  if (rentalCtrl.isLoading.value && rentalCtrl.campaigns.isEmpty) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                      child: SkeletonBox(height: 190, width: double.infinity, borderRadius: AppRadius.radiusXl),
                    );
                  }
                  return RentalBannerCarousel(campaigns: rentalCtrl.campaigns);
                }),
              ),

              const SliverToBoxAdapter(
                child: SizedBox(height: AppSpacing.md),
              ),

              // 3. Primary Rental Search Card
              const SliverToBoxAdapter(
                child: RentalSearchCard(),
              ),

              const SliverToBoxAdapter(
                child: SizedBox(height: AppSpacing.xl),
              ),

              // 4. Vehicle Type Selection Bar
              const SliverToBoxAdapter(
                child: VehicleTypeSelector(),
              ),

              const SliverToBoxAdapter(
                child: SizedBox(height: AppSpacing.lg),
              ),

              // 5. Available In Your City / Filtered section
              SliverToBoxAdapter(
                child: Obx(() {
                  final cityName = cityCtrl.selectedCity.value?.name ?? 'Your City';

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'AVAILABLE IN $cityName'.toUpperCase(),
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 0.8,
                                color: isDark ? AppColors.textMutedDark : AppColors.textSecondaryLight,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'Instant Bookings',
                              style: AppTextStyles.headlineSmall(isDark).copyWith(
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                        TextButton(
                          onPressed: () => Get.to(() => const VehicleListScreen()),
                          child: const Row(
                            children: [
                              Text(
                                'View All',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.primary,
                                ),
                              ),
                              Icon(Icons.chevron_right, size: 18, color: AppColors.primary),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ),

              const SliverToBoxAdapter(
                child: SizedBox(height: AppSpacing.sm),
              ),

              // Vehicles in City list
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                sliver: Obx(() {
                  if (rentalCtrl.isLoading.value && rentalCtrl.categoryFilteredVehicles.isEmpty) {
                    return SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (_, __) => const RentalVehicleCardSkeleton(),
                        childCount: 2,
                      ),
                    );
                  }

                  final vehicles = rentalCtrl.categoryFilteredVehicles;
                  if (vehicles.isEmpty) {
                    return SliverToBoxAdapter(
                      child: RentalEmptyState.noVehicles(
                        onResetFilters: () => rentalCtrl.selectCategoryTab(RentalVehicleType.all),
                      ),
                    );
                  }

                  // Show top 3 in home feed
                  final displayed = vehicles.take(3).toList();
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => VehicleCard(vehicle: displayed[index]),
                      childCount: displayed.length,
                    ),
                  );
                }),
              ),

              const SliverToBoxAdapter(
                child: SizedBox(height: AppSpacing.xl),
              ),

              // 6. Premium Collection (Luxury Showcase)
              SliverToBoxAdapter(
                child: Obx(() {
                  final premiumList = rentalCtrl.premiumVehicles;
                  if (premiumList.isEmpty) return const SizedBox.shrink();

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'PREMIUM COLLECTION',
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: 0.8,
                                    color: Color(0xFFF59E0B),
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  'Luxury & Flagship Rides',
                                  style: AppTextStyles.headlineSmall(isDark).copyWith(
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      SizedBox(
                        height: 295,
                        child: ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                          scrollDirection: Axis.horizontal,
                          itemCount: premiumList.length,
                          itemBuilder: (context, index) {
                            return PremiumVehicleCard(vehicle: premiumList[index]);
                          },
                        ),
                      ),
                    ],
                  );
                }),
              ),

              const SliverToBoxAdapter(
                child: SizedBox(height: AppSpacing.xxl),
              ),

              // 7. Popular Rides
              SliverToBoxAdapter(
                child: Obx(() {
                  final popular = rentalCtrl.popularVehicles;
                  if (popular.isEmpty) return const SizedBox.shrink();

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'MOST RENTED',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.8,
                            color: isDark ? AppColors.textMutedDark : AppColors.textSecondaryLight,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Popular Customer Favorites',
                          style: AppTextStyles.headlineSmall(isDark).copyWith(
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ),

              const SliverToBoxAdapter(
                child: SizedBox(height: AppSpacing.md),
              ),

              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                sliver: Obx(() {
                  final popular = rentalCtrl.popularVehicles.take(2).toList();
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => VehicleCard(vehicle: popular[index]),
                      childCount: popular.length,
                    ),
                  );
                }),
              ),

              const SliverToBoxAdapter(
                child: SizedBox(height: AppSpacing.xl),
              ),

              // 8. Why Rent With Us Trust Section
              SliverToBoxAdapter(
                child: _buildWhyRentWithUs(isDark),
              ),

              const SliverToBoxAdapter(
                child: SizedBox(height: AppSpacing.massive),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWhyRentWithUs(bool isDark) {
    final benefits = [
      {
        'icon': Icons.verified_user_rounded,
        'title': '100% Verified Fleet',
        'desc': 'Clean, serviced, multi-point inspected vehicles.',
      },
      {
        'icon': Icons.currency_rupee_rounded,
        'title': 'Transparent Pricing',
        'desc': 'No hidden surcharges. Refundable deposit guaranteed.',
      },
      {
        'icon': Icons.support_agent_rounded,
        'title': '24/7 Roadside Assist',
        'desc': 'Round-the-clock roadside emergency support across India.',
      },
      {
        'icon': Icons.local_shipping_rounded,
        'title': 'Doorstep Delivery',
        'desc': 'Delivered right to your airport terminal or hotel doorstep.',
      },
    ];

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : AppColors.surfaceVariantLight,
        borderRadius: AppRadius.radiusXl,
        border: Border.all(
          color: isDark ? AppColors.borderDark : AppColors.borderLight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(AppSpacing.xs + 2),
                decoration: BoxDecoration(
                  color: AppColors.primary.withAlpha((255 * 0.15).round()),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.shield_outlined, size: 18, color: AppColors.primary),
              ),
              const SizedBox(width: AppSpacing.sm),
              Text(
                'WHY RENT WITH SEWASETU',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.8,
                  color: isDark ? AppColors.primaryLight : AppColors.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          ...benefits.map((b) {
            return Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.md),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: isDark ? AppColors.surfaceVariantDark : Colors.white,
                      borderRadius: AppRadius.radiusMd,
                    ),
                    child: Icon(
                      b['icon'] as IconData,
                      size: 20,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          b['title'] as String,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          b['desc'] as String,
                          style: TextStyle(
                            fontSize: 12,
                            color: isDark ? AppColors.textMutedDark : AppColors.textSecondaryLight,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
