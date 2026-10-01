import 'package:get/get.dart';
import '../controllers/instant_services_navigation_controller.dart';
import '../controllers/services_controller.dart';
import '../data/services_repository.dart';

/// GetX binding for dependency injection of the Services module components
class ServicesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ServicesRepository>(() => ServicesRepositoryImpl());
    Get.lazyPut<ServicesController>(
      () => ServicesController(repository: Get.find<ServicesRepository>()),
    );
    Get.lazyPut<InstantServicesNavigationController>(
      () => InstantServicesNavigationController(),
    );
  }
}
