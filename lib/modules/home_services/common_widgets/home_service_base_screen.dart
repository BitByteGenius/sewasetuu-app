import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sewasetu/app/theme/app_colors.dart';
import 'package:sewasetu/modules/home/widgets/home_location_header_widget.dart';
import 'package:sewasetu/shared/enums/view_state.dart';
import 'package:sewasetu/shared/widgets/app_bar/app_bar.dart';
import 'package:sewasetu/shared/widgets/app_skeleton.dart';

import '../home_cleaning/models/kitchen_cleaning_model.dart';
import '../home_cleaning/widgets/kitchen_cleaning_cart_bar.dart';
import '../home_cleaning/widgets/kitchen_cleaning_faq_widget.dart';
import '../home_cleaning/widgets/kitchen_cleaning_header_widget.dart';
import '../home_cleaning/widgets/kitchen_cleaning_mini_service_grid.dart';
import '../home_cleaning/widgets/kitchen_cleaning_offer_carousel.dart';
import '../home_cleaning/widgets/kitchen_cleaning_promise_widget.dart';
import '../home_cleaning/widgets/kitchen_cleaning_reviews_breakdown_widget.dart';
import '../home_cleaning/widgets/kitchen_cleaning_service_card.dart';
import 'my_cart_widgets.dart';

/// Section metadata model for grouping services into distinct sections
/// with hero image banners and promo overlays.
class HomeServiceSectionData {
  final String id;
  final String title;
  final String heroImageUrl;
  final String? promoTag;
  final String? promoCode;
  final GlobalKey key;
  final List<KitchenCleaningServiceItem> services;

  HomeServiceSectionData({
    required this.id,
    required this.title,
    required this.heroImageUrl,
    this.promoTag = 'FLAT 10% off',
    this.promoCode,
    GlobalKey? key,
    required this.services,
  }) : key = key ?? GlobalKey();
}

/// Production-ready Master Base Screen for all Home Services modules
/// (Kitchen Cleaning, Electrician, Plumbing, Carpentry).
/// Guarantees 100% exact Card UI, animation logic, image-based categories,
/// hero section headers, stepper controls, detail sheets, and cart integration.
class HomeServiceBaseScreen extends StatelessWidget {
  final String title;
  final double rating;
  final String ratingCountText;
  final ViewState state;
  final VoidCallback? onRetry;
  final List<KitchenCleaningNavCategory> categories;
  final String activeCategoryId;
  final ValueChanged<String> onSelectCategory;
  final List<KitchenCleaningOfferBanner> promoBanners;
  final ValueChanged<String> onCopyPromoCode;
  final List<HomeServiceSectionData> sections;
  final List<KitchenCleaningServiceItem> miniServices;
  final GlobalKey? miniSectionKey;
  final RatingBreakdownModel ratingBreakdown;
  final List<String> whyUsFeatures;
  final List<KitchenFaqItem> faqItems;
  final Set<String> expandedFaqIds;
  final ValueChanged<String> onToggleFaq;
  final int totalCartCount;
  final double totalCartPrice;
  final int Function(String serviceId) getItemQuantity;
  final bool Function(String serviceId) isDetailsExpanded;
  final ValueChanged<String> onToggleDetails;
  final void Function(KitchenCleaningServiceItem item, ServiceOptionItem? option) onAddItem;
  final ValueChanged<String> onDecrementItem;
  final ScrollController scrollController;
  final bool showBackButton;

