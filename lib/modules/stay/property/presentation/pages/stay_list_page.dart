import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sewasetu/app/routes/app_routes.dart';
import 'package:sewasetu/app/theme/app_colors.dart';
import 'package:sewasetu/app/theme/app_radius.dart';
import 'package:sewasetu/app/theme/app_spacing.dart';
import 'package:sewasetu/app/theme/app_text_styles.dart';
import 'package:sewasetu/modules/stay/filter/domain/entities/stay_filter_criteria.dart';
import 'package:sewasetu/modules/stay/filter/presentation/widgets/stay_filter_bottom_sheet.dart';
import 'package:sewasetu/modules/stay/property/presentation/controllers/stay_list_controller.dart';
import 'package:sewasetu/modules/stay/property/presentation/widgets/stay_card_widget.dart';
import 'package:sewasetu/modules/stay/property/presentation/widgets/stay_filter_bar_widget.dart';
import 'package:sewasetu/modules/stay/property/presentation/widgets/stay_sorting_sheet.dart';
import 'package:sewasetu/shared/enums/view_state.dart';
import 'package:sewasetu/shared/widgets/app_empty_state.dart';
import 'package:sewasetu/shared/widgets/app_interactive_map_canvas.dart';
import 'package:sewasetu/shared/widgets/app_skeleton.dart';

/// Full Stay Listing Page supporting Category tabs, Filters, Sorting, and List/Grid/Map view modes
class StayListPage extends GetView<StayListController> {
  const StayListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Accommodations',
          style: AppTextStyles.headlineSmall(isDark),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search_rounded),
            onPressed: () => Get.toNamed(AppRoutes.staySearch),
          ),
          // Sort action button
          IconButton(
            icon: const Icon(Icons.sort_rounded),
            tooltip: 'Sort Stays',
            onPressed: () {
              StaySortingSheet.show(
                context,
                currentSort: controller.currentSort.value,
                onSelectSort: controller.applySort,
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          AppSpacing.gapV8,
          // Category selector & Filter trigger
          Obx(() {
            return StayCategoryBarWidget(
              selectedType: controller.selectedCategory.value,
              hasActiveFilters: controller.currentFilter.value.hasActiveFilters,
              onCategorySelected: controller.onCategorySelected,
              onFilterTap: () {
                StayFilterBottomSheet.show(
                  context,
                  currentCriteria: controller.currentFilter.value,
                  onApply: controller.applyFilter,
                );
              },
            );
          }),
          AppSpacing.gapV8,

          // View Mode Segmented Controls (List, Grid, Map)
          Padding(
            padding: AppSpacing.horizontalLg,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(() {
                  return Text(
                    '${controller.stays.length} places available',
                    style: AppTextStyles.labelMedium(isDark).copyWith(
                      color: isDark ? AppColors.textMutedDark : AppColors.textMutedLight,
                      fontWeight: FontWeight.w600,
                    ),
                  );
                }),
                Obx(() {
                  return _buildViewModeSelector(isDark);
                }),
              ],
            ),
          ),
          AppSpacing.gapV8,

          // Main View (List / Grid / Map)
          Expanded(
            child: Obx(() {
              switch (controller.state.value) {
                case ViewState.loading:
                  return ListView.separated(
                    padding: AppSpacing.screenPadding,
                    itemCount: 4,
                    separatorBuilder: (context, index) => AppSpacing.gapV16,
                    itemBuilder: (context, index) => const StayCardSkeleton(),
                  );
                case ViewState.error:
                  return AppEmptyState(
                    icon: Icons.error_outline_rounded,
                    title: 'Oops! Failed to load stays',
                    description: 'Something went wrong while fetching properties. Please try again.',
                    actionText: 'Retry',
                    onAction: controller.loadStays,
                  );
                case ViewState.empty:
                  return AppEmptyState(
                    icon: Icons.hotel_outlined,
                    title: 'No Stays Found',
                    description: 'Try adjusting your filters or search criteria to see more available places.',
                    actionText: 'Reset Filters',
                    onAction: () => controller.applyFilter(const StayFilterCriteria()),
                  );
                case ViewState.loaded:
                case ViewState.initial:
                  if (controller.viewMode.value == StayViewMode.map) {
                    return AppInteractiveMapCanvas(
                      stays: controller.stays,
                      showPrivacyRadius: true,
                      onStayTap: (stay) => Get.toNamed(
                        AppRoutes.stayDetails,
                        arguments: stay.id,
                      ),
                    );
                  }

                  return RefreshIndicator(
                    onRefresh: controller.loadStays,
                    color: isDark ? AppColors.primaryLight : AppColors.primary,
                    child: controller.viewMode.value == StayViewMode.grid
                        ? _buildGridView(context)
                        : _buildListView(context),
                  );
              }
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildViewModeSelector(bool isDark) {
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceVariantDark : AppColors.surfaceVariantLight,
        borderRadius: AppRadius.radiusPill,
        border: Border.all(
          color: isDark ? AppColors.borderDark : AppColors.borderLight,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildModeIcon(isDark, Icons.view_agenda_rounded, StayViewMode.list),
          _buildModeIcon(isDark, Icons.grid_view_rounded, StayViewMode.grid),
          _buildModeIcon(isDark, Icons.map_rounded, StayViewMode.map),
        ],
      ),
    );
  }

  Widget _buildModeIcon(bool isDark, IconData icon, StayViewMode mode) {
    final isSelected = controller.viewMode.value == mode;

    return GestureDetector(
      onTap: () => controller.setViewMode(mode),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected
              ? (isDark ? AppColors.primaryLight : AppColors.primary)
              : Colors.transparent,
          borderRadius: AppRadius.radiusPill,
        ),
        child: Icon(
          icon,
          size: 16,
          color: isSelected
              ? (isDark ? Colors.black : Colors.white)
              : (isDark ? AppColors.textMutedDark : AppColors.textMutedLight),
        ),
      ),
    );
  }

  Widget _buildListView(BuildContext context) {
    return ListView.separated(
      padding: AppSpacing.screenPadding,
      itemCount: controller.stays.length,
      separatorBuilder: (context, index) => AppSpacing.gapV16,
      itemBuilder: (context, index) {
        final stay = controller.stays[index];
        return StayCardWidget(
          stay: stay,
          onTap: () => Get.toNamed(
            AppRoutes.stayDetails,
            arguments: stay.id,
          ),
          onFavoriteToggle: (fav) => controller.toggleFavorite(stay.id, fav),
        );
      },
    );
  }

  Widget _buildGridView(BuildContext context) {
    return GridView.builder(
      padding: AppSpacing.screenPadding,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.72,
      ),
      itemCount: controller.stays.length,
      itemBuilder: (context, index) {
        final stay = controller.stays[index];
        return StayCardWidget(
          stay: stay,
          style: StayCardStyle.compact,
          onTap: () => Get.toNamed(
            AppRoutes.stayDetails,
            arguments: stay.id,
          ),
          onFavoriteToggle: (fav) => controller.toggleFavorite(stay.id, fav),
        );
      },
    );
  }
}
