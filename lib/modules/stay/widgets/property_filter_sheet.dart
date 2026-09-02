import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sewasetu/app/theme/app_colors.dart';
import 'package:sewasetu/app/theme/app_radius.dart';
import 'package:sewasetu/app/theme/app_spacing.dart';
import 'package:sewasetu/app/theme/app_text_styles.dart';
import 'package:sewasetu/core/utils/formatters.dart';
import 'package:sewasetu/modules/stay/controllers/filter_controller.dart';
import 'package:sewasetu/modules/stay/models/stay_filter_criteria.dart';
import 'package:sewasetu/shared/enums/stay_type.dart';
import 'package:sewasetu/shared/widgets/app_bottom_sheet.dart';
import 'package:sewasetu/shared/widgets/app_button.dart';

/// Interactive filter bottom sheet allowing price range, stay types, ratings, and amenity filtering.
class StayFilterBottomSheet extends StatelessWidget {
  final StayFilterCriteria? currentCriteria;
  final ValueChanged<StayFilterCriteria> onApply;

  const StayFilterBottomSheet({
    super.key,
    this.currentCriteria,
    required this.onApply,
  });

  static Future<void> show(
    BuildContext context, {
    StayFilterCriteria? currentCriteria,
    required ValueChanged<StayFilterCriteria> onApply,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => StayFilterBottomSheet(
        currentCriteria: currentCriteria,
        onApply: onApply,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final controller = Get.put(FilterController());
    controller.initialize(currentCriteria);

    return AppBottomSheet(
      title: 'Filter Stays',
      trailing: TextButton(
        onPressed: controller.reset,
        child: Text(
          'Reset All',
          style: AppTextStyles.labelMedium(isDark).copyWith(
            color: AppColors.error,
          ),
        ),
      ),
      footer: Row(
        children: [
          Expanded(
            child: AppButton.outline(
              text: 'Cancel',
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            flex: 2,
            child: AppButton.primary(
              text: 'Apply Filters',
              onPressed: () {
                final criteria = controller.buildCriteria();
                onApply(criteria);
                Navigator.of(context).pop();
              },
            ),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Stay Type Section
          _buildSectionHeader(isDark, 'Property Category'),
          AppSpacing.gapV12,
          Obx(() {
            return Wrap(
              spacing: 8,
              runSpacing: 8,
              children: StayType.values.map((type) {
                final isSelected = controller.selectedType.value == type;
                return ChoiceChip(
                  label: Text('${type.emoji} ${type.label}'),
                  selected: isSelected,
                  selectedColor: isDark ? AppColors.primaryLight : AppColors.primary,
                  backgroundColor: isDark ? AppColors.surfaceVariantDark : AppColors.surfaceVariantLight,
                  labelStyle: AppTextStyles.labelMedium(isDark).copyWith(
                    color: isSelected
                        ? (isDark ? Colors.black : Colors.white)
                        : (isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight),
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                  ),
                  onSelected: (selected) {
                    controller.selectedType.value = selected ? type : null;
                  },
                );
              }).toList(),
            );
          }),

          AppSpacing.gapV24,
          const Divider(height: 1),
          AppSpacing.gapV24,

          // Price Range Section
          Obx(() {
            final range = controller.priceRange.value;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildSectionHeader(isDark, 'Price Range / Night'),
                    Text(
                      '${AppFormatters.formatCurrency(range.start)} - ${AppFormatters.formatCurrency(range.end)}',
                      style: AppTextStyles.labelMedium(isDark).copyWith(
                        color: isDark ? AppColors.primaryLight : AppColors.primary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                AppSpacing.gapV12,
                RangeSlider(
                  values: range,
                  min: 200,
                  max: 10000,
                  divisions: 50,
                  activeColor: isDark ? AppColors.primaryLight : AppColors.primary,
                  inactiveColor: isDark ? AppColors.surfaceVariantDark : AppColors.borderLight,
                  onChanged: (newRange) {
                    controller.priceRange.value = newRange;
                  },
                ),
              ],
            );
          }),

          AppSpacing.gapV16,
          const Divider(height: 1),
          AppSpacing.gapV24,

          // Rating Filter Section
          _buildSectionHeader(isDark, 'Minimum Rating'),
          AppSpacing.gapV12,
          Obx(() {
            return Row(
              children: [0.0, 3.5, 4.0, 4.5].map((rating) {
                final isSelected = controller.minRating.value == rating;
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: GestureDetector(
                      onTap: () => controller.minRating.value = rating,
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? (isDark ? AppColors.primaryLight : AppColors.primary)
                              : (isDark ? AppColors.surfaceVariantDark : AppColors.surfaceVariantLight),
                          borderRadius: AppRadius.radiusMd,
                          border: Border.all(
                            color: isSelected
                                ? Colors.transparent
                                : (isDark ? AppColors.borderDark : AppColors.borderLight),
                          ),
                        ),
                        child: Center(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.star_rounded,
                                size: 16,
                                color: isSelected
                                    ? (isDark ? Colors.black : Colors.white)
                                    : AppColors.starGold,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                rating == 0.0 ? 'Any' : '$rating+',
                                style: AppTextStyles.labelMedium(isDark).copyWith(
                                  color: isSelected
                                      ? (isDark ? Colors.black : Colors.white)
                                      : (isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            );
          }),

          AppSpacing.gapV24,
          const Divider(height: 1),
          AppSpacing.gapV24,

          // Amenities Section
          _buildSectionHeader(isDark, 'Popular Amenities'),
          AppSpacing.gapV12,
          Obx(() {
            return Wrap(
              spacing: 8,
              runSpacing: 8,
              children: controller.availableAmenities.map((amenity) {
                final isSelected = controller.selectedAmenities.contains(amenity);
                return FilterChip(
                  label: Text(amenity),
                  selected: isSelected,
                  selectedColor: isDark ? AppColors.primaryContainerDark : AppColors.primaryContainer,
                  checkmarkColor: isDark ? AppColors.primaryLight : AppColors.primary,
                  backgroundColor: isDark ? AppColors.surfaceVariantDark : AppColors.surfaceVariantLight,
                  labelStyle: AppTextStyles.labelMedium(isDark).copyWith(
                    color: isSelected
                        ? (isDark ? AppColors.primaryLight : AppColors.primary)
                        : (isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight),
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                  ),
                  onSelected: (_) => controller.toggleAmenity(amenity),
                );
              }).toList(),
            );
          }),

          AppSpacing.gapV24,
          const Divider(height: 1),
          AppSpacing.gapV16,

          // Verified Only Switch
          Obx(() {
            return SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(
                'Verified Stays Only',
                style: AppTextStyles.titleMedium(isDark),
              ),
              subtitle: Text(
                'Show only properties verified in-person by SewaSetu team',
                style: AppTextStyles.bodySmall(isDark),
              ),
              activeTrackColor: isDark ? AppColors.primaryLight : AppColors.primary,
              value: controller.verifiedOnly.value,
              onChanged: (val) => controller.verifiedOnly.value = val,
            );
          }),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(bool isDark, String title) {
    return Text(
      title,
      style: AppTextStyles.titleMedium(isDark).copyWith(
        fontWeight: FontWeight.w700,
      ),
    );
  }
}

typedef PropertyFilterSheet = StayFilterBottomSheet;
