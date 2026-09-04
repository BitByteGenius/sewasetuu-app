import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_radius.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_button.dart';

/// Modal bottom sheet for applying filters to products
class ShopFilterSheet extends StatefulWidget {
  final RangeValues initialPriceRange;
  final double initialMinRating;
  final Function(RangeValues priceRange, double minRating) onApply;

  const ShopFilterSheet({
    super.key,
    required this.initialPriceRange,
    required this.initialMinRating,
    required this.onApply,
  });

  @override
  State<ShopFilterSheet> createState() => _ShopFilterSheetState();
}

class _ShopFilterSheetState extends State<ShopFilterSheet> {
  late RangeValues _priceRange;
  late double _minRating;

  @override
  void initState() {
    super.initState();
    _priceRange = widget.initialPriceRange;
    _minRating = widget.initialMinRating;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
        borderRadius: AppRadius.topXl,
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Handle bar
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: isDark ? AppColors.borderDark : AppColors.borderLight,
                  borderRadius: AppRadius.radiusPill,
                ),
              ),
            ),
            AppSpacing.gapV16,
            // Title & Reset
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Filter Products',
                  style: AppTextStyles.titleLarge(isDark).copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _priceRange = const RangeValues(100, 30000);
                      _minRating = 0.0;
                    });
                  },
                  child: const Text('Reset All'),
                ),
              ],
            ),
            AppSpacing.gapV16,
            // Price Range
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Price Range',
                  style: AppTextStyles.titleSmall(isDark).copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  '₹${_priceRange.start.toStringAsFixed(0)} - ₹${_priceRange.end.toStringAsFixed(0)}',
                  style: AppTextStyles.titleSmall(isDark).copyWith(
                    color: isDark ? AppColors.primaryLight : AppColors.primary,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
            RangeSlider(
              values: _priceRange,
              min: 100,
              max: 30000,
              divisions: 60,
              activeColor: isDark ? AppColors.primaryLight : AppColors.primary,
              onChanged: (values) {
                setState(() => _priceRange = values);
              },
            ),
            AppSpacing.gapV16,
            // Rating
            Text(
              'Minimum Rating',
              style: AppTextStyles.titleSmall(isDark).copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            AppSpacing.gapV8,
            Row(
              children: [
                _buildRatingChip(isDark, label: 'All', rating: 0.0),
                const SizedBox(width: 8),
                _buildRatingChip(isDark, label: '4.0+ ★', rating: 4.0),
                const SizedBox(width: 8),
                _buildRatingChip(isDark, label: '4.5+ ★', rating: 4.5),
                const SizedBox(width: 8),
                _buildRatingChip(isDark, label: '4.8+ ★', rating: 4.8),
              ],
            ),
            AppSpacing.gapV24,
            // Apply Button
            AppButton.primary(
              text: 'Apply Filters',
              width: double.infinity,
              onPressed: () {
                Get.back();
                widget.onApply(_priceRange, _minRating);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRatingChip(
    bool isDark, {
    required String label,
    required double rating,
  }) {
    final isSelected = _minRating == rating;

    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      selectedColor:
          isDark ? AppColors.primaryContainerDark : AppColors.primaryContainer,
      labelStyle: TextStyle(
        fontSize: 12,
        fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
        color: isSelected
            ? (isDark ? AppColors.primaryLight : AppColors.primary)
            : (isDark
                ? AppColors.textPrimaryDark
                : AppColors.textPrimaryLight),
      ),
      onSelected: (val) {
        if (val) setState(() => _minRating = rating);
      },
    );
  }
}
