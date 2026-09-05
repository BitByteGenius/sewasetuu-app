import 'package:get/get.dart';
import '../controllers/rental_city_controller.dart';
import '../controllers/rental_controller.dart';
import '../controllers/rental_favorites_controller.dart';
import '../controllers/rental_filter_controller.dart';
import '../controllers/rental_search_controller.dart';
import '../controllers/vehicle_list_controller.dart';
import '../data/repositories/rental_repository.dart';
import '../data/repositories/rental_repository_impl.dart';

/// Dependency injection binding for the main Rental module screen.
class RentalBinding extends Bindings {
  @override
  void dependencies() {
    ensureInitialized();
  }

  /// Ensures all core rental controllers and repositories are registered and accessible.
  static void ensureInitialized() {
    if (!Get.isRegistered<RentalRepository>()) {
      Get.lazyPut<RentalRepository>(() => RentalRepositoryImpl(), fenix: true);
    }

    if (!Get.isRegistered<RentalFavoritesController>()) {
      Get.lazyPut<RentalFavoritesController>(() => RentalFavoritesController(), fenix: true);
    }

    if (!Get.isRegistered<RentalCityController>()) {
      Get.lazyPut<RentalCityController>(
        () => RentalCityController(repository: Get.find<RentalRepository>()),
        fenix: true,
      );
    }

    if (!Get.isRegistered<RentalSearchController>()) {
      Get.lazyPut<RentalSearchController>(
        () => RentalSearchController(cityController: Get.find<RentalCityController>()),
        fenix: true,
      );
    }

    if (!Get.isRegistered<RentalController>()) {
      Get.lazyPut<RentalController>(
        () => RentalController(
          repository: Get.find<RentalRepository>(),
          cityController: Get.find<RentalCityController>(),
        ),
        fenix: true,
      );
    }

    if (!Get.isRegistered<RentalFilterController>()) {
      Get.lazyPut<RentalFilterController>(() => RentalFilterController(), fenix: true);
    }

    if (!Get.isRegistered<VehicleListController>()) {
      Get.lazyPut<VehicleListController>(
        () => VehicleListController(
          repository: Get.find<RentalRepository>(),
          searchController: Get.find<RentalSearchController>(),
          filterController: Get.find<RentalFilterController>(),
        ),
        fenix: true,
      );
    }
  }
}
