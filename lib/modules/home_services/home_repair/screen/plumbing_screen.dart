import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../common_widgets/home_service_base_screen.dart';
import '../controller/plumbing_controller.dart';

/// Production-grade Plumbing detail screen powered by master reusable HomeServiceBaseScreen.
/// Features image-based header categories, exact Card UI, stepper animations, and section scroll.
class PlumbingScreen extends StatelessWidget {
  const PlumbingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.isRegistered<PlumbingController>()
        ? Get.find<PlumbingController>()
        : Get.put(PlumbingController());

    return Obx(() {
      final services = controller.services;
      final toiletServices =
          services.where((s) => s.sectionId == 'plumb_sec_toilet').toList();
      final tapServices =
          services.where((s) => s.sectionId == 'plumb_sec_tap').toList();
      final pipeServices =
          services.where((s) => s.sectionId == 'plumb_sec_pipe').toList();
      final miniServices =
          services.where((s) => s.sectionId == 'mini').toList();

      final sections = [
        HomeServiceSectionData(
          id: 'plumb_sec_toilet',
          title: 'Toilet & Leakage Repair',
          heroImageUrl:
              'https://images.unsplash.com/photo-1584622650111-993a426fbf0a?auto=format&fit=crop&w=800&q=80',
          promoTag: 'FLAT 10% off',
          promoCode: 'LEAKFREE',
          key: controller.toiletSectionKey,
          services: toiletServices,
        ),
        HomeServiceSectionData(
          id: 'plumb_sec_tap',
          title: 'Taps, Basins & Drainage',
          heroImageUrl:
              'https://images.unsplash.com/photo-1542013936693-884638332954?auto=format&fit=crop&w=800&q=80',
          promoTag: 'FLAT 15% off',
          promoCode: 'PLUMB15',
          key: controller.tapSectionKey,
          services: tapServices,
        ),
        HomeServiceSectionData(
          id: 'plumb_sec_pipe',
          title: 'Pipes & Water Tank Services',
          heroImageUrl:
              'https://images.unsplash.com/photo-1621905251189-08b45d6a269e?auto=format&fit=crop&w=800&q=80',
          promoTag: 'SPECIAL OFFER',
          promoCode: 'CLEANTANK',
          key: controller.pipeSectionKey,
          services: pipeServices,
        ),
      ];

      return HomeServiceBaseScreen(
        title: 'Plumbing Services',
        rating: 4.84,
        ratingCountText: '(118.5K+ ratings)',
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
