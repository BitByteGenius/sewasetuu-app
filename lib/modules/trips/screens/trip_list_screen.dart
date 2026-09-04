import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_radius.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../shared/enums/view_state.dart';
import '../../../../shared/widgets/app_button.dart';
import '../controllers/trip_filter_controller.dart';
import '../trips_navigator.dart';
import '../widgets/trip_filter_sheet.dart';
import '../widgets/trip_loading_card.dart';
import '../widgets/trip_package_card.dart';
import '../widgets/trip_sorting_sheet.dart';

/// Screen displaying searchable and filterable list of curated trip packages
class TripListScreen extends StatefulWidget {
  final String? destinationId;
  final String? themeId;
  final String? title;

  const TripListScreen({
    super.key,
    this.destinationId,
    this.themeId,
    this.title,
  });

  @override
  State<TripListScreen> createState() => _TripListScreenState();
}

class _TripListScreenState extends State<TripListScreen> {
  late final TripFilterController filterController;

  @override
  void initState() {
    super.initState();
    filterController = Get.isRegistered<TripFilterController>()
        ? Get.find<TripFilterController>()
        : Get.put(TripFilterController());

    if (widget.destinationId != null || widget.themeId != null) {
      final initial = filterController.currentFilter.value.copyWith(
        destinationId: widget.destinationId,
        themeId: widget.themeId,
      );
      filterController.applyFilter(initial);
    }
  }

  void _openFilterSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return TripFilterSheet(
          initialFilter: filterController.currentFilter.value,
          destinations: filterController.availableDestinations,
          themes: filterController.availableThemes,
          onApply: (newFilter) {
            filterController.applyFilter(newFilter);
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
        return TripSortingSheet(
          currentOption: filterController.currentFilter.value.sortOption,
          onSelect: (option) {
            filterController.setSortOption(option);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Get.back(),
        ),
        title: Text(
          widget.title ?? 'All Trip Packages',
          style: AppTextStyles.titleMedium(isDark).copyWith(
            fontWeight: FontWeight.w800,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search_rounded),
            onPressed: () => TripsNavigator.toTripSearch(),
          ),
        ],
      ),
      body: Obx(() {
        final filter = filterController.currentFilter.value;
        final packages = filterController.filteredPackages;
        final state = filterController.state.value;

        return Column(
          children: [
            // Filter and Sort Control Bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color:
                    isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
                border: Border(
                  bottom: BorderSide(
                    color: isDark
                        ? AppColors.borderDark
                        : AppColors.borderLight,
                  ),
                ),
              ),
              child: Row(
                children: [
                  // Filter Button
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: _openFilterSheet,
                      icon: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Icon(
                            Icons.tune_rounded,
                            size: 16,
                            color: isDark ? Colors.white70 : Colors.black87,
                          ),
                          if (filter.activeFilterCount > 0)
                            Positioned(
                              top: -4,
                              right: -4,
                              child: Container(
                                padding: const EdgeInsets.all(3),
                                decoration: const BoxDecoration(
                                  color: AppColors.primary,
                                  shape: BoxShape.circle,
                                ),
                                child: Text(
                                  '${filter.activeFilterCount}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 8,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                      label: Text(
                        filter.activeFilterCount > 0
                            ? 'Filters (${filter.activeFilterCount})'
                            : 'Filters',
                        style: TextStyle(
                          color: isDark ? Colors.white : Colors.black87,
                          fontSize: 12.5,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        side: BorderSide(
                          color: isDark
                              ? AppColors.borderDark
                              : AppColors.borderLight,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: AppRadius.radiusMd,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),

                  // Sort Button
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: _openSortSheet,
                      icon: Icon(
                        Icons.swap_vert_rounded,
                        size: 18,
                        color: isDark ? Colors.white70 : Colors.black87,
                      ),
                      label: Text(
                        filter.sortOption.label,
                        style: TextStyle(
                          color: isDark ? Colors.white : Colors.black87,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        side: BorderSide(
                          color: isDark
                              ? AppColors.borderDark
                              : AppColors.borderLight,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: AppRadius.radiusMd,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Active Filters Strip
            if (filter.hasActiveFilters)
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                color: isDark
                    ? AppColors.surfaceVariantDark.withAlpha(40)
                    : AppColors.surfaceVariantLight.withAlpha(50),
                child: Row(
                  children: [
                    Text(
                      '${packages.length} Trips Found',
                      style: AppTextStyles.labelSmall(isDark).copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () => filterController.resetFilter(),
                      child: Text(
                        'Clear Filters',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: isDark
                              ? AppColors.primaryLight
                              : AppColors.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

            // Packages Content List
            Expanded(
              child: Builder(
                builder: (context) {
                  if (state == ViewState.loading) {
                    return ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: 4,
                      itemBuilder: (context, index) => const TripLoadingCard(),
                    );
                  }

                  if (state == ViewState.empty || packages.isEmpty) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.travel_explore_rounded,
                              size: 56,
                              color: Colors.grey,
                            ),
                            AppSpacing.gapV12,
                            Text(
                              'No Trips Match Your Criteria',
                              style: AppTextStyles.titleMedium(isDark).copyWith(
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              'Try relaxing your budget, duration, or destination filters.',
                              textAlign: TextAlign.center,
                              style: AppTextStyles.bodySmall(isDark),
                            ),
                            AppSpacing.gapV16,
                            AppButton.primary(
                              text: 'Reset Filters',
                              onPressed: () => filterController.resetFilter(),
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: packages.length,
                    itemBuilder: (context, index) {
                      final pkg = packages[index];
                      return TripPackageCard(
                        package: pkg,
                        onTap: () => TripsNavigator.toTripDetails(pkg),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        );
      }),
    );
  }
}
