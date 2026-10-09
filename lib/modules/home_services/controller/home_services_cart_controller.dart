import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../home_cleaning/models/kitchen_cleaning_model.dart';

/// Centralized GetX Controller managing cart state, item quantities, total calculation,
/// and checkout actions across all Home Services submodules (Cleaning, Electrical, Plumbing, Carpentry).
class HomeServicesCartController extends GetxController {
  /// Global singleton accessor or fallback injector
  static HomeServicesCartController get instance {
    if (Get.isRegistered<HomeServicesCartController>()) {
      return Get.find<HomeServicesCartController>();
    }
    return Get.put(HomeServicesCartController(), permanent: true);
  }

  /// Reactive list of items currently in the user's active cart
  final cartItems = <KitchenCartItem>[].obs;

  /// Live total item count in cart
  int get totalCartCount =>
      cartItems.fold(0, (sum, item) => sum + item.quantity);

  /// Live total price calculation across all items in cart
  double get totalCartPrice =>
      cartItems.fold(0.0, (sum, item) => sum + item.totalPrice);

  /// Helper getter checking if the cart has active items
  bool get isCartNotEmpty => cartItems.isNotEmpty;

  /// Retrieve current quantity for a specific service ID
  int getItemQuantity(String serviceId) {
    final found = cartItems.firstWhereOrNull((i) => i.service.id == serviceId);
    return found?.quantity ?? 0;
  }

  /// Retrieve cart item by service ID
  KitchenCartItem? getCartItem(String serviceId) {
    return cartItems.firstWhereOrNull((i) => i.service.id == serviceId);
  }

  /// Check if a service item is added to cart
  bool isItemInCart(String serviceId) => getItemQuantity(serviceId) > 0;

  /// Add a service item or option to cart
  void addItem(KitchenCleaningServiceItem service, [ServiceOptionItem? option]) {
    final existingIndex =
        cartItems.indexWhere((i) => i.service.id == service.id);

    if (existingIndex >= 0) {
      cartItems[existingIndex].quantity += 1;
      cartItems.refresh();
    } else {
      cartItems.add(KitchenCartItem(
        service: service,
        selectedOption: option ?? (service.hasOptions ? service.options.first : null),
        quantity: 1,
      ));
    }

    Get.snackbar(
      'Item Added',
      '${service.title} added to cart',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF0F766E),
      colorText: Colors.white,
      duration: const Duration(seconds: 1),
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 80),
      borderRadius: 12,
    );
  }

  /// Decrement item quantity, removing it when quantity reaches 0
  void decrementItem(String serviceId) {
    final existingIndex =
        cartItems.indexWhere((i) => i.service.id == serviceId);
    if (existingIndex >= 0) {
      if (cartItems[existingIndex].quantity > 1) {
        cartItems[existingIndex].quantity -= 1;
        cartItems.refresh();
      } else {
        cartItems.removeAt(existingIndex);
      }
    }
  }

  /// Remove item completely from cart regardless of quantity
  void removeItemCompletely(String serviceId) {
    cartItems.removeWhere((i) => i.service.id == serviceId);
    cartItems.refresh();
  }

  /// Clear all items from active cart
  void clearCart() {
    cartItems.clear();
  }

  /// Proceed to checkout / address selection flow
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
