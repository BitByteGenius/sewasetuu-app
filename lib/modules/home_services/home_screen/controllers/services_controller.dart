import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sewasetu/app/routes/app_routes.dart';
import 'package:sewasetu/app/theme/app_colors.dart';
import 'package:sewasetu/modules/home_services/home_cleaning/widgets/home_cleaning_bottom_sheet.dart';
import 'package:sewasetu/shared/enums/view_state.dart';
import '../data/services_repository.dart';
import '../models/service_category_item.dart';
import '../models/service_faq_item.dart';
import '../models/service_offer_item.dart';
import '../models/service_popular_item.dart';
import '../models/service_relocation_item.dart';
import '../models/service_review_item.dart';
import '../models/service_spotlight_item.dart';
import '../models/service_subcategory_item.dart';
import '../widgets/instant_services_bottom_sheet.dart';

/// GetX controller managing UI state, interactive actions, and repository data feeds
/// for the primary Services screen.
class ServicesController extends GetxController {
  final ServicesRepository _repository;

  ServicesController({ServicesRepository? repository})
      : _repository = repository ?? ServicesRepositoryImpl();

  final state = ViewState.initial.obs;

  // Active page index for promotional offers carousel
  final offerPageIndex = 0.obs;

  // Track expanded FAQs
  final expandedFaqIds = <String>{}.obs;

  // Data streams (decoupled via ServicesRepository for 1-click backend integration)
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

  /// Initial load / API fetch with parallel execution and state management
  Future<void> loadServicesData() async {
    state.value = ViewState.loading;
    try {
      final results = await Future.wait([
        _repository.getHeaderCategories(),
        _repository.getPromotionalOffers(),
        _repository.getSpotlightService(),
        _repository.getCleaningSubcategories(),
        _repository.getRepairSubcategories(),
        _repository.getPopularServices(),
        _repository.getRelocationOptions(),
        _repository.getCustomerReviews(),
        _repository.getFaqItems(),
      ]);

      headerCategories.assignAll(results[0] as List<ServiceCategoryItem>);
      promotionalOffers.assignAll(results[1] as List<ServiceOfferItem>);
      spotlightService.value = results[2] as ServiceSpotlightItem?;
      cleaningSubcategories.assignAll(results[3] as List<ServiceSubcategoryItem>);
      repairSubcategories.assignAll(results[4] as List<ServiceSubcategoryItem>);
      popularServices.assignAll(results[5] as List<ServicePopularItem>);
      relocationOptions.assignAll(results[6] as List<ServiceRelocationItem>);
      customerReviews.assignAll(results[7] as List<ServiceReviewItem>);
      faqItems.assignAll(results[8] as List<ServiceFaqItem>);

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
  void onCategorySelected(String categoryName, [BuildContext? context]) {
    final lowerName = categoryName.trim().toLowerCase();
    final ctx = context ?? Get.context;

    if (lowerName.contains('home cleaning') || lowerName == 'cleaning') {
      if (ctx != null) {
        HomeCleaningBottomSheet.show(ctx);
        return;
      }
    }

    if (lowerName.contains('instant')) {
      if (ctx != null) {
        InstantServicesBottomSheet.show(ctx);
        return;
      }
    }

    if (lowerName.contains('electrician')) {
      Get.toNamed(AppRoutes.electrician);
      return;
    }

    if (lowerName.contains('plumb')) {
      Get.toNamed(AppRoutes.plumbing);
      return;
    }

    if (lowerName.contains('carpent')) {
      Get.toNamed(AppRoutes.carpenter);
      return;
    }

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
