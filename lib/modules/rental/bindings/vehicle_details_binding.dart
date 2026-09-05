import 'package:get/get.dart';
import '../controllers/rental_favorites_controller.dart';
import '../controllers/rental_search_controller.dart';
import '../controllers/vehicle_details_controller.dart';
import '../data/repositories/rental_repository.dart';
import '../data/repositories/rental_repository_impl.dart';

/// Dependency injection binding for the Vehicle Details screen.
class VehicleDetailsBinding extends Bindings {
  @override
  void dependencies() {
    if (!Get.isRegistered<RentalRepository>()) {
      Get.lazyPut<RentalRepository>(() => RentalRepositoryImpl());
    }

    if (!Get.isRegistered<RentalFavoritesController>()) {
      Get.lazyPut<RentalFavoritesController>(() => RentalFavoritesController());
    }

    RentalSearchController? searchCtrl;
    if (Get.isRegistered<RentalSearchController>()) {
      searchCtrl = Get.find<RentalSearchController>();
    }

    Get.lazyPut<VehicleDetailsController>(
      () => VehicleDetailsController(
        repository: Get.find<RentalRepository>(),
        searchController: searchCtrl,
      ),
    );
  }
}
