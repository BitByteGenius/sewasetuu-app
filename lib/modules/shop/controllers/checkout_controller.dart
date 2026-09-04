import 'dart:math';
import 'package:get/get.dart';
import '../models/address_model.dart';
import '../models/shop_order_model.dart';
import 'cart_controller.dart';

/// Controller managing shipping address selection, payment option, and order placement
class ShopCheckoutController extends GetxController {
  final RxList<ShopAddressModel> addresses = <ShopAddressModel>[
    const ShopAddressModel(
      id: 'addr-1',
      fullName: 'Gulshan Kumar',
      phone: '+91 98765 43210',
      streetAddress: 'House No. 12, Lachit Nagar',
      landmark: 'Near Rajdhani Masjid',
      city: 'Guwahati',
      state: 'Assam',
      pincode: '781007',
      isDefault: true,
    ),
    const ShopAddressModel(
      id: 'addr-2',
      fullName: 'Gulshan Kumar',
      phone: '+91 98765 43210',
      streetAddress: 'Flat 402, Mithila Enclave, Boring Road',
      landmark: 'Opposite Krishna Apartment',
      city: 'Patna',
      state: 'Bihar',
      pincode: '800001',
      isDefault: false,
    ),
  ].obs;

  final RxInt selectedAddressIndex = 0.obs;

  final List<String> paymentMethods = const [
    'UPI (Google Pay, PhonePe, Paytm)',
    'Credit / Debit Card',
    'Net Banking',
    'Cash on Delivery',
  ];

  final RxString selectedPaymentMethod =
      'UPI (Google Pay, PhonePe, Paytm)'.obs;

  final RxBool isPlacingOrder = false.obs;

  ShopAddressModel get currentAddress =>
      addresses[selectedAddressIndex.value];

  void selectAddress(int index) {
    selectedAddressIndex.value = index;
  }

  void selectPaymentMethod(String method) {
    selectedPaymentMethod.value = method;
  }

  Future<ShopOrderModel?> placeOrder(CartController cart) async {
    if (cart.cartItems.isEmpty) {
      Get.snackbar('Cart is empty', 'Add items before checking out.');
      return null;
    }

    try {
      isPlacingOrder.value = true;
      await Future.delayed(const Duration(milliseconds: 900));

      final randomId = 10000 + Random().nextInt(90000);
      final newOrder = ShopOrderModel(
        id: 'ord-${DateTime.now().millisecondsSinceEpoch}',
        orderNumber: '#SW-$randomId',
        items: List.from(cart.cartItems),
        subtotal: cart.subtotal,
        deliveryFee: cart.deliveryFee,
        discount: cart.discount,
        total: cart.totalAmount,
        deliveryAddress: currentAddress,
        paymentMethod: selectedPaymentMethod.value,
        createdAt: DateTime.now(),
      );

      // Empty the cart
      cart.clearCart();
      isPlacingOrder.value = false;
      return newOrder;
    } catch (_) {
      isPlacingOrder.value = false;
      Get.snackbar('Order Failed', 'Something went wrong. Please try again.');
      return null;
    }
  }
}
