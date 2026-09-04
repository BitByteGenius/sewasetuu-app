import 'package:get/get.dart';
import '../controllers/trip_filter_controller.dart';
import '../controllers/trip_search_controller.dart';
import '../controllers/trips_controller.dart';
import '../data/repositories/trips_repository.dart';
import '../data/repositories/trips_repository_impl.dart';

/// Central dependency injection binding for the Trips module
class TripsBinding extends Bindings {
  @override
  void dependencies() {
    if (!Get.isRegistered<TripsRepository>()) {
      Get.lazyPut<TripsRepository>(() => TripsRepositoryImpl(), fenix: true);
    }
    if (!Get.isRegistered<TripsController>()) {
      Get.lazyPut<TripsController>(
        () => TripsController(repository: Get.find<TripsRepository>()),
        fenix: true,
      );
    }
    if (!Get.isRegistered<TripFilterController>()) {
      Get.lazyPut<TripFilterController>(
        () => TripFilterController(repository: Get.find<TripsRepository>()),
        fenix: true,
      );
    }
    if (!Get.isRegistered<TripSearchController>()) {
      Get.lazyPut<TripSearchController>(
        () => TripSearchController(repository: Get.find<TripsRepository>()),
        fenix: true,
      );
    }
  }
}
