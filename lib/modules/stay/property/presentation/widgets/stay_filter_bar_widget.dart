import 'package:flutter/material.dart';
import 'package:sewasetu/app/theme/app_colors.dart';
import 'package:sewasetu/app/theme/app_radius.dart';
import 'package:sewasetu/app/theme/app_spacing.dart';
import 'package:sewasetu/app/theme/app_text_styles.dart';
import 'package:sewasetu/shared/enums/stay_type.dart';

/// Horizontal category selector bar for Stay Types (All, Rooms, PG, Mess, Homestay, Hotels)
class StayCategoryBarWidget extends StatelessWidget {
  final StayType? selectedType;
  final ValueChanged<StayType?> onCategorySelected;
  final VoidCallback? onFilterTap;
  final bool hasActiveFilters;

  const StayCategoryBarWidget({
    super.key,
    required this.selectedType,
    required this.onCategorySelected,
    this.onFilterTap,
    this.hasActiveFilters = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: AppSpacing.horizontalLg,
      child: Row(
        children: [
          if (onFilterTap != null) ...[
            _buildFilterButton(isDark),
            const SizedBox(width: 8),
          ],
          _buildCategoryChip(
            isDark: isDark,
            isSelected: selectedType == null,
            emoji: '✨',
            label: 'All Stays',
            onTap: () => onCategorySelected(null),
          ),
          ...StayType.values.map((type) {
            return Padding(
              padding: const EdgeInsets.only(left: 8),
              child: _buildCategoryChip(
                isDark: isDark,
                isSelected: selectedType == type,
                emoji: type.emoji,
                label: type.label,
                onTap: () => onCategorySelected(type),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildFilterButton(bool isDark) {
    return GestureDetector(
      onTap: onFilterTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: hasActiveFilters
              ? (isDark ? AppColors.primaryLight : AppColors.primary)
              : (isDark ? AppColors.surfaceDark : AppColors.surfaceLight),
          borderRadius: AppRadius.radiusPill,
          border: Border.all(
            color: hasActiveFilters
                ? Colors.transparent
                : (isDark ? AppColors.borderDark : AppColors.borderLight),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.tune_rounded,
              size: 16,
              color: hasActiveFilters
                  ? (isDark ? Colors.black : Colors.white)
                  : (isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight),
            ),
            const SizedBox(width: 6),
            Text(
              'Filters',
              style: AppTextStyles.labelMedium(isDark).copyWith(
                color: hasActiveFilters
                    ? (isDark ? Colors.black : Colors.white)
                    : (isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight),
                fontWeight: FontWeight.w700,
              ),
            ),
            if (hasActiveFilters) ...[
              const SizedBox(width: 6),
              Container(
                width: 6,
                height: 6,
                decoration: const BoxDecoration(
                  color: AppColors.secondary,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryChip({
    required bool isDark,
    required bool isSelected,
    required String emoji,
    required String label,
    required VoidCallback onTap,
  }) {
    final bgColor = isSelected
        ? (isDark ? AppColors.primaryLight : AppColors.primary)
        : (isDark ? AppColors.surfaceDark : AppColors.surfaceLight);
    final fgColor = isSelected
        ? (isDark ? Colors.black : Colors.white)
        : (isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight);
    final borderColor = isSelected
        ? Colors.transparent
        : (isDark ? AppColors.borderDark : AppColors.borderLight);

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: AppRadius.radiusPill,
          border: Border.all(color: borderColor),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(emoji, style: const TextStyle(fontSize: 14)),
            const SizedBox(width: 6),
            Text(
              label,
              style: AppTextStyles.labelMedium(isDark).copyWith(
                color: fgColor,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
