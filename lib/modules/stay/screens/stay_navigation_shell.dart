import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sewasetu/app/routes/app_routes.dart';
import 'package:sewasetu/app/theme/app_spacing.dart';
import 'package:sewasetu/modules/stay/controllers/stay_controller.dart';
import 'package:sewasetu/modules/stay/controllers/stay_navigation_controller.dart';
import 'package:sewasetu/modules/stay/screens/stay_list_screen.dart';
import 'package:sewasetu/modules/stay/widgets/property_card.dart';
import 'package:sewasetu/modules/stay/widgets/stay_navigation_bar.dart';
import 'package:sewasetu/shared/widgets/app_empty_state.dart';

/// Navigation shell managing tabs and the floating bottom navigation bar for the Stay module
class StayNavigationShell extends StatelessWidget {
  final Widget exploreView;

  const StayNavigationShell({
    super.key,
    required this.exploreView,
  });

  @override
  Widget build(BuildContext context) {
    final navCtrl = Get.isRegistered<StayNavigationController>()
        ? Get.find<StayNavigationController>()
        : Get.put(StayNavigationController());
    final stayCtrl = Get.isRegistered<StayController>()
        ? Get.find<StayController>()
        : Get.put(StayController());

    return Scaffold(
      body: Stack(
        children: [
          // Tab views
          Obx(() {
            return IndexedStack(
              index: navCtrl.selectedIndex.value,
              children: [
                // 0: Explore
                exploreView,

                // 1: Search (Full Accommodations Listing)
                const Staylist(),

                // 2: Saved / Favorites
                _buildSavedStaysTab(stayCtrl),

                // 3: Bookings
                _buildStayBookingsTab(),
              ],
            );
          }),

          // Floating Navigation Bar
          const Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: StayNavigationBar(),
          ),
        ],
      ),
    );
  }

  Widget _buildSavedStaysTab(StayController controller) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Stays'),
        automaticallyImplyLeading: false,
      ),
      body: Obx(() {
        final favorites = controller.stays.where((s) => s.isFavorite).toList();

        if (favorites.isEmpty) {
          return AppEmptyState(
            icon: Icons.favorite_border_rounded,
            title: 'No Saved Stays',
            description: 'Tap the heart icon on any hotel, room, or homestay to save it here for later.',
            actionText: 'Explore Stays',
            onAction: () => Get.find<StayNavigationController>().changeTab(0),
          );
        }

        return ListView.separated(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 90),
          itemCount: favorites.length,
          separatorBuilder: (_, __) => AppSpacing.gapV16,
          itemBuilder: (context, index) {
            final stay = favorites[index];
            return StayCardWidget(
              stay: stay,
              onTap: () => Get.toNamed(
                AppRoutes.stayDetails,
                arguments: stay.id,
              ),
              onFavoriteToggle: (fav) => controller.toggleFavorite(stay.id, fav),
            );
          },
        );
      }),
    );
  }

  Widget _buildStayBookingsTab() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stay Bookings'),
        automaticallyImplyLeading: false,
      ),
      body: AppEmptyState(
        icon: Icons.calendar_today_rounded,
        title: 'No Active Reservations',
        description: 'Your upcoming room, hotel, and homestay bookings will appear here once confirmed.',
        actionText: 'Find a Place to Stay',
        onAction: () => Get.find<StayNavigationController>().changeTab(0),
      ),
    );
  }
}
