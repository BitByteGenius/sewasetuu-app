import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_radius.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../shared/enums/view_state.dart';
import '../controllers/shop_search_controller.dart';
import '../shop_navigator.dart';
import '../widgets/loading_product_card.dart';
import '../widgets/product_grid.dart';
import '../widgets/shop_empty_state.dart';
import '../widgets/shop_header_widget.dart';
import '../widgets/shop_search_bar.dart';

/// Interactive search screen searching products, state origins, and categories
class SearchProductsScreen extends StatefulWidget {
  final String? initialQuery;

  const SearchProductsScreen({super.key, this.initialQuery});

  @override
  State<SearchProductsScreen> createState() => _SearchProductsScreenState();
}

class _SearchProductsScreenState extends State<SearchProductsScreen> {
  late final ShopSearchController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(ShopSearchController());
    if (widget.initialQuery != null && widget.initialQuery!.isNotEmpty) {
      controller.textController.text = widget.initialQuery!;
      controller.performSearch(widget.initialQuery!);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: const ShopHeaderWidget(
        title: 'Search Bazaar',
        subtitle: 'Products, States & Categories',
        showBackButton: true,
      ),
      body: Column(
        children: [
          // Search Bar Input
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: ShopSearchBar(
              controller: controller.textController,
              readOnly: false,
              onChanged: controller.onQueryChanged,
              onSubmitted: controller.performSearch,
              onClear: controller.clearSearch,
            ),
          ),
          // Body content
          Expanded(
            child: Obx(() {
              // 1. Initial State: Recent searches
              if (controller.state.value == ViewState.initial) {
                return _buildRecentSearches(isDark);
              }

              // 2. Loading Shimmer
              if (controller.state.value == ViewState.loading) {
                return GridView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: 4,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.64,
                  ),
                  itemBuilder: (context, index) => const LoadingProductCard(),
                );
              }

              // 3. Empty State
              if (controller.state.value == ViewState.empty) {
                return ShopEmptyState(
                  title: 'No Matching Products',
                  message:
                      'We couldn’t find anything for "${controller.textController.text}". Try searching for Makhana, Muga Silk, or Assam.',
                  buttonText: 'Clear Search',
                  onButtonPressed: controller.clearSearch,
                );
              }

              // 4. Results view
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Matching States banner (if any)
                    if (controller.matchingStates.isNotEmpty) ...[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
                        child: Text(
                          'Matching States',
                          style: AppTextStyles.labelLarge(isDark).copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 48,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          itemCount: controller.matchingStates.length,
                          itemBuilder: (context, index) {
                            final stateItem = controller.matchingStates[index];
                            return Container(
                              margin: const EdgeInsets.only(right: 8),
                              child: ActionChip(
                                avatar: const Icon(Icons.place_rounded, size: 16),
                                label: Text(stateItem.name),
                                onPressed: () =>
                                    ShopNavigator.toStateProducts(stateItem),
                              ),
                            );
                          },
                        ),
                      ),
                      AppSpacing.gapV8,
                    ],

                    // Products Count Header
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: Text(
                        '${controller.searchResults.length} Products Found',
                        style: AppTextStyles.titleMedium(isDark).copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),

                    // Products Grid
                    ProductGrid(
                      products: controller.searchResults,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentSearches(bool isDark) {
    return SingleChildScrollView(
      padding: AppSpacing.screenPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Popular Regional Searches',
            style: AppTextStyles.titleSmall(isDark).copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          AppSpacing.gapV12,
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: controller.recentSearches.map((item) {
              return InkWell(
                borderRadius: AppRadius.radiusPill,
                onTap: () {
                  controller.textController.text = item;
                  controller.performSearch(item);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: isDark
                        ? AppColors.surfaceVariantDark
                        : AppColors.surfaceVariantLight,
                    borderRadius: AppRadius.radiusPill,
                    border: Border.all(
                      color: isDark ? AppColors.borderDark : AppColors.borderLight,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.history_rounded,
                        size: 14,
                        color: isDark
                            ? AppColors.textMutedDark
                            : AppColors.textMutedLight,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        item,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: isDark
                              ? AppColors.textPrimaryDark
                              : AppColors.textPrimaryLight,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
