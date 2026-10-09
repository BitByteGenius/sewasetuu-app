import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/kitchen_cleaning_controller.dart';
import '../../common_widgets/home_service_base_screen.dart';

/// Primary detail screen for Kitchen Cleaning module matching all 8 reference mockups,
/// powered by master reusable HomeServiceBaseScreen.
class KitchenCleaningScreen extends StatelessWidget {
  const KitchenCleaningScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.isRegistered<KitchenCleaningController>()
        ? Get.find<KitchenCleaningController>()
        : Get.put(KitchenCleaningController());

    return Obx(() {
      final services = controller.services;
      final occupiedServices =
          services.where((s) => s.sectionId == 'occupied').toList();
      final emptyServices =
          services.where((s) => s.sectionId == 'empty').toList();
      final applianceServices =
          services.where((s) => s.sectionId == 'appliances').toList();
      final miniServices =
          services.where((s) => s.sectionId == 'mini').toList();

      final sections = [
        HomeServiceSectionData(
          id: 'occupied',
          title: 'Occupied Kitchen Cleaning',
          heroImageUrl:
              'https://images.unsplash.com/photo-1556911220-e15b29be8c8f?auto=format&fit=crop&w=800&q=80',
          promoTag: 'FLAT 10% off',
          promoCode: 'NEWCLEAN10',
          key: controller.occupiedSectionKey,
          services: occupiedServices,
        ),
        HomeServiceSectionData(
          id: 'empty',
          title: 'Empty Kitchen Cleaning',
          heroImageUrl:
              'https://images.unsplash.com/photo-1600585154340-be6161a56a0c?auto=format&fit=crop&w=800&q=80',
          promoTag: 'FLAT 10% off',
          promoCode: 'NEWCLEAN10',
          key: controller.emptySectionKey,
          services: emptyServices,
        ),
        HomeServiceSectionData(
          id: 'appliances',
          title: 'Appliance Deep Cleaning',
          heroImageUrl:
              'https://images.unsplash.com/photo-1584622650111-993a426fbf0a?auto=format&fit=crop&w=800&q=80',
          promoTag: 'BEST DEALS',
          promoCode: 'APPLIANCE10',
          services: applianceServices,
        ),
      ];

      return HomeServiceBaseScreen(
        title: 'Kitchen Cleaning',
        rating: 4.77,
        ratingCountText: '(192.2K+ ratings)',
        state: controller.state.value,
        onRetry: controller.loadData,
        categories: controller.navCategories,
        activeCategoryId: controller.activeNavCategory.value,
        onSelectCategory: controller.scrollToSection,
        promoBanners: controller.promoBanners,
        onCopyPromoCode: controller.copyPromoCode,
        sections: sections,
        miniServices: miniServices,
        miniSectionKey: controller.miniSectionKey,
        ratingBreakdown: controller.ratingBreakdown.value,
        whyUsFeatures: controller.whyUsFeatures,
        faqItems: controller.faqItems,
        expandedFaqIds: controller.expandedFaqIds,
        onToggleFaq: controller.toggleFaq,
        totalCartCount: controller.totalCartCount,
        totalCartPrice: controller.totalCartPrice,
        getItemQuantity: controller.getItemQuantity,
        isDetailsExpanded: controller.isDetailsExpanded,
        onToggleDetails: controller.toggleDetails,
        onAddItem: controller.addItem,
        onDecrementItem: controller.decrementItem,
        scrollController: controller.scrollController,
        showBackButton: false,
      );
    });
  }
}
