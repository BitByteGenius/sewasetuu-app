import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../shared/enums/view_state.dart';
import '../controllers/shop_controller.dart';
import '../shop_navigator.dart';
import '../widgets/featured_state_card.dart';
import '../widgets/loading_product_card.dart';
import '../widgets/product_card.dart';
import '../widgets/shop_category_card.dart';
import '../widgets/state_card.dart';
import 'shop_navigation_shell.dart';

/// Main Discovery Screen for the State-Wise Cultural Shop Module
class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  late final ShopController controller;

  @override
  void initState() {
    super.initState();
    if (!Get.isRegistered<ShopController>()) {
      controller = Get.put(ShopController());
    } else {
      controller = Get.find<ShopController>();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final discoverView = Obx(() {
      final isLoading = controller.state.value == ViewState.loading &&
          controller.allStates.isEmpty;

      return RefreshIndicator(
        onRefresh: controller.refreshFeed,
        color: isDark ? AppColors.primaryLight : AppColors.primary,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          padding: const EdgeInsets.only(bottom: 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppSpacing.gapV16,

              if (isLoading)
                _buildLoadingShimmer()
              else ...[

                // 2. Featured States Carousel
                _buildSectionTitle(
                  isDark: isDark,
                  title: "Explore India's Culture",
                  subtitle: 'GI-tagged crafts and traditional treasures',
                  actionText: 'View All States',
                  onActionTap: () => ShopNavigator.toStates(),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 185,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: controller.featuredStates.length,
                    itemBuilder: (context, index) {
                      return FeaturedStateCard(
                        stateModel: controller.featuredStates[index],
                      );
                    },
                  ),
                ),
                AppSpacing.gapV24,

                // 3. Shop by Category
                _buildSectionTitle(
                  isDark: isDark,
                  title: 'Shop by Category',
                  subtitle: 'Explore traditional textiles, art, & delicacies',
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 42,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: controller.categories.length,
                    itemBuilder: (context, index) {
                      final cat = controller.categories[index];
                      return ShopCategoryCard(
                        category: cat,
                        isSelected: false,
                        onTap: () => ShopNavigator.toSearch(initialQuery: cat.name),
                      );
                    },
                  ),
                ),
                AppSpacing.gapV24,

                // 4. Featured Cultural Products
                _buildSectionTitle(
                  isDark: isDark,
                  title: 'Featured Treasures',
                  subtitle: 'Direct from master artisans & certified collectives',
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 255,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: controller.featuredProducts.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: ProductCard(
                          product: controller.featuredProducts[index],
                          width: 175,
                          imageHeight: 130,
                        ),
                      );
                    },
                  ),
                ),
                AppSpacing.gapV24,

                // 5. Explore by Region
                _buildSectionTitle(
                  isDark: isDark,
                  title: 'Shop by Indian State',
                  subtitle: 'Select any state to view authentic regional products',
                  actionText: 'All (${controller.allStates.length})',
                  onActionTap: () => ShopNavigator.toStates(),
                ),
                const SizedBox(height: 10),
                // Region filter chips
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: controller.availableRegions.map((region) {
                      final isSelected = controller.selectedRegion.value == region;
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: ChoiceChip(
                          label: Text(region),
                          selected: isSelected,
                          selectedColor: isDark
                              ? AppColors.primaryLight
                              : AppColors.primary,
                          labelStyle: TextStyle(
                            fontSize: 12,
                            fontWeight:
                                isSelected ? FontWeight.w800 : FontWeight.w600,
                            color: isSelected
                                ? (isDark ? Colors.black : Colors.white)
                                : (isDark
                                    ? AppColors.textPrimaryDark
                                    : AppColors.textPrimaryLight),
                          ),
                          onSelected: (val) {
                            if (val) controller.selectRegion(region);
                          },
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 14),
                // States list
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: controller.statesByRegion.take(4).length,
                  separatorBuilder: (context, index) => AppSpacing.gapV12,
                  itemBuilder: (context, index) {
                    final stateItem = controller.statesByRegion[index];
                    return StateCard(stateModel: stateItem);
                  },
                ),
                AppSpacing.gapV24,

                // 6. Popular Products Across India
                _buildSectionTitle(
                  isDark: isDark,
                  title: 'Most Loved Products',
                  subtitle: 'Highest rated cultural handicrafts & foods',
                ),
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: controller.popularProducts.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 0.64,
                        ),
                        itemBuilder: (context, index) {
                          return ProductCard(
                            product: controller.popularProducts[index],
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ],
          ),
        ),
      );
    });

    return ShopNavigationShell(discoverView: discoverView);
  }

  Widget _buildSectionTitle({
    required bool isDark,
    required String title,
    String? subtitle,
    String? actionText,
    VoidCallback? onActionTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.titleLarge(isDark).copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: AppTextStyles.bodySmall(isDark).copyWith(
                      color: isDark
                          ? AppColors.textMutedDark
                          : AppColors.textSecondaryLight,
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (actionText != null && onActionTap != null)
            GestureDetector(
              onTap: onActionTap,
              child: Text(
                actionText,
                style: AppTextStyles.labelMedium(isDark).copyWith(
                  color: isDark ? AppColors.primaryLight : AppColors.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildLoadingShimmer() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Container(
            height: 48,
            decoration: BoxDecoration(
              color: Colors.grey.withAlpha(20),
              borderRadius: BorderRadius.circular(24),
            ),
          ),
          const SizedBox(height: 24),
          Container(
            height: 180,
            decoration: BoxDecoration(
              color: Colors.grey.withAlpha(20),
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: const [
              Expanded(child: LoadingProductCard()),
              SizedBox(width: 12),
              Expanded(child: LoadingProductCard()),
            ],
          ),
        ],
      ),
    );
  }
}
