import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sewasetu/app/theme/app_colors.dart';
import 'package:sewasetu/app/theme/app_radius.dart';
import 'package:sewasetu/app/theme/app_shadows.dart';
import 'package:sewasetu/app/theme/app_spacing.dart';
import 'package:sewasetu/app/theme/app_text_styles.dart';
import 'package:sewasetu/modules/stay/controllers/search_controller.dart'
    as stay_search;
import 'package:sewasetu/modules/stay/models/stay_filter_criteria.dart';
import 'package:sewasetu/modules/stay/widgets/compact_stay_card.dart';
import 'package:sewasetu/modules/stay/widgets/property_filter_sheet.dart';
import 'package:sewasetu/modules/stay/widgets/stay_search_map_widget.dart';
import 'package:sewasetu/shared/enums/view_state.dart';
import 'package:sewasetu/shared/widgets/app_bar/app_bar.dart';
import 'package:sewasetu/shared/widgets/app_button.dart';

/// Premium, Modern, Clean & Simple Stay Search Screen
/// Ensures ZERO RenderFlex overflow, model-driven category configuration,
/// 400m radius map preview, and compact accommodation cards.
class SearchScreen extends GetView<stay_search.SearchController> {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: SewaAppBar(
        titleText: 'Find Your Ideal Stay',
        showBackButton: true,
        actions: [
          TextButton(
            onPressed: controller.clearAll,
            child: Text(
              'Reset Filters',
              style: AppTextStyles.labelMedium(isDark).copyWith(
                color: isDark ? AppColors.primaryLight : AppColors.primary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          // Scrollable Content area with generous 110px bottom padding to prevent bottom overflow
          SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 110),
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. Prominent Location & Search Input Card
                _buildSearchLocationCard(context, isDark),
                AppSpacing.gapV16,

                // 2. Model-Driven Category Chips Selector
                Text(
                  'What stay category do you need?',
                  style: AppTextStyles.titleMedium(isDark).copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                AppSpacing.gapV8,
                _buildModelDrivenCategoryBar(context, isDark),
                AppSpacing.gapV16,

                // 3. Compact Filter Bar (Price, Rating, Verified, More Filters)
                _buildCompactFilterRow(context, isDark),
                AppSpacing.gapV20,

                // 4. Compact Matching Accommodations Section
                Obx(() {
                  final count = controller.searchResults.length;
                  final categoryLabel = controller.selectedCategory.value;

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Matching Stays ($count)',
                        style: AppTextStyles.titleMedium(isDark).copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      if (categoryLabel != 'All')
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: isDark
                                ? AppColors.primaryLight
                                : AppColors.primary,
                            borderRadius: AppRadius.radiusPill,
                          ),
                          child: Text(
                            categoryLabel,
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: isDark ? Colors.black : Colors.white,
                            ),
                          ),
                        ),
                    ],
                  );
                }),
                AppSpacing.gapV12,

                _buildCompactPropertiesList(context, isDark),
                AppSpacing.gapV24,

