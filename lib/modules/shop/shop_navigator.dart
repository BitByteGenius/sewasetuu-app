import 'package:get/get.dart';
import 'bindings/cart_binding.dart';
import 'bindings/product_details_binding.dart';
import 'bindings/shop_binding.dart';
import 'controllers/product_details_controller.dart';
import 'controllers/state_products_controller.dart';
import 'models/product_model.dart';
import 'models/shop_order_model.dart';
import 'models/shop_state_model.dart';
import 'screens/cart_screen.dart';
import 'screens/checkout_screen.dart';
import 'screens/order_success_screen.dart';
import 'screens/product_details_screen.dart';
import 'screens/search_products_screen.dart';
import 'screens/shop_screen.dart';
import 'screens/state_products_screen.dart';
import 'screens/states_screen.dart';

/// Clean internal navigator for the Shop module.
/// Allows full transitions between all Shop screens without altering the global app_routes.dart.
class ShopNavigator {
  /// Opens the main Shop home screen
  static Future<T?>? toShop<T>() {
    ShopBinding().dependencies();
    return Get.to<T>(
      () => const ShopScreen(),
      transition: Transition.rightToLeftWithFade,
      duration: const Duration(milliseconds: 300),
    );
  }

  /// Opens the All States exploration screen
  static Future<T?>? toStates<T>() {
    return Get.to<T>(
      () => const StatesScreen(),
      transition: Transition.rightToLeftWithFade,
      duration: const Duration(milliseconds: 300),
    );
  }

  /// Opens the State-specific products catalog
  static Future<T?>? toStateProducts<T>(ShopStateModel stateModel) {
    // Put StateProductsController for this specific state
    Get.put<StateProductsController>(
      StateProductsController(stateModel: stateModel),
      tag: stateModel.id,
    );

    return Get.to<T>(
      () => StateProductsScreen(stateModel: stateModel),
      transition: Transition.rightToLeftWithFade,
      duration: const Duration(milliseconds: 300),
    );
  }

  /// Opens the Product Details screen
  static Future<T?>? toProductDetails<T>(ProductModel product) {
    ProductDetailsBinding().dependencies();
    Get.put<ProductDetailsController>(
      ProductDetailsController(product: product),
      tag: product.id,
    );

    return Get.to<T>(
      () => ProductDetailsScreen(product: product),
      transition: Transition.rightToLeftWithFade,
      duration: const Duration(milliseconds: 300),
    );
  }

  /// Opens the Search screen
  static Future<T?>? toSearch<T>({String? initialQuery}) {
    return Get.to<T>(
      () => SearchProductsScreen(initialQuery: initialQuery),
      transition: Transition.fadeIn,
      duration: const Duration(milliseconds: 250),
    );
  }

  /// Opens the Cart screen
  static Future<T?>? toCart<T>() {
    CartBinding().dependencies();
    return Get.to<T>(
      () => const CartScreen(),
      transition: Transition.rightToLeftWithFade,
      duration: const Duration(milliseconds: 300),
    );
  }

  /// Opens the Checkout screen
  static Future<T?>? toCheckout<T>() {
    CartBinding().dependencies();
    return Get.to<T>(
      () => const CheckoutScreen(),
      transition: Transition.rightToLeftWithFade,
      duration: const Duration(milliseconds: 300),
    );
  }

  /// Opens the Order Success confirmation screen
  static Future<T?>? toOrderSuccess<T>(ShopOrderModel order) {
    return Get.off<T>(
      () => OrderSuccessScreen(order: order),
      transition: Transition.fadeIn,
      duration: const Duration(milliseconds: 350),
    );
  }
}
