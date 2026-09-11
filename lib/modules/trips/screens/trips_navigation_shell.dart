import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sewasetu/app/theme/app_spacing.dart';
import 'package:sewasetu/modules/trips/controllers/trips_controller.dart';
import 'package:sewasetu/modules/trips/controllers/trips_navigation_controller.dart';
import 'package:sewasetu/modules/trips/screens/destinations_screen.dart';
import 'package:sewasetu/modules/trips/trips_navigator.dart';
import 'package:sewasetu/modules/trips/widgets/trip_package_card.dart';
import 'package:sewasetu/modules/trips/widgets/trips_navigation_bar.dart';
import 'package:sewasetu/shared/widgets/app_bar/app_bar.dart';
import 'package:sewasetu/shared/widgets/app_empty_state.dart';

/// Navigation shell managing tabs and the floating bottom navigation bar for the Tours & Trips module
class TripsNavigationShell extends StatelessWidget {
  final Widget discoverView;

  const TripsNavigationShell({
    super.key,
    required this.discoverView,
  });

  @override
  Widget build(BuildContext context) {
    final navCtrl = Get.isRegistered<TripsNavigationController>()
        ? Get.find<TripsNavigationController>()
        : Get.put(TripsNavigationController());
    final tripsCtrl = Get.isRegistered<TripsController>()
        ? Get.find<TripsController>()
        : Get.put(TripsController());

    return Scaffold(
      body: Stack(
        children: [
          // Tab views
          Obx(() {
            return IndexedStack(
              index: navCtrl.selectedIndex.value,
              children: [
                // 0: Discover
                discoverView,

                // 1: Destinations
                const DestinationsScreen(),

                // 2: My Trips
                _buildMyTripsTab(navCtrl),

                // 3: Saved Packages
                _buildSavedTripsTab(tripsCtrl, navCtrl),
              ],
            );
          }),

          // Floating Navigation Bar
          const Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: TripsNavigationBar(),
          ),
        ],
      ),
    );
  }

  Widget _buildMyTripsTab(TripsNavigationController navCtrl) {
    return Scaffold(
      appBar: const SewaAppBar(
        titleText: 'My Expeditions & Trips',
        showBackButton: false,
      ),
      body: AppEmptyState(
        icon: Icons.flight_takeoff_rounded,
        title: 'No Booked Expeditions',
        description: 'Your upcoming guided tours, trekking packages, and holiday itineraries will appear here.',
        actionText: 'Discover Tours',
        onAction: () => navCtrl.toDiscover(),
      ),
    );
  }

  Widget _buildSavedTripsTab(TripsController controller, TripsNavigationController navCtrl) {
    return Scaffold(
      appBar: const SewaAppBar(
        titleText: 'Saved Packages',
        showBackButton: false,
      ),
      body: Obx(() {
        final saved = controller.featuredPackages.take(3).toList();

        if (saved.isEmpty) {
          return AppEmptyState(
            icon: Icons.bookmark_border_rounded,
            title: 'No Saved Tour Packages',
            description: 'Save exciting cultural circuits and Himalayan treks to compare them later.',
            actionText: 'Explore Packages',
            onAction: () => navCtrl.toDiscover(),
          );
        }

        return ListView.separated(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 90),
          itemCount: saved.length,
          separatorBuilder: (_, __) => AppSpacing.gapV16,
          itemBuilder: (context, index) {
            final package = saved[index];
            return TripPackageCard(
              package: package,
              onTap: () => TripsNavigator.toTripDetails(package),
            );
          },
        );
      }),
    );
  }
}
