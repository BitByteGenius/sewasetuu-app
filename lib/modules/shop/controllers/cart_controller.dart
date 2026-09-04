import 'package:get/get.dart';
import '../models/cart_item_model.dart';
import '../models/product_model.dart';
import '../models/product_variant_model.dart';

/// Reactive controller managing the shopping cart, pricing calculations and item quantities
class CartController extends GetxController {
  final RxList<CartItemModel> cartItems = <CartItemModel>[].obs;
  final RxString appliedPromoCode = ''.obs;
  final RxDouble promoDiscount = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    // Pre-populate with one authentic sample item for immediate delight
    _initSampleItem();
  }

  void _initSampleItem() {
    // You can keep it empty or with a demo item
  }

  int get itemCount => cartItems.length;

  int get totalUnits =>
      cartItems.fold<int>(0, (sum, item) => sum + item.quantity);

  double get subtotal =>
      cartItems.fold<double>(0.0, (sum, item) => sum + item.totalPrice);

  /// Free delivery above ₹999; otherwise nominal ₹70 regional artisan delivery fee
  double get deliveryFee {
    if (cartItems.isEmpty) return 0.0;
    return subtotal >= 999.0 ? 0.0 : 70.0;
  }

  double get discount => promoDiscount.value;

  double get totalAmount {
    if (cartItems.isEmpty) return 0.0;
    final total = subtotal + deliveryFee - discount;
    return total > 0 ? total : 0.0;
  }

  bool isProductInCart(String productId) {
    return cartItems.any((item) => item.product.id == productId);
  }

  int getQuantityForProduct(String productId) {
    final item = cartItems.firstWhereOrNull((item) => item.product.id == productId);
    return item?.quantity ?? 0;
  }

  void addToCart(
    ProductModel product, {
    ProductVariantModel? variant,
    int quantity = 1,
  }) {
    final compositeId = variant != null
        ? '${product.id}_${variant.id}'
        : product.id;

    final existingIndex = cartItems.indexWhere(
      (item) => item.cartItemId == compositeId,
    );

    if (existingIndex != -1) {
      final current = cartItems[existingIndex];
      cartItems[existingIndex] = current.copyWith(
        quantity: current.quantity + quantity,
      );
    } else {
      cartItems.add(
        CartItemModel(
          product: product,
          selectedVariant: variant,
          quantity: quantity,
        ),
      );
    }

    Get.snackbar(
      'Added to Cart',
      '${product.name} has been added to your shopping bag.',
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
    );
  }

  void removeFromCart(CartItemModel item) {
    cartItems.removeWhere((i) => i.cartItemId == item.cartItemId);
    Get.snackbar(
      'Item Removed',
      '${item.product.name} removed from your bag.',
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
    );
  }

  void increaseQuantity(CartItemModel item) {
    final index = cartItems.indexWhere((i) => i.cartItemId == item.cartItemId);
    if (index != -1) {
      cartItems[index] = item.copyWith(quantity: item.quantity + 1);
    }
  }

  void decreaseQuantity(CartItemModel item) {
    final index = cartItems.indexWhere((i) => i.cartItemId == item.cartItemId);
    if (index != -1) {
      if (item.quantity > 1) {
        cartItems[index] = item.copyWith(quantity: item.quantity - 1);
      } else {
        removeFromCart(item);
      }
    }
  }

  void applyCoupon(String code) {
    final cleanCode = code.trim().toUpperCase();
    if (cleanCode == 'SEWASETU100') {
      promoDiscount.value = 100.0;
      appliedPromoCode.value = cleanCode;
      Get.snackbar('Coupon Applied', '₹100 discount applied to your order!');
    } else if (cleanCode == 'CULTURE15') {
      promoDiscount.value = (subtotal * 0.15).clamp(0.0, 500.0);
      appliedPromoCode.value = cleanCode;
      Get.snackbar('Coupon Applied', '15% cultural discount applied!');
    } else {
      Get.snackbar('Invalid Coupon', 'Coupon code "$code" is not recognized.');
    }
  }

  void removeCoupon() {
    promoDiscount.value = 0.0;
    appliedPromoCode.value = '';
  }

  void clearCart() {
    cartItems.clear();
    removeCoupon();
  }
}
