import 'package:get/get.dart';
import '../controllers/rental_city_controller.dart';
import '../controllers/rental_filter_controller.dart';
import '../controllers/rental_search_controller.dart';
import '../controllers/vehicle_list_controller.dart';
import '../data/repositories/rental_repository.dart';
import '../data/repositories/rental_repository_impl.dart';

/// Dependency injection binding for the Vehicle Search and Listing screens.
class RentalSearchBinding extends Bindings {
  @override
  void dependencies() {
    if (!Get.isRegistered<RentalRepository>()) {
      Get.lazyPut<RentalRepository>(() => RentalRepositoryImpl());
    }

    if (!Get.isRegistered<RentalCityController>()) {
      Get.lazyPut<RentalCityController>(
        () => RentalCityController(repository: Get.find<RentalRepository>()),
      );
    }

    if (!Get.isRegistered<RentalSearchController>()) {
      Get.lazyPut<RentalSearchController>(
        () => RentalSearchController(cityController: Get.find<RentalCityController>()),
      );
    }

    if (!Get.isRegistered<RentalFilterController>()) {
      Get.lazyPut<RentalFilterController>(() => RentalFilterController());
    }

    if (!Get.isRegistered<VehicleListController>()) {
      Get.lazyPut<VehicleListController>(
        () => VehicleListController(
          repository: Get.find<RentalRepository>(),
          searchController: Get.find<RentalSearchController>(),
          filterController: Get.find<RentalFilterController>(),
        ),
      );
    }
  }
}
