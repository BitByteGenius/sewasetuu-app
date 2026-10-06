import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sewasetu/app/theme/app_colors.dart';
import 'package:sewasetu/shared/enums/view_state.dart';
import '../../home_cleaning/controller/kitchen_cleaning_controller.dart';
import '../../home_cleaning/models/kitchen_cleaning_model.dart';
import '../data/home_services_data.dart';
import '../models/home_service_model.dart';

/// GetX controller managing state, category selection, search filtering,
/// promo actions, and cart integration for Carpenter Screen.
class CarpenterController extends GetxController {
  final state = ViewState.loaded.obs;

  // Primary data streams
  final categories = <HomeServiceCategory>[].obs;
  final promoBanners = <HomeServiceOfferBanner>[].obs;
  final services = <HomeServiceItem>[].obs;
  final activeCategoryId = 'all'.obs;
  final showAllCategories = false.obs;
  final searchQuery = ''.obs;

  // Rating & FAQ state
  final ratingBreakdown = HomeServicesData.ratingBreakdown.obs;
  final whyUsFeatures = HomeServicesData.defaultWhyUsFeatures.obs;
  final faqItems = HomeServicesData.defaultFaqs.obs;
  final expandedFaqIds = <String>{}.obs;

  /// Cart controller connection for shared cart state across Home Services
  KitchenCleaningController get _cartController {
    if (Get.isRegistered<KitchenCleaningController>()) {
      return Get.find<KitchenCleaningController>();
    }
    return Get.put(KitchenCleaningController());
  }

  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  void loadData() {
    state.value = ViewState.loading;
    try {
      categories.assignAll(HomeServicesData.carpentryCategories);
      promoBanners.assignAll(HomeServicesData.carpentryBanners);
      services.assignAll(HomeServicesData.carpentryServices);
      state.value = ViewState.loaded;
    } catch (e) {
      state.value = ViewState.error;
    }
  }

  // Filtered Services according to active Category & Search query
  List<HomeServiceItem> get filteredServices {
    var result = services.toList();

    // 1. Category Filter
    if (activeCategoryId.value != 'all' && activeCategoryId.value.isNotEmpty) {
      result = result
          .where((s) => s.categoryId == activeCategoryId.value)
          .toList();
    }

    // 2. Search Filter
    if (searchQuery.value.trim().isNotEmpty) {
      final query = searchQuery.value.trim().toLowerCase();
      result = result
          .where((s) =>
              s.title.toLowerCase().contains(query) ||
              (s.description?.toLowerCase().contains(query) ?? false) ||
              s.bulletPoints.any((bp) => bp.toLowerCase().contains(query)))
          .toList();
    }

    return result;
  }

  void selectCategory(String catId) {
    if (activeCategoryId.value == catId) {
      activeCategoryId.value = 'all';
    } else {
      activeCategoryId.value = catId;
    }
  }

  void toggleCategoryExpand() {
    showAllCategories.value = !showAllCategories.value;
  }

  void setSearchQuery(String query) {
    searchQuery.value = query;
  }

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

  // --- SHARED CART INTEGRATION DELEGATES ---
  int get totalCartCount => _cartController.totalCartCount;
  double get totalCartPrice => _cartController.totalCartPrice;

  int getItemQuantity(String serviceId) =>
      _cartController.getItemQuantity(serviceId);

  void addItem(HomeServiceItem service, [ServiceOptionItem? option]) {
    _cartController.addItem(service.toKitchenCleaningItem(), option);
  }

  void decrementItem(String serviceId) {
    _cartController.decrementItem(serviceId);
  }
}
