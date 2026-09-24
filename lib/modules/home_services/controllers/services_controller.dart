import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sewasetu/app/theme/app_colors.dart';
import 'package:sewasetu/shared/enums/view_state.dart';
import '../data/services_mock_data.dart';
import '../models/service_category_item.dart';
import '../models/service_faq_item.dart';
import '../models/service_offer_item.dart';
import '../models/service_popular_item.dart';
import '../models/service_relocation_item.dart';
import '../models/service_review_item.dart';
import '../models/service_spotlight_item.dart';
import '../models/service_subcategory_item.dart';

/// GetX controller managing UI state, interactive actions, and future backend feeds
/// for the primary Services screen.
class ServicesController extends GetxController {
  final state = ViewState.initial.obs;

  // Active page index for promotional offers carousel
  final offerPageIndex = 0.obs;

  // Track expanded FAQs
  final expandedFaqIds = <String>{}.obs;

  // Data streams (structured for direct backend API swap)
  final headerCategories = <ServiceCategoryItem>[].obs;
  final promotionalOffers = <ServiceOfferItem>[].obs;
  final spotlightService = Rxn<ServiceSpotlightItem>();
  final cleaningSubcategories = <ServiceSubcategoryItem>[].obs;
  final repairSubcategories = <ServiceSubcategoryItem>[].obs;
  final popularServices = <ServicePopularItem>[].obs;
  final relocationOptions = <ServiceRelocationItem>[].obs;
  final customerReviews = <ServiceReviewItem>[].obs;
  final faqItems = <ServiceFaqItem>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadServicesData();
  }

  /// Initial load / mock fetch with state management
  Future<void> loadServicesData() async {
    state.value = ViewState.loading;
    try {
      // Simulate minor network latency
      await Future<void>.delayed(const Duration(milliseconds: 150));

      headerCategories.assignAll(ServicesMockData.headerCategories);
      promotionalOffers.assignAll(ServicesMockData.promotionalOffers);
      spotlightService.value = ServicesMockData.spotlightService;
      cleaningSubcategories.assignAll(ServicesMockData.homeCleaningSubcategories);
      repairSubcategories.assignAll(ServicesMockData.homeRepairSubcategories);
      popularServices.assignAll(ServicesMockData.popularServices);
      relocationOptions.assignAll(ServicesMockData.relocationOptions);
      customerReviews.assignAll(ServicesMockData.customerReviews);
      faqItems.assignAll(ServicesMockData.faqItems);

      state.value = ViewState.loaded;
    } catch (e) {
      state.value = ViewState.error;
    }
  }

  /// Pull-to-refresh handler
  Future<void> refreshServices() async {
    await loadServicesData();
  }

  /// Updates current active carousel offer index
  void setOfferPageIndex(int index) {
    offerPageIndex.value = index;
  }

  /// Toggle accordion FAQ item
  void toggleFaq(String id) {
    if (expandedFaqIds.contains(id)) {
      expandedFaqIds.remove(id);
    } else {
      expandedFaqIds.add(id);
    }
  }

  bool isFaqExpanded(String id) => expandedFaqIds.contains(id);

  /// Copy coupon code to clipboard with user notification
  Future<void> copyCoupon(String code) async {
    await Clipboard.setData(ClipboardData(text: code));
    Get.snackbar(
      'Coupon Copied',
      'Coupon code "$code" copied to clipboard!',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.primary,
      colorText: AppColors.textWhite,
      duration: const Duration(seconds: 2),
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
    );
  }

  /// Handle service booking action
  void onBookService(String serviceName) {
    Get.snackbar(
      'Booking Service',
      'Starting booking flow for "$serviceName"...',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.primary,
      colorText: AppColors.textWhite,
      duration: const Duration(seconds: 2),
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
    );
  }

  /// Handle category tap
  void onCategorySelected(String categoryName) {
    Get.snackbar(
      'Category Selected',
      'Browsing $categoryName services...',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.primaryDark,
      colorText: AppColors.textWhite,
      duration: const Duration(seconds: 2),
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
    );
  }
}
