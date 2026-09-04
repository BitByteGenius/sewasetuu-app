import 'package:get/get.dart';
import '../controllers/cart_controller.dart';
import '../controllers/checkout_controller.dart';

/// Dependency injection binding for Cart & Checkout
class CartBinding extends Bindings {
  @override
  void dependencies() {
    if (!Get.isRegistered<CartController>()) {
      Get.put<CartController>(CartController(), permanent: true);
    }
    if (!Get.isRegistered<ShopCheckoutController>()) {
      Get.lazyPut<ShopCheckoutController>(
        () => ShopCheckoutController(),
        fenix: true,
      );
    }
  }
}
