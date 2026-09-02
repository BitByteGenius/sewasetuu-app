import 'package:get/get.dart';
import 'package:sewasetu/modules/stay/controllers/property_details_controller.dart';
import 'package:sewasetu/modules/stay/services/stay_service.dart';

/// Bindings for Property Details feature
class PropertyDetailsBinding extends Bindings {
  @override
  void dependencies() {
    if (!Get.isRegistered<StayService>()) {
      Get.lazyPut<StayService>(() => StayService());
    }
    Get.lazyPut<PropertyDetailsController>(() => PropertyDetailsController());
  }
}
