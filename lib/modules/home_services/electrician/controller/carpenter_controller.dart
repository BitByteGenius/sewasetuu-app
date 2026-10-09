import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sewasetu/app/theme/app_colors.dart';
import 'package:sewasetu/shared/enums/view_state.dart';
import '../../controller/home_services_cart_controller.dart';
import '../../home_cleaning/models/kitchen_cleaning_model.dart';
import '../data/home_services_data.dart';

/// Production-ready GetX Controller managing state, cart, section navigation,
/// and interactivity for Carpenter Screen matching Kitchen Cleaning architecture.
class CarpenterController extends GetxController {
  final state = ViewState.loaded.obs;
  final ScrollController scrollController = ScrollController();

  HomeServicesCartController get _cartController =>
      HomeServicesCartController.instance;

  // Primary Data Streams
  final navCategories = <KitchenCleaningNavCategory>[].obs;
  final promoBanners = <KitchenCleaningOfferBanner>[].obs;
  final services = <KitchenCleaningServiceItem>[].obs;
  final activeNavCategory = 'carp_sec_door'.obs;

  // Expanded details & FAQ state
  final expandedDetails = <String>{}.obs;
  final ratingBreakdown = HomeServicesData.ratingBreakdown.obs;
  final whyUsFeatures = HomeServicesData.defaultWhyUsFeatures.obs;
  final faqItems = HomeServicesData.defaultFaqs.obs;
  final expandedFaqIds = <String>{}.obs;

  // Section Keys for smooth scrolling
  final GlobalKey doorSectionKey = GlobalKey();
  final GlobalKey drillSectionKey = GlobalKey();
  final GlobalKey assemblySectionKey = GlobalKey();
  final GlobalKey miniSectionKey = GlobalKey();

  bool _isProgrammaticScroll = false;

  @override
  void onInit() {
    super.onInit();
    loadData();
    scrollController.addListener(_onScrollUpdate);
  }

  @override
  void onClose() {
    scrollController.removeListener(_onScrollUpdate);
    scrollController.dispose();
    super.onClose();
  }

  void _onScrollUpdate() {
    if (_isProgrammaticScroll || !scrollController.hasClients) return;

    final scrollOffset = scrollController.offset;
    final doorOffset = _getWidgetOffset(doorSectionKey);
    final drillOffset = _getWidgetOffset(drillSectionKey);
    final assemblyOffset = _getWidgetOffset(assemblySectionKey);

    String? targetCategory;
    if (assemblyOffset != null && scrollOffset >= assemblyOffset - 150) {
      targetCategory = 'carp_sec_assembly';
    } else if (drillOffset != null && scrollOffset >= drillOffset - 150) {
      targetCategory = 'carp_sec_drill';
    } else if (doorOffset != null && scrollOffset >= doorOffset - 150) {
      targetCategory = 'carp_sec_door';
    }

    if (targetCategory != null && activeNavCategory.value != targetCategory) {
      final newCategory = targetCategory;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (activeNavCategory.value != newCategory) {
          activeNavCategory.value = newCategory;
        }
      });
    }
  }

  double? _getWidgetOffset(GlobalKey key) {
    final context = key.currentContext;
    if (context == null) return null;
    final renderBox = context.findRenderObject() as RenderBox?;
    if (renderBox == null || !renderBox.attached) return null;
    final position = renderBox.localToGlobal(Offset.zero);
    return position.dy + scrollController.offset - kToolbarHeight - 60;
  }

  void loadData() {
    state.value = ViewState.loading;
    try {
      navCategories.assignAll(HomeServicesData.carpentryNavCategories);
      promoBanners.assignAll(HomeServicesData.carpentryBanners);
      services.assignAll(HomeServicesData.carpentryServices);
      whyUsFeatures.assignAll(HomeServicesData.defaultWhyUsFeatures);
      faqItems.assignAll(HomeServicesData.defaultFaqs);
      state.value = ViewState.loaded;
    } catch (e) {
      state.value = ViewState.error;
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

  bool isDetailsExpanded(String serviceId) => expandedDetails.contains(serviceId);

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

  void scrollToSection(String sectionId) {
    activeNavCategory.value = sectionId;
    final targetKey = _getSectionKey(sectionId);
    final context = targetKey?.currentContext;

    if (context != null) {
      _isProgrammaticScroll = true;
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOutCubic,
        alignment: 0.0,
      ).then((_) {
        _isProgrammaticScroll = false;
      });
    } else {
      double offset = 0;
      if (sectionId == 'carp_sec_door') {
        offset = 240;
      } else if (sectionId == 'carp_sec_drill') {
        offset = 800;
      } else if (sectionId == 'carp_sec_assembly') {
        offset = 1400;
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

  GlobalKey? _getSectionKey(String sectionId) {
    switch (sectionId) {
      case 'carp_sec_door':
        return doorSectionKey;
      case 'carp_sec_drill':
        return drillSectionKey;
      case 'carp_sec_assembly':
        return assemblySectionKey;
      default:
        return null;
    }
  }

  // --- SHARED CART INTEGRATION DELEGATES ---
  int get totalCartCount => _cartController.totalCartCount;
  double get totalCartPrice => _cartController.totalCartPrice;

  int getItemQuantity(String serviceId) => _cartController.getItemQuantity(serviceId);

  void addItem(KitchenCleaningServiceItem service, [ServiceOptionItem? option]) {
    _cartController.addItem(service, option);
  }

  void decrementItem(String serviceId) {
    _cartController.decrementItem(serviceId);
  }
}
