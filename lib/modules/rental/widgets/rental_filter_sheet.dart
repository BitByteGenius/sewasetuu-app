import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_radius.dart';
import '../../../app/theme/app_spacing.dart';
import '../../../app/theme/app_text_styles.dart';
import '../controllers/rental_filter_controller.dart';
import '../models/vehicle_model.dart';

/// Bottom sheet for comprehensive vehicle filtering.
class RentalFilterSheet extends StatelessWidget {
  const RentalFilterSheet({super.key});

  static void show(BuildContext context) {
    final ctrl = Get.find<RentalFilterController>();
    ctrl.openFilterSheet();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const RentalFilterSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final filterCtrl = Get.find<RentalFilterController>();

    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(AppRadius.xxl)),
      ),
      child: Column(
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.lg,
              vertical: AppSpacing.md,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Filter Vehicles',
                  style: AppTextStyles.titleLarge(isDark).copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    filterCtrl.resetFilters();
                  },
                  child: const Text(
                    'Reset All',
                    style: TextStyle(
                      color: AppColors.error,
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),

          // Scrollable filter options
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Obx(() {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 1. Vehicle Type
                    _buildSectionHeader(isDark, 'VEHICLE TYPE'),
                    Wrap(
                      spacing: AppSpacing.sm,
                      runSpacing: AppSpacing.sm,
                      children: RentalVehicleType.values.map((type) {
                        final isSelected = filterCtrl.tempVehicleType.value == type;
                        return ChoiceChip(
                          label: Text(type.label),
                          selected: isSelected,
                          selectedColor: AppColors.primary,
                          backgroundColor: isDark ? AppColors.surfaceVariantDark : AppColors.surfaceVariantLight,
                          labelStyle: TextStyle(
                            fontSize: 12,
                            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                            color: isSelected
                                ? Colors.white
                                : (isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight),
                          ),
                          shape: const RoundedRectangleBorder(
                            borderRadius: AppRadius.radiusFull,
                          ),
                          onSelected: (_) => filterCtrl.tempVehicleType.value = type,
                        );
                      }).toList(),
                    ),

                    const SizedBox(height: AppSpacing.xl),

                    // 2. Price Range (₹0 - ₹10,000)
                    _buildSectionHeader(
                      isDark,
                      'PRICE PER DAY (₹${filterCtrl.tempMinPrice.value.toInt()} - ₹${filterCtrl.tempMaxPrice.value.toInt()})',
                    ),
                    RangeSlider(
                      values: RangeValues(
                        filterCtrl.tempMinPrice.value,
                        filterCtrl.tempMaxPrice.value,
                      ),
                      min: 0,
                      max: 10000,
                      divisions: 20,
                      activeColor: AppColors.primary,
                      inactiveColor: isDark ? AppColors.surfaceVariantDark : AppColors.shimmerBase,
                      labels: RangeLabels(
                        '₹${filterCtrl.tempMinPrice.value.toInt()}',
                        '₹${filterCtrl.tempMaxPrice.value.toInt()}',
                      ),
                      onChanged: (values) {
                        filterCtrl.tempMinPrice.value = values.start;
                        filterCtrl.tempMaxPrice.value = values.end;
                      },
                    ),

                    const SizedBox(height: AppSpacing.xl),

                    // 3. Transmission
                    _buildSectionHeader(isDark, 'TRANSMISSION'),
                    Row(
                      children: ['All', 'Automatic', 'Manual'].map((trans) {
                        final isSelected = filterCtrl.tempTransmission.value == trans;
                        return Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 6),
                            child: ChoiceChip(
                              label: Center(child: Text(trans)),
                              selected: isSelected,
                              selectedColor: AppColors.primary,
                              backgroundColor: isDark ? AppColors.surfaceVariantDark : AppColors.surfaceVariantLight,
                              labelStyle: TextStyle(
                                fontSize: 12,
                                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                                color: isSelected
                                    ? Colors.white
                                    : (isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight),
                              ),
                              shape: const RoundedRectangleBorder(
                                borderRadius: AppRadius.radiusMd,
                              ),
                              onSelected: (_) => filterCtrl.tempTransmission.value = trans,
                            ),
                          ),
                        );
                      }).toList(),
                    ),

                    const SizedBox(height: AppSpacing.xl),

                    // 4. Fuel Type
                    _buildSectionHeader(isDark, 'FUEL / POWER TYPE'),
                    Wrap(
                      spacing: AppSpacing.sm,
                      runSpacing: AppSpacing.sm,
                      children: ['All', 'Petrol', 'Diesel', 'Electric', 'Hybrid'].map((fuel) {
                        final isSelected = filterCtrl.tempFuelType.value == fuel;
                        return ChoiceChip(
                          label: Text(fuel),
                          selected: isSelected,
                          selectedColor: AppColors.primary,
                          backgroundColor: isDark ? AppColors.surfaceVariantDark : AppColors.surfaceVariantLight,
                          labelStyle: TextStyle(
                            fontSize: 12,
                            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                            color: isSelected
                                ? Colors.white
                                : (isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight),
                          ),
                          shape: const RoundedRectangleBorder(
                            borderRadius: AppRadius.radiusFull,
                          ),
                          onSelected: (_) => filterCtrl.tempFuelType.value = fuel,
                        );
                      }).toList(),
                    ),

                    const SizedBox(height: AppSpacing.xl),

                    // 5. Seating Capacity
                    _buildSectionHeader(isDark, 'MINIMUM SEATS'),
                    Wrap(
                      spacing: AppSpacing.sm,
                      children: [
                        {'label': 'Any', 'val': 0},
                        {'label': '2+ (Bikes/Cars)', 'val': 2},
                        {'label': '5+ (Cars/SUVs)', 'val': 5},
                        {'label': '7+ (MUVs)', 'val': 7},
                      ].map((item) {
                        final val = item['val'] as int;
                        final label = item['label'] as String;
                        final isSelected = filterCtrl.tempMinSeats.value == val;

                        return ChoiceChip(
                          label: Text(label),
                          selected: isSelected,
                          selectedColor: AppColors.primary,
                          backgroundColor: isDark ? AppColors.surfaceVariantDark : AppColors.surfaceVariantLight,
                          labelStyle: TextStyle(
                            fontSize: 12,
                            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                            color: isSelected
                                ? Colors.white
                                : (isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight),
                          ),
                          shape: const RoundedRectangleBorder(
                            borderRadius: AppRadius.radiusFull,
                          ),
                          onSelected: (_) => filterCtrl.tempMinSeats.value = val,
                        );
                      }).toList(),
                    ),
                  ],
                );
              }),
            ),
          ),

          // Bottom Apply Bar
          Container(
            padding: const EdgeInsets.all(AppSpacing.lg),
            decoration: BoxDecoration(
              color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
              border: Border(
                top: BorderSide(
                  color: isDark ? AppColors.borderDark : AppColors.borderLight,
                ),
              ),
            ),
            child: SafeArea(
              child: ElevatedButton(
                onPressed: () {
                  filterCtrl.applyTempFilters();
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  minimumSize: const Size.fromHeight(50),
                  shape: const RoundedRectangleBorder(
                    borderRadius: AppRadius.radiusLg,
                  ),
                ),
                child: const Text(
                  'Apply Filters',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(bool isDark, String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.7,
          color: isDark ? AppColors.textMutedDark : AppColors.textSecondaryLight,
        ),
      ),
    );
  }
}
