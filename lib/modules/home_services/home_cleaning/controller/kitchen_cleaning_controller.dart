import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sewasetu/app/theme/app_colors.dart';
import 'package:sewasetu/shared/enums/view_state.dart';
import '../data/kitchen_cleaning_data.dart';
import '../models/kitchen_cleaning_model.dart';

/// GetX controller managing state, cart, smooth scrolling, and user interactions
/// for the Kitchen Cleaning detail screen.
class KitchenCleaningController extends GetxController {
  final state = ViewState.loaded.obs;

  // Scroll Controller for section navigation
  final ScrollController scrollController = ScrollController();

  // Data streams
  final navCategories = <KitchenCleaningNavCategory>[].obs;
  final promoBanners = <KitchenCleaningOfferBanner>[].obs;
  final services = <KitchenCleaningServiceItem>[].obs;
  final activeNavCategory = 'occupied'.obs;

  // Expanded "View details" set
  final expandedDetails = <String>{}.obs;

  // Ratings, Why Us, and FAQ state streams
  final ratingBreakdown = KitchenCleaningData.ratingBreakdown.obs;
  final whyUsFeatures = <String>[].obs;
  final faqItems = <KitchenFaqItem>[].obs;
  final expandedFaqIds = <String>{}.obs;

  // Reactive Cart State
  final cartItems = <KitchenCartItem>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  void loadData() {
    state.value = ViewState.loading;
    try {
      navCategories.assignAll(KitchenCleaningData.navCategories);
      promoBanners.assignAll(KitchenCleaningData.promoBanners);
      services.assignAll(KitchenCleaningData.allServices);
      whyUsFeatures.assignAll(KitchenCleaningData.whyUsFeatures);
      faqItems.assignAll(KitchenCleaningData.faqItems);
      state.value = ViewState.loaded;
    } catch (e) {
      state.value = ViewState.error;
    }
  }

  // --- CART GETTERS ---
  int get totalCartCount =>
      cartItems.fold(0, (sum, item) => sum + item.quantity);

  double get totalCartPrice =>
      cartItems.fold(0.0, (sum, item) => sum + item.totalPrice);

  bool get isCartNotEmpty => cartItems.isNotEmpty;

  int getItemQuantity(String serviceId) {
    final found = cartItems.firstWhereOrNull((i) => i.service.id == serviceId);
    return found?.quantity ?? 0;
  }

  KitchenCartItem? getCartItem(String serviceId) {
    return cartItems.firstWhereOrNull((i) => i.service.id == serviceId);
  }

  // --- CART ACTIONS ---
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

  // --- UI INTERACTION ACTIONS ---
  void toggleDetails(String serviceId) {
    if (expandedDetails.contains(serviceId)) {
      expandedDetails.remove(serviceId);
    } else {
      expandedDetails.add(serviceId);
    }
  }

  bool isDetailsExpanded(String serviceId) =>
      expandedDetails.contains(serviceId);

  void toggleFaq(String faqId) {
    if (expandedFaqIds.contains(faqId)) {
      expandedFaqIds.remove(faqId);
    } else {
      expandedFaqIds.add(faqId);
    }
  }

  Future<void> copyPromoCode(String code) async {
    await Clipboard.setData(ClipboardData(text: code));
    Get.snackbar(
      'Code Copied',
      'Coupon "$code" copied to clipboard!',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.primary,
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
    );
  }

  /// Scroll smoothly to target section
  void scrollToSection(String sectionId) {
    activeNavCategory.value = sectionId;
    double offset = 0;
    if (sectionId == 'occupied') {
      offset = 240;
    } else if (sectionId == 'empty') {
      offset = 950;
    } else if (sectionId == 'mini') {
      offset = 1800;
    }

    if (scrollController.hasClients) {
      scrollController.animateTo(
        offset,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOutCubic,
      );
    }
  }
}
