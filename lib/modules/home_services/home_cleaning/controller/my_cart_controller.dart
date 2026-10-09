import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../controller/home_services_cart_controller.dart';
import '../data/kitchen_cleaning_data.dart';
import '../models/kitchen_cleaning_model.dart';

/// Dedicated GetX Controller managing logic, cart operations, add-on data,
/// and checkout actions for [MyCartWidgets].
class MyCartController extends GetxController {
  /// Access central HomeServicesCartController for unified state across all home services
  HomeServicesCartController get _cartController =>
      HomeServicesCartController.instance;

  /// Reactive stream of cart items from the central cart controller
  RxList<KitchenCartItem> get cartItems => _cartController.cartItems;

  /// Live total price calculation
  double get totalCartPrice => _cartController.totalCartPrice;

  /// Live total item count
  int get totalCartCount => _cartController.totalCartCount;

  /// Check if the cart has any items
  bool get hasCartItems => _cartController.isCartNotEmpty;

  /// Recommended add-on services list derived from 'mini' services data
  List<KitchenCleaningServiceItem> get recommendedAddons {
    return KitchenCleaningData.allServices
        .where((s) => s.sectionId == 'mini')
        .toList();
  }

  /// Add a service or option to cart
  void addItem(KitchenCleaningServiceItem service, [ServiceOptionItem? option]) {
    _cartController.addItem(service, option);
  }

  /// Decrement item quantity or remove if quantity reaches 0
  void decrementItem(String serviceId) {
    _cartController.decrementItem(serviceId);
  }

  /// Remove item completely from cart
  void removeItemCompletely(String serviceId) {
    _cartController.removeItemCompletely(serviceId);
  }

  /// Get current quantity of a specific item
  int getItemQuantity(String serviceId) {
    return _cartController.getItemQuantity(serviceId);
  }

  /// Check if an item is currently added to cart
  bool isItemInCart(String serviceId) {
    return getItemQuantity(serviceId) > 0;
  }

  /// Handle checkout CTA / address selection action
  void proceedToAddressSelection() {
    HapticFeedback.mediumImpact();
    Get.snackbar(
      'Select Address',
      'Proceeding to address selection with total: ₹${totalCartPrice.toStringAsFixed(0)}',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF0F766E),
      colorText: Colors.white,
      duration: const Duration(seconds: 3),
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
    );
  }
}
