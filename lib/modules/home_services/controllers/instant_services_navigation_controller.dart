import 'package:get/get.dart';

/// Navigation controller managing tab selection for the Instant Services module.
///
/// 0: Discover (Main services listing)
/// 1: Categories (Service categories browser)
/// 2: Bookings (Active & past service bookings)
/// 3: Saved (Favorited service providers)
class InstantServicesNavigationController extends GetxController {
  final RxInt selectedIndex = 0.obs;

  void changeTab(int index) {
    if (index >= 0 && index <= 3) {
      selectedIndex.value = index;
    }
  }

  void toDiscover() => changeTab(0);
  void toCategories() => changeTab(1);
  void toBookings() => changeTab(2);
  void toSaved() => changeTab(3);
}
