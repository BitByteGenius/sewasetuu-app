import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'kitchen_cleaning_controller.dart';
import '../data/kitchen_cleaning_data.dart';
import '../models/kitchen_cleaning_model.dart';

/// Dedicated GetX Controller managing logic, cart operations, add-on data,
/// and checkout actions for [MyCartWidgets].
class MyCartController extends GetxController {
  /// Access or initialize the primary KitchenCleaningController for unified state
  KitchenCleaningController get _cleaningController {
    if (Get.isRegistered<KitchenCleaningController>()) {
      return Get.find<KitchenCleaningController>();
    }
    return Get.put(KitchenCleaningController());
  }

  /// Reactive stream of cart items from the primary controller
  RxList<KitchenCartItem> get cartItems => _cleaningController.cartItems;

  /// Live total price calculation
  double get totalCartPrice => _cleaningController.totalCartPrice;

  /// Live total item count
  int get totalCartCount => _cleaningController.totalCartCount;

  /// Check if the cart has any items
  bool get hasCartItems => _cleaningController.isCartNotEmpty;

  /// Recommended add-on services list derived from 'mini' services data
  List<KitchenCleaningServiceItem> get recommendedAddons {
    final miniServices =
        _cleaningController.services.where((s) => s.sectionId == 'mini').toList();
    if (miniServices.isNotEmpty) {
      return miniServices;
    }
    return KitchenCleaningData.allServices
        .where((s) => s.sectionId == 'mini')
        .toList();
  }

  /// Add a service or option to cart
  void addItem(KitchenCleaningServiceItem service, [ServiceOptionItem? option]) {
    _cleaningController.addItem(service, option);
  }

  /// Decrement item quantity or remove if quantity reaches 0
  void decrementItem(String serviceId) {
    _cleaningController.decrementItem(serviceId);
  }

  /// Remove item completely from cart
  void removeItemCompletely(String serviceId) {
    _cleaningController.removeItemCompletely(serviceId);
  }

  /// Get current quantity of a specific item
  int getItemQuantity(String serviceId) {
    return _cleaningController.getItemQuantity(serviceId);
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
