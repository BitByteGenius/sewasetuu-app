import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sewasetu/app/theme/app_colors.dart';
import 'package:sewasetu/modules/home/widgets/home_location_header_widget.dart';
import 'package:sewasetu/shared/enums/view_state.dart';
import 'package:sewasetu/shared/widgets/app_bar/app_bar.dart';
import 'package:sewasetu/shared/widgets/app_skeleton.dart';

import '../controller/kitchen_cleaning_controller.dart';
import '../widgets/kitchen_cleaning_cart_bar.dart';
import '../widgets/kitchen_cleaning_faq_widget.dart';
import '../widgets/kitchen_cleaning_header_widget.dart';
import '../widgets/kitchen_cleaning_mini_service_grid.dart';
import '../widgets/kitchen_cleaning_offer_carousel.dart';
import '../widgets/kitchen_cleaning_promise_widget.dart';
import '../widgets/kitchen_cleaning_reviews_breakdown_widget.dart';
import '../widgets/kitchen_cleaning_service_card.dart';

/// Primary detail screen for Kitchen Cleaning module matching all 8 reference mockups.
class KitchenCleaningScreen extends StatelessWidget {
  const KitchenCleaningScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final controller = Get.isRegistered<KitchenCleaningController>()
        ? Get.find<KitchenCleaningController>()
        : Get.put(KitchenCleaningController());

