import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_radius.dart';
import '../../../app/theme/app_spacing.dart';
import '../../../app/theme/app_text_styles.dart';
import '../bindings/rental_binding.dart';
import '../controllers/rental_filter_controller.dart';
import '../controllers/rental_search_controller.dart';
import '../controllers/vehicle_list_controller.dart';
import '../data/repositories/rental_repository.dart';
import '../models/vehicle_model.dart';
import '../widgets/rental_empty_state.dart';
import '../widgets/rental_filter_sheet.dart';
import '../widgets/rental_loading_skeleton.dart';
import '../widgets/rental_sort_sheet.dart';
import '../widgets/vehicle_grid.dart';
import '../widgets/vehicle_type_selector.dart';
import 'rental_search_screen.dart';

/// Screen displaying filtered and sorted vehicle catalog for the selected city and dates.
class VehicleListScreen extends StatelessWidget {
  const VehicleListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    RentalBinding.ensureInitialized();

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final listCtrl = Get.find<VehicleListController>();
    final searchCtrl = Get.find<RentalSearchController>();
    final filterCtrl = Get.find<RentalFilterController>();

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      appBar: AppBar(
        backgroundColor: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: isDark ? Colors.white : Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: Obx(() {
          final s = searchCtrl.searchModel.value;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Available in ${s.cityName}',
                style: AppTextStyles.titleMedium(isDark).copyWith(fontWeight: FontWeight.w800),
              ),
              Text(
                '${searchCtrl.formattedPickup} • ${s.durationDays}d',
                style: TextStyle(
                  fontSize: 11,
                  color: isDark ? AppColors.textMutedDark : AppColors.textSecondaryLight,
                ),
              ),
            ],
          );
        }),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_calendar_outlined, color: AppColors.primary),
            tooltip: 'Modify Search Dates',
            onPressed: () => Get.to(() => const RentalSearchScreen()),
          ),
        ],
      ),
      body: Column(
        children: [
          // 1. Search Context Bar (Tap to edit)
          InkWell(
            onTap: () => Get.to(() => const RentalSearchScreen()),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.sm),
              color: (isDark ? AppColors.surfaceVariantDark : AppColors.primaryContainer)
                  .withAlpha((255 * 0.4).round()),
              child: Row(
                children: [
                  const Icon(Icons.calendar_month, size: 16, color: AppColors.primary),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Obx(() {
                      return Text(
                        '${searchCtrl.formattedPickup}  ➔  ${searchCtrl.formattedReturn}',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                        ),
                      );
                    }),
                  ),
                  const Text(
                    'Change',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: AppSpacing.sm),

          // 2. Category selection pill bar
          Obx(() {
            return VehicleTypeSelector(
              selectedType: filterCtrl.criteria.value.vehicleType,
              onTypeSelected: (type) => listCtrl.quickFilterType(type),
            );
          }),

          const SizedBox(height: AppSpacing.sm),

          // 3. Filter & Sort Buttons Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            child: Row(
              children: [
                // Filter Button with Badge Count
                Obx(() {
                  final count = filterCtrl.activeFilterCount;
                  return OutlinedButton.icon(
                    onPressed: () => RentalFilterSheet.show(context),
                    icon: Icon(
                      Icons.tune_rounded,
                      size: 16,
                      color: count > 0 ? AppColors.primary : null,
                    ),
                    label: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text('Filters', style: TextStyle(fontSize: 12)),
                        if (count > 0) ...[
                          const SizedBox(width: 4),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                            decoration: const BoxDecoration(
                              color: AppColors.primary,
                              shape: BoxShape.circle,
                            ),
                            child: Text(
                              '$count',
                              style: const TextStyle(color: Colors.white, fontSize: 10),
                            ),
                          ),
                        ],
                      ],
                    ),
                    style: OutlinedButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                        borderRadius: AppRadius.radiusFull,
                      ),
                      side: BorderSide(
                        color: count > 0
                            ? AppColors.primary
                            : (isDark ? AppColors.borderDark : AppColors.borderLight),
                      ),
                    ),
                  );
                }),

                const SizedBox(width: AppSpacing.sm),

                // Sort Button
                Obx(() {
                  final sortLabel = filterCtrl.currentSort.value.label;
                  return OutlinedButton.icon(
                    onPressed: () => RentalSortSheet.show(context),
                    icon: const Icon(Icons.sort_rounded, size: 16),
                    label: Text(
                      sortLabel,
                      style: const TextStyle(fontSize: 12),
                    ),
                    style: OutlinedButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                        borderRadius: AppRadius.radiusFull,
                      ),
                      side: BorderSide(
                        color: isDark ? AppColors.borderDark : AppColors.borderLight,
                      ),
                    ),
                  );
                }),

                const Spacer(),

                // Total matching vehicle count
                Obx(() {
                  return Text(
                    '${listCtrl.vehicles.length} rides',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: isDark ? AppColors.textMutedDark : AppColors.textSecondaryLight,
                    ),
                  );
                }),
              ],
            ),
          ),

          const SizedBox(height: AppSpacing.sm),

          // 4. Vehicle Catalog Feed
          Expanded(
            child: Obx(() {
              if (listCtrl.isLoading.value) {
                return ListView.builder(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  itemCount: 3,
                  itemBuilder: (_, __) => const RentalVehicleCardSkeleton(),
                );
              }

              if (listCtrl.vehicles.isEmpty) {
                return RentalEmptyState.noVehicles(
                  onResetFilters: () {
                    filterCtrl.resetFilters();
                    searchCtrl.setVehicleType(RentalVehicleType.all);
                    listCtrl.loadVehicles();
                  },
                );
              }

              return RefreshIndicator(
                onRefresh: () => listCtrl.loadVehicles(),
                color: AppColors.primary,
                child: VehicleGrid(
                  vehicles: listCtrl.vehicles,
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
