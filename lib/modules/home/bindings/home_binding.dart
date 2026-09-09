import 'package:get/get.dart';
import 'package:sewasetu/core/services/location_service.dart';
import 'package:sewasetu/modules/bookings/bookings.dart';
import 'package:sewasetu/modules/home/controllers/home_controller.dart';
import 'package:sewasetu/modules/profile/profile.dart';
import 'package:sewasetu/modules/rental/rental.dart';
import 'package:sewasetu/modules/shop/shop.dart';
import 'package:sewasetu/modules/stay/stay.dart';
import 'package:sewasetu/modules/trips/trips.dart';
import 'package:sewasetu/modules/wishlist/wishlist.dart';

/// Bindings for Home module and the root Navigation Shell
class HomeBinding extends Bindings {
  @override
  void dependencies() {
    if (!Get.isRegistered<LocationService>()) {
      Get.put<LocationService>(LocationService(), permanent: true);
    }
    if (!Get.isRegistered<StayService>()) {
      Get.lazyPut<StayService>(() => StayService(), fenix: true);
    }
    Get.lazyPut<HomeController>(() => HomeController(), fenix: true);
    Get.lazyPut<StayController>(() => StayController(), fenix: true);
    Get.lazyPut<FilterController>(() => FilterController(), fenix: true);
    Get.lazyPut<BookingsController>(() => BookingsController(), fenix: true);
    Get.lazyPut<WishlistController>(() => WishlistController(), fenix: true);
    Get.lazyPut<ProfileController>(() => ProfileController(), fenix: true);

    // Initialize dependencies for secondary modules when embedded in Home switcher
    TripsBinding().dependencies();
    ShopBinding().dependencies();
    RentalBinding.ensureInitialized();
  }
}
