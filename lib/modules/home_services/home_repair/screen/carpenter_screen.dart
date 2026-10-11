import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../common_widgets/home_service_base_screen.dart';
import '../controller/carpenter_controller.dart';

/// Production-grade Carpentry detail screen powered by master reusable HomeServiceBaseScreen.
/// Features image-based header categories, exact Card UI, stepper animations, and section scroll.
class CarpenterScreen extends StatelessWidget {
  const CarpenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.isRegistered<CarpenterController>()
        ? Get.find<CarpenterController>()
        : Get.put(CarpenterController());

    return Obx(() {
      final services = controller.services;
      final doorServices =
          services.where((s) => s.sectionId == 'carp_sec_door').toList();
      final drillServices =
          services.where((s) => s.sectionId == 'carp_sec_drill').toList();
      final assemblyServices =
          services.where((s) => s.sectionId == 'carp_sec_assembly').toList();
      final miniServices =
          services.where((s) => s.sectionId == 'mini').toList();

      final sections = [
        HomeServiceSectionData(
          id: 'carp_sec_door',
          title: 'Door & Lock Repair Services',
          heroImageUrl:
              'https://images.unsplash.com/photo-1517646287270-a5a9ca602e5c?auto=format&fit=crop&w=800&q=80',
          promoTag: 'FLAT 10% off',
          promoCode: 'WOOD10',
          key: controller.doorSectionKey,
          services: doorServices,
        ),
        HomeServiceSectionData(
          id: 'carp_sec_drill',
          title: 'Drilling, Mounting & Hanging',
          heroImageUrl:
              'https://images.unsplash.com/photo-1581783342308-f792dbdd27c5?auto=format&fit=crop&w=800&q=80',
          promoTag: 'QUICK FIX',
          promoCode: 'DRILL149',
          key: controller.drillSectionKey,
          services: drillServices,
        ),
        HomeServiceSectionData(
          id: 'carp_sec_assembly',
          title: 'Furniture & Cupboard Services',
          heroImageUrl:
              'https://images.unsplash.com/photo-1538688525198-9b88f6f53126?auto=format&fit=crop&w=800&q=80',
          promoTag: 'FURNITURE DEAL',
          promoCode: 'FURN10',
          key: controller.assemblySectionKey,
          services: assemblyServices,
        ),
      ];

      return HomeServiceBaseScreen(
        title: 'Carpentry Services',
        rating: 4.85,
        ratingCountText: '(96.4K+ ratings)',
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
        showBackButton: true,
      );
    });
  }
}
