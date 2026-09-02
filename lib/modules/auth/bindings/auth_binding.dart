import 'package:get/get.dart';
import '../controllers/auth_controller.dart';

/// Bindings for Auth module
class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(() => AuthController());
  }
}
