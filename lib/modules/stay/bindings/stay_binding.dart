import 'package:get/get.dart';
import 'package:sewasetu/modules/stay/controllers/stay_controller.dart';
import 'package:sewasetu/modules/stay/services/stay_service.dart';

/// Bindings for Stay Listing
class StayBinding extends Bindings {
  @override
  void dependencies() {
    if (!Get.isRegistered<StayService>()) {
      Get.lazyPut<StayService>(() => StayService());
    }
    Get.lazyPut<StayController>(() => StayController());
  }
}

typedef StayListBinding = StayBinding;
