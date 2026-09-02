import 'package:get/get.dart';
import 'package:sewasetu/core/storage/storage_service.dart';
import '../controllers/splash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<SplashController>(SplashController(Get.find<IStorageService>()));
  }
}
