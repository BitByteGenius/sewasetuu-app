import 'package:get/get.dart';
import '../controllers/trip_search_controller.dart';
import '../data/repositories/trips_repository.dart';
import '../data/repositories/trips_repository_impl.dart';

/// Binding for dedicated Trip Search screen
class TripSearchBinding extends Bindings {
  @override
  void dependencies() {
    if (!Get.isRegistered<TripsRepository>()) {
      Get.lazyPut<TripsRepository>(() => TripsRepositoryImpl(), fenix: true);
    }
    if (!Get.isRegistered<TripSearchController>()) {
      Get.lazyPut<TripSearchController>(
        () => TripSearchController(repository: Get.find<TripsRepository>()),
        fenix: true,
      );
    }
  }
}
