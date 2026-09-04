import 'package:get/get.dart';
import '../controllers/cart_controller.dart';
import '../data/repositories/shop_repository.dart';
import '../data/repositories/shop_repository_impl.dart';

/// Dependency injection binding for Product Details
class ProductDetailsBinding extends Bindings {
  @override
  void dependencies() {
    if (!Get.isRegistered<ShopRepository>()) {
      Get.lazyPut<ShopRepository>(() => ShopRepositoryImpl(), fenix: true);
    }
    if (!Get.isRegistered<CartController>()) {
      Get.put<CartController>(CartController(), permanent: true);
    }
  }
}
