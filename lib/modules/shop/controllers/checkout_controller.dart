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
      type: 'Home',
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
      type: 'Work',
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

  bool get hasAddress => addresses.isNotEmpty;

  ShopAddressModel? get currentAddress {
    if (addresses.isEmpty) return null;
    if (selectedAddressIndex.value >= addresses.length || selectedAddressIndex.value < 0) {
      selectedAddressIndex.value = 0;
    }
    return addresses[selectedAddressIndex.value];
  }

  void selectAddress(int index) {
    if (index >= 0 && index < addresses.length) {
      selectedAddressIndex.value = index;
    }
  }

  void selectAddressById(String id) {
    final idx = addresses.indexWhere((a) => a.id == id);
    if (idx != -1) {
      selectedAddressIndex.value = idx;
    }
  }

  void addAddress(ShopAddressModel newAddress) {
    if (newAddress.isDefault || addresses.isEmpty) {
      // Clear default flag on existing addresses
      for (int i = 0; i < addresses.length; i++) {
        if (addresses[i].isDefault) {
          addresses[i] = addresses[i].copyWith(isDefault: false);
        }
      }
      addresses.insert(0, newAddress.copyWith(isDefault: true));
      selectedAddressIndex.value = 0;
    } else {
      addresses.add(newAddress);
      selectedAddressIndex.value = addresses.length - 1;
    }
  }

  bool deleteAddress(String id) {
    final idx = addresses.indexWhere((a) => a.id == id);
    if (idx == -1) return false;

    final wasSelected = selectedAddressIndex.value == idx;
    final wasDefault = addresses[idx].isDefault;

    addresses.removeAt(idx);

    if (addresses.isNotEmpty) {
      if (wasDefault) {
        addresses[0] = addresses[0].copyWith(isDefault: true);
      }
      if (selectedAddressIndex.value >= addresses.length || wasSelected) {
        selectedAddressIndex.value = 0;
      }
    } else {
      selectedAddressIndex.value = 0;
    }
    return true;
  }

  void setDefaultAddress(String id) {
    for (int i = 0; i < addresses.length; i++) {
      addresses[i] = addresses[i].copyWith(isDefault: addresses[i].id == id);
    }
    selectAddressById(id);
  }

  void selectPaymentMethod(String method) {
    selectedPaymentMethod.value = method;
  }

  Future<ShopOrderModel?> placeOrder(CartController cart) async {
    if (cart.cartItems.isEmpty) {
      Get.snackbar('Cart is empty', 'Add items before checking out.');
      return null;
    }

    if (currentAddress == null) {
      Get.snackbar('Address Required', 'Please add or select a delivery address.');
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
        deliveryAddress: currentAddress!,
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
