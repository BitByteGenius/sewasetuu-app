import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sewasetu/app/theme/app_colors.dart';
import 'package:sewasetu/modules/home/widgets/home_location_header_widget.dart';
import 'package:sewasetu/shared/enums/view_state.dart';
import 'package:sewasetu/shared/widgets/app_bar/app_bar.dart';

import '../../common_widgets/home_service_category_grid.dart';
import '../../common_widgets/home_service_listing_card.dart';
import '../../common_widgets/home_service_states.dart';
import '../../common_widgets/my_cart_widgets.dart';
import '../../home_cleaning/models/kitchen_cleaning_model.dart';
import '../../home_cleaning/widgets/kitchen_cleaning_cart_bar.dart';
import '../../home_cleaning/widgets/kitchen_cleaning_faq_widget.dart';
import '../../home_cleaning/widgets/kitchen_cleaning_offer_carousel.dart';
import '../../home_cleaning/widgets/kitchen_cleaning_promise_widget.dart';
import '../../home_cleaning/widgets/kitchen_cleaning_reviews_breakdown_widget.dart';
import '../controller/electrician_controller.dart';
import '../models/home_service_model.dart';

/// Production-grade Electrician detail screen matching Kitchen Cleaning architecture.
class ElectricianScreen extends StatelessWidget {
  const ElectricianScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final controller = Get.isRegistered<ElectricianController>()
        ? Get.find<ElectricianController>()
        : Get.put(ElectricianController());

    return Scaffold(
      backgroundColor:
          isDark ? AppColors.backgroundDark : const Color(0xFFF8FAFC),
      appBar: SewaAppBar(
        titleWidget: const HomeLocationHeaderWidget(
          showNotification: false,
          showProfile: false,
        ),
        showBackButton: true,
        actions: [
          // Search Button
          IconButton(
            icon: const Icon(Icons.search_rounded),
            onPressed: () {
              _showSearchDialog(context, controller);
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
                    Get.to(() => const MyCartWidgets());
                  },
                ),
                if (cartCount > 0)
                  Positioned(
                    top: 6,
                    right: 6,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Color(0xFFE11D48),
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
          return const HomeServiceLoadingState();
        }

        if (controller.state.value == ViewState.error) {
          return HomeServiceErrorState(
            onRetry: controller.loadData,
          );
        }

        final filtered = controller.filteredServices;

        return Stack(
          children: [
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.only(bottom: 110),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 1. Service Title & Rating Header
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Electrician Services',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                            letterSpacing: -0.4,
                            color: isDark
                                ? AppColors.textPrimaryDark
                                : const Color(0xFF0F172A),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(
                              Icons.star_rounded,
                              size: 17,
                              color: Color(0xFFF59E0B),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '4.82 ',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 13.5,
                                fontWeight: FontWeight.w700,
                                color: isDark
                                    ? AppColors.textPrimaryDark
                                    : const Color(0xFF1E293B),
                              ),
                            ),
                            Text(
                              '(142.8K+ ratings)',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 12.5,
                                fontWeight: FontWeight.w500,
                                color: isDark
                                    ? AppColors.textMutedDark
                                    : const Color(0xFF64748B),
                                decoration: TextDecoration.underline,
                                decorationStyle: TextDecorationStyle.dotted,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // 2. Interactive Category Grid with Show More / Show Less Support
                  Obx(() {
                    return HomeServiceCategoryGrid(
                      categories: controller.categories,
                      activeCategoryId: controller.activeCategoryId.value,
                      isExpanded: controller.showAllCategories.value,
                      initialVisibleCount: 8,
                      onCategorySelected: controller.selectCategory,
                      onToggleExpand: controller.toggleCategoryExpand,
                    );
                  }),

                  const SizedBox(height: 8),

                  // 3. Promotional Offers Banner Carousel
                  if (controller.promoBanners.isNotEmpty) ...[
                    KitchenCleaningOfferCarousel(
                      promoBanners: controller.promoBanners
                          .map((b) => b.toOfferBanner())
                          .toList(),
                      onCopyCode: controller.copyPromoCode,
                    ),
                    const SizedBox(height: 12),
                  ],

                  // 4. Filtered Service Listing Cards / Empty State
                  if (filtered.isEmpty) ...[
                    HomeServiceEmptyState(
                      onAction: () {
                        controller.selectCategory('all');
                        controller.setSearchQuery('');
                      },
                    ),
                  ] else ...[
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: Text(
                        'Available Electrician Services',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: isDark
                              ? AppColors.textPrimaryDark
                              : const Color(0xFF1E293B),
                        ),
                      ),
                    ),
                    ...filtered.map((service) => Obx(() {
                          return HomeServiceListingCard(
                            item: service,
                            quantity:
                                controller.getItemQuantity(service.id),
                            onAdd: (ServiceOptionItem? opt) =>
                                controller.addItem(service, opt),
                            onDecrement: () =>
                                controller.decrementItem(service.id),
                          );
                        })),
                  ],

                  const SizedBox(height: 16),

                  // 5. Ratings Breakdown Widget
                  KitchenCleaningReviewsBreakdownWidget(
                    ratingData: controller.ratingBreakdown.value,
                  ),

                  // 6. SewaSetu Promise & Feature Highlights
                  KitchenCleaningPromiseWidget(
                    whyUsFeatures: controller.whyUsFeatures,
                  ),

                  // 7. Frequently Asked Questions Accordion
                  KitchenCleaningFaqWidget(
                    faqItems: controller.faqItems,
                    expandedIds: controller.expandedFaqIds,
                    onToggle: controller.toggleFaq,
                  ),

                  const SizedBox(height: 32),
                ],
              ),
            ),

            // Floating Bottom Cart Bar
            Obx(() {
              return KitchenCleaningCartBar(
                itemQuantity: controller.totalCartCount,
                totalPrice: controller.totalCartPrice,
                onViewCart: () {
                  Get.to(() => const MyCartWidgets());
                },
              );
            }),
          ],
        );
      }),
    );
  }

  void _showSearchDialog(
      BuildContext context, ElectricianController controller) {
    final searchController =
        TextEditingController(text: controller.searchQuery.value);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Search Electrician Services',
            style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.bold),
          ),
          content: TextField(
            controller: searchController,
            autofocus: true,
            decoration: const InputDecoration(
              hintText: 'e.g., Geyser, Fan, Wiring...',
              prefixIcon: Icon(Icons.search_rounded),
            ),
            onChanged: (val) => controller.setSearchQuery(val),
          ),
          actions: [
            TextButton(
              onPressed: () {
                controller.setSearchQuery('');
                Navigator.pop(context);
              },
              child: const Text('Reset'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Search'),
            ),
          ],
        );
      },
    );
  }
}

extension _OfferAdapter on HomeServiceOfferBanner {
  KitchenCleaningOfferBanner toOfferBanner() {
    return KitchenCleaningOfferBanner(
      id: id,
      tagText: tagText,
      headline: headline,
      promoCode: promoCode,
      imageUrl: imageUrl,
    );
  }
}
