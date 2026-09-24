import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sewasetu/modules/stay/bookings/screens/bookings_screen.dart';
import 'package:sewasetu/modules/stay/controllers/stay_controller.dart';
import 'package:sewasetu/modules/stay/controllers/stay_navigation_controller.dart';
import 'package:sewasetu/modules/stay/screens/stay_list_screen.dart';
import 'package:sewasetu/modules/stay/screens/stay_saved_screen.dart';
import 'package:sewasetu/modules/stay/widgets/stay_navigation_bar.dart';

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
    Get.isRegistered<StayController>()
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
                const StaySavedScreen(),

                // 3: Bookings & Activities
                const BookingsScreen(),
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
}
