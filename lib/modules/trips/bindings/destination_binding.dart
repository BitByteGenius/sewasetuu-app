import 'package:get/get.dart';
import '../data/repositories/trips_repository.dart';
import '../data/repositories/trips_repository_impl.dart';

/// Binding ensuring TripsRepository is available for DestinationController
class DestinationBinding extends Bindings {
  @override
  void dependencies() {
    if (!Get.isRegistered<TripsRepository>()) {
      Get.lazyPut<TripsRepository>(() => TripsRepositoryImpl(), fenix: true);
    }
  }
}
