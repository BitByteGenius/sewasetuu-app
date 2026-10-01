import 'package:get/get.dart';
import '../controller/home_cleaning_controller.dart';

/// GetX binding for lazy initialization of Home Cleaning controller
class HomeCleaningBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeCleaningController>(() => HomeCleaningController());
  }
}