                // 5. Polished 400-Meter Radius Nearby Stays Map Section
                StaySearchMapWidget(controller: controller),
                AppSpacing.gapV16,
              ],
            ),
          ),

          // 6. Sticky Floating Bottom CTA Bar
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: _buildBottomStickyCta(context, isDark),
          ),
        ],
      ),
    );
  }

  /// Prominent search location card with search input & GPS target pill
  Widget _buildSearchLocationCard(BuildContext context, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : Colors.white,
        borderRadius: AppRadius.radiusLg,
        boxShadow: AppShadows.sm,
        border: Border.all(
          color: isDark ? AppColors.borderDark : AppColors.borderLight,
        ),
      ),
      child: Column(
        children: [
          TextField(
            controller: controller.textController,
            onChanged: (_) => controller.loadAndFilterStays(),
            onSubmitted: (_) => controller.loadAndFilterStays(),
            style: AppTextStyles.bodyMedium(isDark),
            decoration: InputDecoration(
              hintText: 'Search locality, city, landmark or property...',
              hintStyle: AppTextStyles.bodyMedium(isDark).copyWith(
                color: isDark
                    ? AppColors.textMutedDark
                    : AppColors.textMutedLight,
              ),
              prefixIcon: Icon(
                Icons.search_rounded,
                color: isDark ? AppColors.primaryLight : AppColors.primary,
              ),
              suffixIcon: controller.textController.text.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear_rounded, size: 18),
                      onPressed: () {
                        controller.textController.clear();
                        controller.loadAndFilterStays();
                      },
                    )
                  : null,
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(vertical: 12),
            ),
          ),
          const Divider(height: 1),
          const SizedBox(height: 8),
          Obx(() {
            final isLocating = controller.isLocating.value;
            final locationText = controller.selectedLocationName.value;

            return Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: controller.useCurrentGpsLocation,
                    borderRadius: AppRadius.radiusPill,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 4, vertical: 4),
                      child: Row(
                        children: [
                          if (isLocating)
                            const SizedBox(
                              width: 14,
                              height: 14,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          else
                            Icon(
                              Icons.gps_fixed_rounded,
                              size: 16,
                              color: isDark
                                  ? AppColors.primaryLight
                                  : AppColors.primary,
                            ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Near $locationText',
                              style: AppTextStyles.bodySmall(isDark).copyWith(
                                fontWeight: FontWeight.w700,
                                color: isDark
                                    ? AppColors.textPrimaryDark
                                    : AppColors.textPrimaryLight,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                TextButton.icon(
                  onPressed: controller.useCurrentGpsLocation,
                  icon: const Icon(Icons.my_location_rounded, size: 14),
                  label: const Text('Use GPS', style: TextStyle(fontSize: 12)),
                  style: TextButton.styleFrom(
                    foregroundColor: isDark
                        ? AppColors.primaryLight
                        : AppColors.primary,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    visualDensity: VisualDensity.compact,
                  ),
                ),
              ],
            );
          }),
        ],
      ),
    );
  }

  /// Model-driven Category Chips Bar driven by controller.categories (StayCategoryModel)
  Widget _buildModelDrivenCategoryBar(BuildContext context, bool isDark) {
    final categories = controller.categories;

    return SizedBox(
      height: 48,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final cat = categories[index];

          return Obx(() {
            final isSelected = controller.selectedCategory.value == cat.code;

            return ChoiceChip(
              avatar: Text(cat.emoji, style: const TextStyle(fontSize: 14)),
              label: Text(cat.label),
              selected: isSelected,
              selectedColor:
                  isDark ? AppColors.primaryLight : AppColors.primary,
              backgroundColor: isDark
                  ? AppColors.surfaceVariantDark
                  : AppColors.surfaceVariantLight,
              elevation: isSelected ? 2 : 0,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              labelStyle: AppTextStyles.labelMedium(isDark).copyWith(
                color: isSelected
                    ? (isDark ? Colors.black : Colors.white)
                    : (isDark
                        ? AppColors.textPrimaryDark
                        : AppColors.textPrimaryLight),
                fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: AppRadius.radiusPill,
                side: BorderSide(
                  color: isSelected
                      ? Colors.transparent
                      : (isDark
                          ? AppColors.borderDark
                          : AppColors.borderLight),
                ),
              ),
              onSelected: (_) => controller.selectCategory(cat.code),
            );
          });
        },
      ),
    );
  }

  /// Compact Filter Row (Price, Rating, Verified, More Filters modal trigger)
  Widget _buildCompactFilterRow(BuildContext context, bool isDark) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: [
          // 1. Price Range Selector
          Obx(() {
            final pIndex = controller.priceRangeIndex.value;
            return PopupMenuButton<int>(
              initialValue: pIndex,
              onSelected: controller.setPriceRange,
              shape: RoundedRectangleBorder(borderRadius: AppRadius.radiusMd),
              itemBuilder: (context) => [
                const PopupMenuItem(value: 0, child: Text('All Prices')),
                const PopupMenuItem(
                    value: 1, child: Text('Under ₹5,000 / mo')),
                const PopupMenuItem(
                    value: 2, child: Text('₹5,000 – ₹15,000 / mo')),
                const PopupMenuItem(
                    value: 3, child: Text('₹15,000+ / mo')),
              ],
              child: FilterChip(
                label: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.payments_outlined, size: 14),
                    const SizedBox(width: 4),
                    Text(
                      pIndex == 0
                          ? 'Price Range'
                          : pIndex == 1
                              ? '< ₹5,000'
                              : pIndex == 2
                                  ? '₹5k–₹15k'
                                  : '₹15k+',
                    ),
                    const Icon(Icons.arrow_drop_down_rounded, size: 18),
                  ],
                ),
                selected: pIndex != 0,
                selectedColor: (isDark
                        ? AppColors.primaryLight
                        : AppColors.primary)
                    .withAlpha(40),
                onSelected: (_) {},
              ),
            );
          }),
          const SizedBox(width: 8),

          // 2. Rating 4.0+ Star Filter
          Obx(() {
            final is4Plus = controller.minRating.value == 4.0;
            return FilterChip(
              avatar: const Icon(Icons.star_rounded,
                  color: Colors.amber, size: 15),
              label: const Text('4.0+ Rating'),
              selected: is4Plus,
              selectedColor: (isDark
                      ? AppColors.primaryLight
                      : AppColors.primary)
                  .withAlpha(40),
              onSelected: (val) {
                controller.setMinRating(val ? 4.0 : null);
              },
            );
          }),
          const SizedBox(width: 8),

          // 3. Verified Stays Only
          Obx(() {
            final isVerified = controller.verifiedOnly.value;
            return FilterChip(
              avatar: Icon(
                Icons.verified_rounded,
                color: isVerified
                    ? (isDark ? AppColors.primaryLight : AppColors.primary)
                    : Colors.grey,
                size: 15,
              ),
              label: const Text('Verified Only'),
              selected: isVerified,
              selectedColor: (isDark
                      ? AppColors.primaryLight
                      : AppColors.primary)
                  .withAlpha(40),
              onSelected: (_) => controller.toggleVerifiedOnly(),
            );
          }),
          const SizedBox(width: 8),

          // 4. More Filters Trigger Button
          ActionChip(
            avatar: const Icon(Icons.tune_rounded, size: 15),
            label: const Text('More Filters'),
            onPressed: () {
              double? minP;
              double? maxP;
              if (controller.priceRangeIndex.value == 1) maxP = 5000;
              if (controller.priceRangeIndex.value == 2) {
                minP = 5000;
                maxP = 15000;
              }
              if (controller.priceRangeIndex.value == 3) minP = 15000;

              final current = StayFilterCriteria(
                stayType: controller.selectedStayType.value,
                roomCategory: controller.selectedCategory.value,
                minPrice: minP,
                maxPrice: maxP,
                minRating: controller.minRating.value,
                verifiedOnly: controller.verifiedOnly.value,
              );

              PropertyFilterSheet.show(
                context,
                currentCriteria: current,
                onApply: (newCriteria) {
                  if (newCriteria.stayType != null) {
                    controller.selectedStayType.value = newCriteria.stayType;
                    controller.selectedCategory.value = newCriteria.stayType!.label;
                  }
                  if (newCriteria.minRating != null) {
                    controller.setMinRating(newCriteria.minRating);
                  }
                  if (newCriteria.verifiedOnly != null) {
                    controller.verifiedOnly.value = newCriteria.verifiedOnly!;
                  }
                  controller.loadAndFilterStays();
                },
              );
            },
          ),
        ],
      ),
    );
  }

  /// Compact Accommodation Cards List
  Widget _buildCompactPropertiesList(BuildContext context, bool isDark) {
    return Obx(() {
      final stateVal = controller.state.value;
      final results = controller.searchResults;

      if (stateVal == ViewState.loading) {
        return const SizedBox(
          height: 180,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      }

      if (results.isEmpty) {
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: isDark ? AppColors.surfaceDark : Colors.white,
            borderRadius: AppRadius.radiusLg,
            border: Border.all(
              color: isDark ? AppColors.borderDark : AppColors.borderLight,
            ),
          ),
          child: Column(
            children: [
              Icon(
                Icons.search_off_rounded,
                size: 36,
                color: isDark
                    ? AppColors.textMutedDark
                    : AppColors.textMutedLight,
              ),
              AppSpacing.gapV8,
              Text(
                'No properties matched your search',
                style: AppTextStyles.bodyMedium(isDark).copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              AppSpacing.gapV4,
              Text(
                'Try resetting filters or searching another area.',
                style: AppTextStyles.bodySmall(isDark),
              ),
              AppSpacing.gapV12,
              OutlinedButton(
                onPressed: controller.clearAll,
                child: const Text('Reset All Filters'),
              ),
            ],
          ),
        );
      }

      return SizedBox(
        height: 235,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          itemCount: results.length,
          separatorBuilder: (_, __) => const SizedBox(width: 12),
          itemBuilder: (context, index) {
            final property = results[index];
            return CompactStayCard(
              stay: property,
              width: 230,
              onTap: () => controller.openPropertyDetails(property),
            );
          },
        ),
      );
    });
  }

  /// Modern Floating Bottom CTA with dynamic filtered count
  Widget _buildBottomStickyCta(BuildContext context, bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : Colors.white,
        boxShadow: AppShadows.topNav,
        border: Border(
          top: BorderSide(
            color: isDark ? AppColors.borderDark : AppColors.borderLight,
          ),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Obx(() {
          final count = controller.searchResults.length;
          return AppButton.primary(
            text: 'View $count Accommodations',
            icon: const Icon(Icons.arrow_forward_rounded,
                color: Colors.white, size: 20),
            width: double.infinity,
            onPressed: controller.executeSearch,
          );
        }),
      ),
    );
  }
}

typedef StaySearchPage = SearchScreen;
