import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sewasetu/app/theme/app_colors.dart';
import 'package:sewasetu/shared/enums/view_state.dart';
import '../../controller/home_services_cart_controller.dart';
import '../data/kitchen_cleaning_data.dart';
import '../models/kitchen_cleaning_model.dart';

/// GetX controller managing state, cart, smooth scrolling, and user interactions
/// for the Kitchen Cleaning detail screen.
class KitchenCleaningController extends GetxController {
  final state = ViewState.loaded.obs;

  HomeServicesCartController get _cartController =>
      HomeServicesCartController.instance;

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

  // Reactive Cart State delegated to central HomeServicesCartController
  RxList<KitchenCartItem> get cartItems => _cartController.cartItems;

  // Section GlobalKeys for precise viewport scrolling
  final GlobalKey occupiedSectionKey = GlobalKey();
  final GlobalKey emptySectionKey = GlobalKey();
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
    final occupiedOffset = _getWidgetOffset(occupiedSectionKey);
    final emptyOffset = _getWidgetOffset(emptySectionKey);
    final miniOffset = _getWidgetOffset(miniSectionKey);

    String? targetCategory;
    if (miniOffset != null && scrollOffset >= miniOffset - 150) {
      targetCategory = 'mini';
    } else if (emptyOffset != null && scrollOffset >= emptyOffset - 150) {
      targetCategory = 'empty';
    } else if (occupiedOffset != null && scrollOffset >= occupiedOffset - 150) {
      targetCategory = 'occupied';
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
  int get totalCartCount => _cartController.totalCartCount;

  double get totalCartPrice => _cartController.totalCartPrice;

  bool get isCartNotEmpty => _cartController.isCartNotEmpty;

  int getItemQuantity(String serviceId) => _cartController.getItemQuantity(serviceId);

  KitchenCartItem? getCartItem(String serviceId) => _cartController.getCartItem(serviceId);

  // --- CART ACTIONS ---
  void addItem(KitchenCleaningServiceItem service, [ServiceOptionItem? option]) {
    _cartController.addItem(service, option);
  }

  void decrementItem(String serviceId) {
    _cartController.decrementItem(serviceId);
  }

  void removeItemCompletely(String serviceId) {
    _cartController.removeItemCompletely(serviceId);
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

  /// Scroll smoothly to target section using GlobalKeys
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

  GlobalKey? _getSectionKey(String sectionId) {
    switch (sectionId) {
      case 'occupied':
        return occupiedSectionKey;
      case 'empty':
        return emptySectionKey;
      case 'mini':
        return miniSectionKey;
      default:
        return null;
    }
  }
}
