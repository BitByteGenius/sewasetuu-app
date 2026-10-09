import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../common_widgets/home_service_base_screen.dart';
import '../controller/electrician_controller.dart';

/// Production-grade Electrician detail screen powered by master reusable HomeServiceBaseScreen.
/// Features image-based header categories, exact Card UI, stepper animations, and section scroll.
class ElectricianScreen extends StatelessWidget {
  const ElectricianScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.isRegistered<ElectricianController>()
        ? Get.find<ElectricianController>()
        : Get.put(ElectricianController());

    return Obx(() {
      final services = controller.services;
      final geyserServices =
          services.where((s) => s.sectionId == 'geyser_heavy').toList();
      final lightServices =
          services.where((s) => s.sectionId == 'light_fan').toList();
      final mcbServices =
          services.where((s) => s.sectionId == 'mcb_wiring').toList();
      final miniServices =
          services.where((s) => s.sectionId == 'mini').toList();

      final sections = [
        HomeServiceSectionData(
          id: 'geyser_heavy',
          title: 'Geyser & Heavy Appliances',
          heroImageUrl:
              'https://images.unsplash.com/photo-1584622650111-993a426fbf0a?auto=format&fit=crop&w=800&q=80',
          promoTag: 'FLAT 15% off',
          promoCode: 'ELEC15',
          key: controller.geyserSectionKey,
          services: geyserServices,
        ),
        HomeServiceSectionData(
          id: 'light_fan',
          title: 'Lights, Fans & Decorative Fixtures',
          heroImageUrl:
              'https://images.unsplash.com/photo-1565814636199-ae8133055c1c?auto=format&fit=crop&w=800&q=80',
          promoTag: 'FLAT 10% off',
          promoCode: 'LIGHT10',
          key: controller.lightSectionKey,
          services: lightServices,
        ),
        HomeServiceSectionData(
          id: 'mcb_wiring',
          title: 'MCB, Switchboard & Safety Wiring',
          heroImageUrl:
              'https://images.unsplash.com/photo-1558494949-ef010cbdcc31?auto=format&fit=crop&w=800&q=80',
          promoTag: 'SAFETY OFFER',
          promoCode: 'SAFE10',
          key: controller.mcbSectionKey,
          services: mcbServices,
        ),
      ];

      return HomeServiceBaseScreen(
        title: 'Electrician Services',
        rating: 4.82,
        ratingCountText: '(142.8K+ ratings)',
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
