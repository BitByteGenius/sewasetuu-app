import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sewasetu/modules/home_services/home_screen/controllers/instant_services_navigation_controller.dart';
import 'package:sewasetu/modules/home_services/home_screen/widgets/instant_services_navigation_bar.dart';
import 'package:sewasetu/shared/widgets/app_bar/app_bar.dart';
import 'package:sewasetu/shared/widgets/app_empty_state.dart';

/// Navigation shell managing tabs and the floating bottom navigation bar
/// for the Instant Services module.
///
/// Follows the identical architecture of [StayNavigationShell] and
/// [TripsNavigationShell]: Scaffold → Stack → IndexedStack + Positioned nav bar.
class InstantServicesNavigationShell extends StatelessWidget {
  /// The main discovery/explore view (Tab 0), typically the existing [ServicesScreen].
  final Widget discoverView;

  const InstantServicesNavigationShell({
    super.key,
    required this.discoverView,
  });

  @override
  Widget build(BuildContext context) {
    final navCtrl = Get.isRegistered<InstantServicesNavigationController>()
        ? Get.find<InstantServicesNavigationController>()
        : Get.put(InstantServicesNavigationController());

    return Scaffold(
      body: Stack(
        children: [
          // Tab views
          Obx(() {
            return IndexedStack(
              index: navCtrl.selectedIndex.value,
              children: [
                // 0: Discover (Main services listing)
                discoverView,

                // 1: Categories
                _buildCategoriesTab(navCtrl),

                // 2: My Bookings
                _buildBookingsTab(navCtrl),

                // 3: Saved Providers
                _buildSavedTab(navCtrl),
              ],
            );
          }),

          // Floating Navigation Bar
          const Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: InstantServicesNavigationBar(),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoriesTab(InstantServicesNavigationController navCtrl) {
    return Scaffold(
      appBar: const SewaAppBar(
        titleText: 'Service Categories',
        showBackButton: false,
      ),
      body: AppEmptyState(
        icon: Icons.category_rounded,
        title: 'Browse Categories',
        description:
            'Explore categories like electrical, plumbing, cleaning, tutoring, and more. Coming soon!',
        actionText: 'Discover Services',
        onAction: () => navCtrl.toDiscover(),
      ),
    );
  }

  Widget _buildBookingsTab(InstantServicesNavigationController navCtrl) {
    return Scaffold(
      appBar: const SewaAppBar(
        titleText: 'Service Bookings',
        showBackButton: false,
      ),
      body: AppEmptyState(
        icon: Icons.receipt_long_rounded,
        title: 'No Active Bookings',
        description:
            'Your upcoming and past service bookings will appear here once confirmed.',
        actionText: 'Book a Service',
        onAction: () => navCtrl.toDiscover(),
      ),
    );
  }

  Widget _buildSavedTab(InstantServicesNavigationController navCtrl) {
    return Scaffold(
      appBar: const SewaAppBar(
        titleText: 'Saved Providers',
        showBackButton: false,
      ),
      body: AppEmptyState(
        icon: Icons.bookmark_border_rounded,
        title: 'No Saved Providers',
        description:
            'Save your favorite service professionals here to book them quickly next time.',
        actionText: 'Explore Services',
        onAction: () => navCtrl.toDiscover(),
      ),
    );
  }
}
