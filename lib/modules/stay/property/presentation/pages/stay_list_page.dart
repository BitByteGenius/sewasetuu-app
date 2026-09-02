import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sewasetu/app/routes/app_routes.dart';
import 'package:sewasetu/app/theme/app_colors.dart';
import 'package:sewasetu/app/theme/app_spacing.dart';
import 'package:sewasetu/app/theme/app_text_styles.dart';
import 'package:sewasetu/shared/enums/view_state.dart';
import 'package:sewasetu/shared/widgets/app_empty_state.dart';
import 'package:sewasetu/shared/widgets/app_loader.dart';
import 'package:sewasetu/modules/stay/filter/domain/entities/stay_filter_criteria.dart';
import 'package:sewasetu/modules/stay/filter/presentation/widgets/stay_filter_bottom_sheet.dart';
import 'package:sewasetu/modules/stay/property/presentation/controllers/stay_list_controller.dart';
import 'package:sewasetu/modules/stay/property/presentation/widgets/stay_card_widget.dart';
import 'package:sewasetu/modules/stay/property/presentation/widgets/stay_filter_bar_widget.dart';

/// Full Stay Listing Page supporting Category switching, Filters, Grid/List view toggle.
class StayListPage extends GetView<StayListController> {
  const StayListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Explore Stays & Living',
          style: AppTextStyles.headlineSmall(isDark),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search_rounded),
            onPressed: () => Get.toNamed(AppRoutes.staySearch),
          ),
          Obx(() {
            return IconButton(
              icon: Icon(
                controller.isGridView.value ? Icons.view_agenda_outlined : Icons.grid_view_rounded,
              ),
              onPressed: controller.toggleViewLayout,
            );
          }),
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
          AppSpacing.gapV12,
          // Stays List
          Expanded(
            child: Obx(() {
              switch (controller.state.value) {
                case ViewState.loading:
                  return const Center(child: AppLoader(message: 'Finding best stays for you...'));
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
                  return RefreshIndicator(
                    onRefresh: controller.loadStays,
                    color: isDark ? AppColors.primaryLight : AppColors.primary,
                    child: controller.isGridView.value
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
