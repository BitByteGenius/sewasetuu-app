import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sewasetu/app/theme/app_colors.dart';
import 'package:sewasetu/app/theme/app_spacing.dart';
import 'package:sewasetu/shared/enums/view_state.dart';
import 'package:sewasetu/shared/widgets/app_skeleton.dart';

import '../controllers/services_controller.dart';
import '../widgets/services_circular_subcategories_widget.dart';
import '../widgets/services_customer_reviews_widget.dart';
import '../widgets/services_faq_widget.dart';
import '../widgets/services_header_categories_widget.dart';
import '../widgets/services_offers_carousel_widget.dart';
import '../widgets/services_popular_grid_widget.dart';
import '../widgets/services_relocation_widget.dart';
import '../widgets/services_spotlight_card_widget.dart';
import '../widgets/services_vip_savings_widget.dart';

/// Main Home Services Screen matching reference design with high-fidelity components,
/// responsive layouts for Android and iOS, and full backend readiness.
class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final controller = Get.isRegistered<ServicesController>()
        ? Get.find<ServicesController>()
        : Get.put(ServicesController());

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      body: Obx(() {
        if (controller.state.value == ViewState.loading &&
            controller.headerCategories.isEmpty) {
          return _buildLoadingSkeleton(isDark);
        }

        return RefreshIndicator(
          onRefresh: controller.refreshServices,
          color: isDark ? AppColors.primaryLight : AppColors.primary,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            padding: const EdgeInsets.only(top: 8, bottom: 120),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
                // 1. Primary 4x2 Header Categories Grid
                ServicesHeaderCategoriesWidget(
                  categories: controller.headerCategories,
                  onCategoryTap: controller.onCategorySelected,
                ),

                AppSpacing.gapV24,

                // 2. Promotional Offers Carousel ("Offers for you")
                ServicesOffersCarouselWidget(
                  offers: controller.promotionalOffers,
                  onCopyCoupon: controller.copyCoupon,
                ),

                AppSpacing.gapV24,

                // 3. "In the Spotlight" Featured Service Card
                if (controller.spotlightService.value != null) ...[
                  ServicesSpotlightCardWidget(
                    spotlight: controller.spotlightService.value!,
                    onBook: () => controller.onBookService(
                      controller.spotlightService.value!.title,
                    ),
                  ),
                  AppSpacing.gapV20,
                ],

                // 4. Promotional Savings Card (VIP Club)
                ServicesVipSavingsWidget(
                  onTap: () => controller.onBookService('VIP Membership'),
                ),

                AppSpacing.gapV24,

                // 5. Home Cleaning Services Sub-Categories (Horizontal circular items)
                ServicesCircularSubcategoriesWidget(
                  title: 'Home Cleaning Services',
                  items: controller.cleaningSubcategories,
                  ringColor: const Color(0xFFF43F5E), // Rose/Pink accent ring from screenshot
                  onSeeAll: () => controller.onCategorySelected('Home Cleaning'),
                  onItemTap: (item) => controller.onBookService(item.name),
                ),

                AppSpacing.gapV24,

                // 6. Popular Services (2x2 full-bleed image grid with ratings)
                ServicesPopularGridWidget(
                  items: controller.popularServices,
                  onItemTap: (item) => controller.onBookService(item.title),
                ),

                AppSpacing.gapV24,

                // 7. Home Repair Services Sub-Categories (Horizontal circular items)
                ServicesCircularSubcategoriesWidget(
                  title: 'Home Repair Services',
                  items: controller.repairSubcategories,
                  ringColor: const Color(0xFFE11D48), // Deep rose ring from screenshot
                  onSeeAll: () => controller.onCategorySelected('Home Repair'),
                  onItemTap: (item) => controller.onBookService(item.name),
                ),

                AppSpacing.gapV24,

                // 8. Relocation Simplified Section (Side-by-side cards)
                ServicesRelocationWidget(
                  items: controller.relocationOptions,
                  onItemTap: (item) => controller.onBookService(item.title),
                ),

                AppSpacing.gapV24,

                // 9. Customer Reviews Section (Horizontal scrollable testimonial cards)
                ServicesCustomerReviewsWidget(
                  reviews: controller.customerReviews,
                ),

                AppSpacing.gapV24,

                // 10. Frequently Asked Questions (Expandable Accordion)
                ServicesFaqWidget(
                  faqItems: controller.faqItems,
                  expandedIds: controller.expandedFaqIds,
                  onToggle: controller.toggleFaq,
                ),

                AppSpacing.gapV32,
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildLoadingSkeleton(bool isDark) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        children: const [
          AppSkeleton(height: 200, width: double.infinity),
          SizedBox(height: 20),
          AppSkeleton(height: 130, width: double.infinity),
          SizedBox(height: 20),
          AppSkeleton(height: 240, width: double.infinity),
        ],
      ),
    );
  }
}

typedef ServicesPage = ServicesScreen;