    return Scaffold(
      backgroundColor:
          isDark ? AppColors.backgroundDark : const Color(0xFFF8FAFC),
      appBar: SewaAppBar(
        titleWidget: const HomeLocationHeaderWidget(
          showNotification: false,
          showProfile: false,
        ),
        showBackButton: false,
        actions: [
          // Search Action Button
          IconButton(
            icon: const Icon(Icons.search_rounded),
            onPressed: () {
              Get.snackbar(
                'Search',
                'Searching kitchen cleaning services...',
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: AppColors.primary,
                colorText: Colors.white,
                duration: const Duration(seconds: 2),
                margin: const EdgeInsets.all(16),
                borderRadius: 12,
              );
            },
          ),

          // Shopping Cart Action Icon with Counter Badge
          Obx(() {
            final cartCount = controller.totalCartCount;
            return Stack(
              alignment: Alignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.shopping_cart_outlined),
                  onPressed: () {
                    if (controller.isCartNotEmpty) {
                      Get.snackbar(
                        'Cart Summary',
                        '${controller.totalCartCount} items selected. Total: ₹${controller.totalCartPrice.toStringAsFixed(0)}',
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: const Color(0xFF0F766E),
                        colorText: Colors.white,
                        duration: const Duration(seconds: 3),
                        margin: const EdgeInsets.all(16),
                        borderRadius: 12,
                      );
                    }
                  },
                ),
                if (cartCount > 0)
                  Positioned(
                    top: 6,
                    right: 6,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Color(0xFFE11D48), // Rose Red Badge
                        shape: BoxShape.circle,
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 18,
                        minHeight: 18,
                      ),
                      child: Text(
                        '$cartCount',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            );
          }),
        ],
      ),
      body: Obx(() {
        if (controller.state.value == ViewState.loading) {
          return const Center(
              child: AppSkeleton(height: 300, width: double.infinity));
        }

        final services = controller.services;
        final occupiedServices =
            services.where((s) => s.sectionId == 'occupied').toList();
        final emptyServices =
            services.where((s) => s.sectionId == 'empty').toList();
        final applianceServices =
            services.where((s) => s.sectionId == 'appliances').toList();
        final miniServices =
            services.where((s) => s.sectionId == 'mini').toList();

        return Stack(
          children: [
            SingleChildScrollView(
              controller: controller.scrollController,
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.only(bottom: 110),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 1. Top Header with Ratings & 3-card Category Nav Bar
                  KitchenCleaningHeaderWidget(
                    categories: controller.navCategories,
                    activeCategoryId: controller.activeNavCategory.value,
                    onSelectCategory: controller.scrollToSection,
                  ),

                  const SizedBox(height: 16),

                  // 2. Promotional Offers Carousel
                  KitchenCleaningOfferCarousel(
                    promoBanners: controller.promoBanners,
                    onCopyCode: controller.copyPromoCode,
                  ),

                  const SizedBox(height: 16),

                  // 3. SECTION 1: Occupied Kitchen Cleaning
                  _buildSectionHeader(
                    context,
                    title: 'Occupied Kitchen Cleaning',
                    heroImageUrl:
                        'https://images.unsplash.com/photo-1556911220-e15b29be8c8f?auto=format&fit=crop&w=800&q=80',
                    isDark: isDark,
                  ),

                  ...occupiedServices.map((service) => Obx(() {
                        return KitchenCleaningServiceCard(
                          item: service,
                          quantity: controller.getItemQuantity(service.id),
                          isExpanded: controller.isDetailsExpanded(service.id),
                          onToggleExpand: () =>
                              controller.toggleDetails(service.id),
                          onAdd: (opt) => controller.addItem(service, opt),
                          onDecrement: () =>
                              controller.decrementItem(service.id),
                        );
                      })),

                  const SizedBox(height: 16),

                  // 4. SECTION 2: Empty Kitchen Cleaning
                  _buildSectionHeader(
                    context,
                    title: 'Empty Kitchen Cleaning',
                    heroImageUrl:
                        'https://images.unsplash.com/photo-1600585154340-be6161a56a0c?auto=format&fit=crop&w=800&q=80',
                    isDark: isDark,
                  ),

                  ...emptyServices.map((service) => Obx(() {
                        return KitchenCleaningServiceCard(
                          item: service,
                          quantity: controller.getItemQuantity(service.id),
                          isExpanded: controller.isDetailsExpanded(service.id),
                          onToggleExpand: () =>
                              controller.toggleDetails(service.id),
                          onAdd: (opt) => controller.addItem(service, opt),
                          onDecrement: () =>
                              controller.decrementItem(service.id),
                        );
                      })),

                  const SizedBox(height: 16),

                  // 5. Standalone / Appliance Services List
                  ...applianceServices.map((service) => Obx(() {
                        return KitchenCleaningServiceCard(
                          item: service,
                          quantity: controller.getItemQuantity(service.id),
                          isExpanded: controller.isDetailsExpanded(service.id),
                          onToggleExpand: () =>
                              controller.toggleDetails(service.id),
                          onAdd: (opt) => controller.addItem(service, opt),
                          onDecrement: () =>
                              controller.decrementItem(service.id),
                        );
                      })),

                  // 6. SECTION 3: Mini Services 2-Column Grid
                  KitchenCleaningMiniServiceGrid(
                    items: miniServices,
                    getItemQuantity: controller.getItemQuantity,
                    onAdd: (item) => controller.addItem(item),
                    onDecrement: controller.decrementItem,
                  ),

                  const SizedBox(height: 16),

                  // 7. Ratings & Reviews Breakdown Card
                  KitchenCleaningReviewsBreakdownWidget(
                    ratingData: controller.ratingBreakdown.value,
                  ),

                  // 8. SewaSetu Promise & Why SewaSetu Cards
                  KitchenCleaningPromiseWidget(
                    whyUsFeatures: controller.whyUsFeatures,
                  ),

                  // 9. Frequently Asked Questions Expandable Accordion
                  KitchenCleaningFaqWidget(
                    faqItems: controller.faqItems,
                    expandedIds: controller.expandedFaqIds,
                    onToggle: controller.toggleFaq,
                  ),

                  const SizedBox(height: 32),
                ],
              ),
            ),

            // Floating Cart Bottom Checkout Bar
            Obx(() {
              return KitchenCleaningCartBar(
                itemQuantity: controller.totalCartCount,
                totalPrice: controller.totalCartPrice,
                onViewCart: () {
                  Get.snackbar(
                    'Checkout',
                    'Navigating to checkout with ${controller.totalCartCount} items...',
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: const Color(0xFF0F766E),
                    colorText: Colors.white,
                    duration: const Duration(seconds: 2),
                    margin: const EdgeInsets.all(16),
                    borderRadius: 12,
                  );
                },
              );
            }),
          ],
        );
      }),
    );
  }

  Widget _buildSectionHeader(
    BuildContext context, {
    required String title,
    required String heroImageUrl,
    required bool isDark,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Hero Image Banner with Flat 10% Off Text Overlay
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          height: 150,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  heroImageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: const Color(0xFFFEF3C7),
                  ),
                ),
              ),

              // Gradient Overlay & Promo Tag
              DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Colors.black.withValues(alpha: 0.6),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),

              Positioned(
                right: 16,
                top: 24,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.95),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Text(
                        'FLAT 10% off',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFFB45309),
                        ),
                      ),
                      Text(
                        'CODE: NEWCLEAN10',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF475569),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
