import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sewasetu/app/routes/app_routes.dart';
import 'package:sewasetu/app/theme/app_colors.dart';
import 'package:sewasetu/app/theme/app_radius.dart';
import 'package:sewasetu/app/theme/app_spacing.dart';
import 'package:sewasetu/app/theme/app_text_styles.dart';
import 'package:sewasetu/shared/enums/view_state.dart';
import 'package:sewasetu/shared/widgets/app_empty_state.dart';
import 'package:sewasetu/shared/widgets/app_loader.dart';
import 'package:sewasetu/modules/stay/property/presentation/widgets/stay_card_widget.dart';
import 'package:sewasetu/modules/stay/search/presentation/controllers/stay_search_controller.dart';

/// Instant search page with recent search history, popular tags, and auto-complete results.
class StaySearchPage extends GetView<StaySearchController> {
  const StaySearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Container(
          height: 46,
          margin: const EdgeInsets.only(right: 16),
          decoration: BoxDecoration(
            color: isDark ? AppColors.surfaceVariantDark : AppColors.surfaceVariantLight,
            borderRadius: AppRadius.radiusPill,
          ),
          child: TextField(
            controller: controller.textController,
            autofocus: true,
            onSubmitted: controller.search,
            textInputAction: TextInputAction.search,
            style: AppTextStyles.bodyMedium(isDark),
            decoration: InputDecoration(
              hintText: 'Search city, room, PG, homestay...',
              prefixIcon: Icon(
                Icons.search_rounded,
                size: 20,
                color: isDark ? AppColors.textMutedDark : AppColors.textMutedLight,
              ),
              suffixIcon: IconButton(
                icon: const Icon(Icons.clear_rounded, size: 18),
                onPressed: controller.clearSearch,
              ),
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(vertical: 12),
            ),
          ),
        ),
      ),
      body: Obx(() {
        switch (controller.state.value) {
          case ViewState.loading:
            return const Center(child: AppLoader(message: 'Searching matching stays...'));
          case ViewState.error:
            return const AppEmptyState(
              icon: Icons.search_off_rounded,
              title: 'Search Error',
              description: 'Something went wrong with the search. Please try again.',
            );
          case ViewState.empty:
            return AppEmptyState(
              icon: Icons.search_off_rounded,
              title: 'No Matching Stays',
              description: 'We couldn’t find any stay matching "${controller.textController.text}".',
            );
          case ViewState.loaded:
            return ListView.separated(
              padding: AppSpacing.screenPadding,
              itemCount: controller.searchResults.length,
              separatorBuilder: (context, index) => AppSpacing.gapV12,
              itemBuilder: (context, index) {
                final stay = controller.searchResults[index];
                return StayCardWidget(
                  stay: stay,
                  style: StayCardStyle.horizontal,
                  onTap: () => Get.toNamed(
                    AppRoutes.stayDetails,
                    arguments: stay.id,
                  ),
                );
              },
            );
          case ViewState.initial:
            return _buildSearchSuggestions(isDark);
        }
      }),
    );
  }

  Widget _buildSearchSuggestions(bool isDark) {
    return SingleChildScrollView(
      padding: AppSpacing.screenPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Popular Destinations
          Text(
            'Popular Destinations',
            style: AppTextStyles.titleMedium(isDark).copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          AppSpacing.gapV12,
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: controller.popularDestinations.map((dest) {
              return ActionChip(
                label: Text(dest),
                avatar: const Icon(Icons.trending_up_rounded, size: 16),
                backgroundColor: isDark ? AppColors.surfaceVariantDark : AppColors.surfaceVariantLight,
                onPressed: () => controller.selectTag(dest),
              );
            }).toList(),
          ),
          AppSpacing.gapV24,
          // Recent Searches
          if (controller.recentSearches.isNotEmpty) ...[
            Text(
              'Recent Searches',
              style: AppTextStyles.titleMedium(isDark).copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            AppSpacing.gapV12,
            ...controller.recentSearches.map((search) {
              return ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Icon(
                  Icons.history_rounded,
                  color: isDark ? AppColors.textMutedDark : AppColors.textMutedLight,
                ),
                title: Text(
                  search,
                  style: AppTextStyles.bodyMedium(isDark),
                ),
                trailing: const Icon(Icons.north_west_rounded, size: 16),
                onTap: () => controller.selectTag(search),
              );
            }),
          ],
        ],
      ),
    );
  }
}
