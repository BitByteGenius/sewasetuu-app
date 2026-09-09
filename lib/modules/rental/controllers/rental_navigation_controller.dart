import 'package:get/get.dart';

/// Controller managing navigation tab switching in the Vehicle Rental module
class RentalNavigationController extends GetxController {
  static RentalNavigationController get to => Get.find<RentalNavigationController>();

  /// Currently active navigation tab index
  /// 0: Explore (Automotive Dashboard & Banners)
  /// 1: Vehicles (Full Fleet & Category Filter)
  /// 2: Bookings (Active, Upcoming & Past Rentals)
  /// 3: Favorites (Saved Cars & Bikes Wishlist)
  final RxInt currentIndex = 0.obs;

  void changeTab(int index) {
    if (index >= 0 && index <= 3) {
      currentIndex.value = index;
    }
  }

  void toExplore() => changeTab(0);
  void toVehicles() => changeTab(1);
  void toBookings() => changeTab(2);
  void toFavorites() => changeTab(3);
}