  const HomeServiceBaseScreen({
    super.key,
    required this.title,
    required this.rating,
    required this.ratingCountText,
    required this.state,
    this.onRetry,
    required this.categories,
    required this.activeCategoryId,
    required this.onSelectCategory,
    required this.promoBanners,
    required this.onCopyPromoCode,
    required this.sections,
    required this.miniServices,
    this.miniSectionKey,
    required this.ratingBreakdown,
    required this.whyUsFeatures,
    required this.faqItems,
    required this.expandedFaqIds,
    required this.onToggleFaq,
    required this.totalCartCount,
    required this.totalCartPrice,
    required this.getItemQuantity,
    required this.isDetailsExpanded,
    required this.onToggleDetails,
    required this.onAddItem,
    required this.onDecrementItem,
    required this.scrollController,
    this.showBackButton = true,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : const Color(0xFFF8FAFC),
      appBar: SewaAppBar(
        titleWidget: const HomeLocationHeaderWidget(
          showNotification: false,
          showProfile: false,
        ),
        showBackButton: showBackButton,
        actions: [
          // Search Button
          IconButton(
            icon: const Icon(Icons.search_rounded),
            onPressed: () {
              Get.snackbar(
                'Search',
                'Searching $title...',
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: AppColors.primary,
                colorText: Colors.white,
                duration: const Duration(seconds: 2),
                margin: const EdgeInsets.all(16),
                borderRadius: 12,
              );
            },
          ),

          // Shopping Cart Action Icon with Reactive Counter Badge
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart_outlined),
                onPressed: () {
                  Get.to(() => const MyCartWidgets());
                },
              ),
              if (totalCartCount > 0)
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
                      '$totalCartCount',
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
          ),
        ],
      ),
      body: Builder(
        builder: (context) {
          if (state == ViewState.loading) {
            return const Center(
              child: AppSkeleton(height: 300, width: double.infinity),
            );
          }

          if (state == ViewState.error) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline_rounded, size: 48, color: Colors.redAccent),
                  const SizedBox(height: 12),
                  Text(
                    'Failed to load $title',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: onRetry,
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          return Stack(
            children: [
              SingleChildScrollView(
                controller: scrollController,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.only(bottom: 110),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 1. Header Widget with Rating & Image-based Category Cards
                    KitchenCleaningHeaderWidget(
                      categories: categories,
                      activeCategoryId: activeCategoryId,
                      onSelectCategory: onSelectCategory,
                    ),

                    const SizedBox(height: 16),

                    // 2. Promotional Offers Carousel
                    if (promoBanners.isNotEmpty) ...[
                      KitchenCleaningOfferCarousel(
                        promoBanners: promoBanners,
                        onCopyCode: onCopyPromoCode,
                      ),
                      const SizedBox(height: 16),
                    ],

                    // 3. Dynamic Service Sections with Hero Image Banners & Service Cards
                    ...sections.map((section) {
                      return Column(
                        key: section.key,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildSectionHeader(
                            context,
                            title: section.title,
                            heroImageUrl: section.heroImageUrl,
                            promoTag: section.promoTag,
                            promoCode: section.promoCode,
                            isDark: isDark,
                          ),
                          ...section.services.map((service) {
                            final qty = getItemQuantity(service.id);
                            final expanded = isDetailsExpanded(service.id);

                            return KitchenCleaningServiceCard(
                              item: service,
                              quantity: qty,
                              isExpanded: expanded,
                              onToggleExpand: () => onToggleDetails(service.id),
                              onAdd: (opt) => onAddItem(service, opt),
                              onDecrement: () => onDecrementItem(service.id),
                            );
                          }),
                          const SizedBox(height: 16),
                        ],
                      );
                    }),

                    // 4. Mini Services 2-Column Grid (if present)
                    if (miniServices.isNotEmpty) ...[
                      KeyedSubtree(
                        key: miniSectionKey ?? GlobalKey(),
                        child: KitchenCleaningMiniServiceGrid(
                          items: miniServices,
                          getItemQuantity: getItemQuantity,
                          onAdd: (item) => onAddItem(item, null),
                          onDecrement: onDecrementItem,
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],

                    // 5. Ratings & Reviews Breakdown Card
                    KitchenCleaningReviewsBreakdownWidget(
                      ratingData: ratingBreakdown,
                    ),

                    // 6. SewaSetu Promise & Feature Highlights
                    KitchenCleaningPromiseWidget(
                      whyUsFeatures: whyUsFeatures,
                    ),

                    // 7. Frequently Asked Questions Accordion
                    KitchenCleaningFaqWidget(
                      faqItems: faqItems,
                      expandedIds: expandedFaqIds,
                      onToggle: onToggleFaq,
                    ),

                    const SizedBox(height: 32),
                  ],
                ),
              ),

              // Floating Bottom Checkout Cart Bar
              KitchenCleaningCartBar(
                itemQuantity: totalCartCount,
                totalPrice: totalCartPrice,
                onViewCart: () {
                  Get.to(() => const MyCartWidgets());
                },
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSectionHeader(
    BuildContext context, {
    required String title,
    required String heroImageUrl,
    String? promoTag,
    String? promoCode,
    required bool isDark,
  }) {
    return Container(
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

          // Gradient Overlay
          DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Colors.black.withValues(alpha: 0.65),
                  Colors.transparent,
                ],
              ),
            ),
          ),

          // Section Title on Banner
          Positioned(
            left: 16,
            bottom: 20,
            child: Text(
              title,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: Colors.white,
                shadows: [
                  const Shadow(
                    offset: Offset(0, 2),
                    blurRadius: 4,
                    color: Colors.black45,
                  ),
                ],
              ),
            ),
          ),

          // Coupon Tag Badge Overlay
          if (promoTag != null || promoCode != null)
            Positioned(
              right: 16,
              top: 24,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.95),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (promoTag != null)
                      Text(
                        promoTag,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 13,
                          fontWeight: FontWeight.w900,
                          color: const Color(0xFFB45309),
                        ),
                      ),
                    if (promoCode != null)
                      Text(
                        'CODE: $promoCode',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                          color: const Color(0xFF475569),
                        ),
                      ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
