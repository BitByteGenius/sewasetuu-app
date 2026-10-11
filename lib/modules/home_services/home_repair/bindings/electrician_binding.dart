import 'package:get/get.dart';
import '../controller/carpenter_controller.dart';
import '../controller/electrician_controller.dart';
import '../controller/plumbing_controller.dart';

class ElectricianBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ElectricianController>(() => ElectricianController());
  }
}

class PlumbingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PlumbingController>(() => PlumbingController());
  }
}

class CarpenterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CarpenterController>(() => CarpenterController());
  }
}
