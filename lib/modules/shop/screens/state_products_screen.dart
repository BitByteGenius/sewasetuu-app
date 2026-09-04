import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_radius.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../shared/enums/view_state.dart';
import '../../../../shared/widgets/app_network_image.dart';
import '../controllers/state_products_controller.dart';
import '../models/shop_state_model.dart';
import '../widgets/loading_product_card.dart';
import '../widgets/product_card.dart';
import '../widgets/shop_category_card.dart';
import '../widgets/shop_empty_state.dart';
import '../widgets/shop_filter_sheet.dart';
import '../widgets/shop_header_widget.dart';
import '../widgets/shop_sorting_sheet.dart';

/// Catalog screen for all products belonging to a specific state
class StateProductsScreen extends StatefulWidget {
  final ShopStateModel stateModel;

  const StateProductsScreen({
    super.key,
    required this.stateModel,
  });

  @override
  State<StateProductsScreen> createState() => _StateProductsScreenState();
}

class _StateProductsScreenState extends State<StateProductsScreen> {
  late final StateProductsController controller;

  @override
  void initState() {
    super.initState();
    final tag = widget.stateModel.id;
    if (Get.isRegistered<StateProductsController>(tag: tag)) {
      controller = Get.find<StateProductsController>(tag: tag);
    } else {
      controller = Get.put(
        StateProductsController(stateModel: widget.stateModel),
        tag: tag,
      );
    }
  }

  void _openFilterSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return ShopFilterSheet(
          initialPriceRange: controller.priceRange.value,
          initialMinRating: controller.minRating.value,
          onApply: (priceRange, minRating) {
            controller.applyFilters(
              newPriceRange: priceRange,
              newMinRating: minRating,
            );
          },
        );
      },
    );
  }

  void _openSortSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return ShopSortingSheet(
          currentSort: controller.currentSort.value,
          onSelectSort: (newSort) {
            controller.applySort(newSort);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: ShopHeaderWidget(
        title: widget.stateModel.name,
        subtitle: 'Authentic Regional Collection',
        showBackButton: true,
      ),
      body: CustomScrollView(
        slivers: [
          // 1. State Banner Header
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: AppRadius.radiusXl,
                color: isDark
                    ? AppColors.surfaceVariantDark
                    : AppColors.surfaceVariantLight,
              ),
              child: ClipRRect(
                borderRadius: AppRadius.radiusXl,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        AppNetworkImage(
                          imageUrl: widget.stateModel.image,
                          height: 140,
                          width: double.infinity,
                          borderRadius: BorderRadius.zero,
                        ),
                        Container(
                          height: 140,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Colors.black.withAlpha(160),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 12,
                          left: 14,
                          right: 14,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Heritage of ${widget.stateModel.name}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              Text(
                                '${widget.stateModel.region} India',
                                style: TextStyle(
                                  color: Colors.white.withAlpha(200),
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.stateModel.description,
                            style: AppTextStyles.bodyMedium(isDark).copyWith(
                              fontSize: 12.5,
                              height: 1.35,
                            ),
                          ),
                          AppSpacing.gapV8,
                          Wrap(
                            spacing: 6,
                            runSpacing: 6,
                            children: widget.stateModel.culturalHighlights
                                .map((h) => Chip(
                                      visualDensity: VisualDensity.compact,
                                      padding: EdgeInsets.zero,
                                      backgroundColor: isDark
                                          ? AppColors.primaryContainerDark
                                          : AppColors.primaryContainer,
                                      label: Text(
                                        h,
                                        style: TextStyle(
                                          fontSize: 10.5,
                                          fontWeight: FontWeight.w700,
                                          color: isDark
                                              ? AppColors.primaryLight
                                              : AppColors.primary,
                                        ),
                                      ),
                                    ))
                                .toList(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // 2. Category Filter Pills
          SliverToBoxAdapter(
            child: Obx(() {
              final cats = controller.categories;
              final selectedId = controller.selectedCategoryId.value;

              return SizedBox(
                height: 42,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: [
                    // "All" option
                    Container(
                      margin: const EdgeInsets.only(right: 8),
                      child: FilterChip(
                        label: const Text('All Products'),
                        selected: selectedId == 'all',
                        selectedColor: isDark
                            ? AppColors.primaryLight
                            : AppColors.primary,
                        labelStyle: TextStyle(
                          fontSize: 12,
                          fontWeight: selectedId == 'all'
                              ? FontWeight.w800
                              : FontWeight.w600,
                          color: selectedId == 'all'
                              ? (isDark ? Colors.black : Colors.white)
                              : (isDark
                                  ? AppColors.textPrimaryDark
                                  : AppColors.textPrimaryLight),
                        ),
                        onSelected: (_) => controller.selectCategory('all'),
                      ),
                    ),
                    ...cats.map((cat) {
                      return ShopCategoryCard(
                        category: cat,
                        isSelected: selectedId == cat.id,
                        onTap: () => controller.selectCategory(cat.id),
                      );
                    }),
                  ],
                ),
              );
            }),
          ),

          // 3. Action Bar (Sort, Filter, Count)
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(() {
                    return Text(
                      '${controller.products.length} Products Found',
                      style: AppTextStyles.bodyMedium(isDark).copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                      ),
                    );
                  }),
                  Row(
                    children: [
                      OutlinedButton.icon(
                        icon: const Icon(Icons.sort_rounded, size: 16),
                        label: const Text('Sort', style: TextStyle(fontSize: 12)),
                        style: OutlinedButton.styleFrom(
                          visualDensity: VisualDensity.compact,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                        ),
                        onPressed: _openSortSheet,
                      ),
                      const SizedBox(width: 8),
                      OutlinedButton.icon(
                        icon: const Icon(Icons.tune_rounded, size: 16),
                        label: const Text('Filter', style: TextStyle(fontSize: 12)),
                        style: OutlinedButton.styleFrom(
                          visualDensity: VisualDensity.compact,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                        ),
                        onPressed: _openFilterSheet,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // 4. Products Grid
          Obx(() {
            if (controller.state.value == ViewState.loading) {
              return SliverPadding(
                padding: const EdgeInsets.all(16),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.64,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => const LoadingProductCard(),
                    childCount: 4,
                  ),
                ),
              );
            }

            if (controller.products.isEmpty) {
              return SliverToBoxAdapter(
                child: ShopEmptyState(
                  title: 'No Products Match',
                  message:
                      'No products found for the selected category or filters in ${widget.stateModel.name}.',
                  buttonText: 'Reset Filters',
                  onButtonPressed: controller.resetFilters,
                ),
              );
            }

            return SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.64,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return ProductCard(product: controller.products[index]);
                  },
                  childCount: controller.products.length,
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
