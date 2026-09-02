import 'package:flutter/material.dart';
import 'package:sewasetu/app/theme/app_colors.dart';
import 'package:sewasetu/app/theme/app_text_styles.dart';
import 'package:sewasetu/shared/widgets/app_bottom_sheet.dart';

enum StaySortOption {
  recommended('Recommended', 'Curated by top host ratings & reliability'),
  priceLowToHigh('Price: Low to High', 'Affordable rooms & PGs first'),
  priceHighToLow('Price: High to Low', 'Luxury villas & resorts first'),
  ratingHighToLow('Top Rated', 'Highest guest review score first');

  final String label;
  final String description;
  const StaySortOption(this.label, this.description);
}

/// Sorting bottom sheet for property results
class StaySortingSheet extends StatelessWidget {
  final StaySortOption currentSort;
  final ValueChanged<StaySortOption> onSelectSort;

  const StaySortingSheet({
    super.key,
    required this.currentSort,
    required this.onSelectSort,
  });

  static Future<void> show(
    BuildContext context, {
    required StaySortOption currentSort,
    required ValueChanged<StaySortOption> onSelectSort,
  }) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => StaySortingSheet(
        currentSort: currentSort,
        onSelectSort: onSelectSort,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return AppBottomSheet(
      title: 'Sort Accommodations',
      child: Column(
        children: StaySortOption.values.map((option) {
          final isSelected = currentSort == option;

          return ListTile(
            contentPadding: const EdgeInsets.symmetric(vertical: 4),
            title: Text(
              option.label,
              style: AppTextStyles.titleMedium(isDark).copyWith(
                fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
                color: isSelected
                    ? (isDark ? AppColors.primaryLight : AppColors.primary)
                    : null,
              ),
            ),
            subtitle: Text(
              option.description,
              style: AppTextStyles.bodySmall(isDark),
            ),
            trailing: isSelected
                ? Icon(
                    Icons.check_circle_rounded,
                    color: isDark ? AppColors.primaryLight : AppColors.primary,
                  )
                : null,
            onTap: () {
              onSelectSort(option);
              Navigator.of(context).pop();
            },
          );
        }).toList(),
      ),
    );
  }
}
