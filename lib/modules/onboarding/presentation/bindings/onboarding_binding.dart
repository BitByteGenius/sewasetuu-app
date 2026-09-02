import 'package:get/get.dart';
import '../../../../core/storage/storage_service.dart';
import '../controllers/onboarding_controller.dart';

class OnboardingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OnboardingController>(
      () => OnboardingController(Get.find<IStorageService>()),
    );
  }
}
