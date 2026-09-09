import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sewasetu/app/theme/app_colors.dart';
import 'package:sewasetu/app/theme/app_text_styles.dart';
import '../controllers/rental_controller.dart';
import '../controllers/rental_favorites_controller.dart';
import '../controllers/rental_navigation_controller.dart';
import '../models/vehicle_model.dart';
import '../widgets/rental_empty_state.dart';
import '../widgets/rental_navigation_bar.dart';
import '../widgets/vehicle_card.dart';
import 'rental_bookings_screen.dart';
import 'vehicle_list_screen.dart';

/// Navigation shell hosting the 4 Rental tabs with the floating cockpit navigation bar
class RentalNavigationShell extends StatelessWidget {
  final Widget discoverView;

  const RentalNavigationShell({
    super.key,
    required this.discoverView,
  });

  @override
  Widget build(BuildContext context) {
    final navCtrl = Get.isRegistered<RentalNavigationController>()
        ? Get.find<RentalNavigationController>()
        : Get.put(RentalNavigationController());

    return Scaffold(
      body: Stack(
        children: [
          // IndexedStack preserves state across Vehicle Rental tabs
          Obx(() {
            return IndexedStack(
              index: navCtrl.currentIndex.value,
              children: [
                // 0: Explore / Automotive Dashboard
                discoverView,

                // 1: Full Fleet / Vehicle Catalog
                const VehicleListScreen(),

                // 2: Bookings (Active, Upcoming & Past)
                const RentalBookingsScreen(),

                // 3: Saved / Favorites Wishlist
                _RentalFavoritesTabView(navCtrl: navCtrl),
              ],
            );
          }),

          // Floating Cockpit Navigation Bar
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: RentalNavigationBar(controller: navCtrl),
          ),
        ],
      ),
    );
  }
}

/// Dedicated Wishlist/Favorites Tab for Vehicle Rentals
class _RentalFavoritesTabView extends StatelessWidget {
  final RentalNavigationController navCtrl;

  const _RentalFavoritesTabView({required this.navCtrl});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final favCtrl = Get.isRegistered<RentalFavoritesController>()
        ? Get.find<RentalFavoritesController>()
        : Get.put(RentalFavoritesController());
    final rentalCtrl = Get.isRegistered<RentalController>()
        ? Get.find<RentalController>()
        : null;

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
        title: Text(
          'Saved Vehicles',
          style: AppTextStyles.headlineSmall(isDark).copyWith(
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      body: Obx(() {
        final favoriteIds = favCtrl.favoriteIds;

        // Collect all matching vehicles from rentalCtrl collections
        final List<VehicleModel> savedVehicles = [];
        if (rentalCtrl != null) {
          final allPool = [
            ...rentalCtrl.premiumVehicles,
            ...rentalCtrl.popularVehicles,
          ];
          for (final id in favoriteIds) {
            final match = allPool.firstWhereOrNull((v) => v.id == id);
            if (match != null && !savedVehicles.any((v) => v.id == match.id)) {
              savedVehicles.add(match);
            }
          }
        }

        if (savedVehicles.isEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: RentalEmptyState(
                icon: Icons.favorite_outline_rounded,
                title: 'No Saved Vehicles',
                message:
                    'Tap the heart icon on any SUV, luxury car, or road-trip bike to save it for instant booking.',
                actionText: 'Explore Vehicles',
                onAction: () => navCtrl.toVehicles(),
              ),
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 96),
          itemCount: savedVehicles.length,
          itemBuilder: (context, index) {
            final vehicle = savedVehicles[index];
            return VehicleCard(vehicle: vehicle);
          },
        );
      }),
    );
  }
}
