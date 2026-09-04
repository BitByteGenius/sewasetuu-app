import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_radius.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_text_styles.dart';

/// Modal bottom sheet for choosing sort order of products
class ShopSortingSheet extends StatelessWidget {
  final String currentSort;
  final ValueChanged<String> onSelectSort;

  const ShopSortingSheet({
    super.key,
    required this.currentSort,
    required this.onSelectSort,
  });

  static const options = [
    {'key': 'popular', 'title': 'Popularity', 'icon': Icons.trending_up_rounded},
    {'key': 'price_low_high', 'title': 'Price: Low to High', 'icon': Icons.arrow_downward_rounded},
    {'key': 'price_high_low', 'title': 'Price: High to Low', 'icon': Icons.arrow_upward_rounded},
    {'key': 'rating_high', 'title': 'Highest Customer Rating', 'icon': Icons.star_outline_rounded},
  ];

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
            Text(
              'Sort Products By',
              style: AppTextStyles.titleLarge(isDark).copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
            AppSpacing.gapV16,
            ...options.map((opt) {
              final isSelected = currentSort == opt['key'];
              return ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Icon(
                  opt['icon'] as IconData,
                  color: isSelected
                      ? (isDark ? AppColors.primaryLight : AppColors.primary)
                      : (isDark ? AppColors.textMutedDark : AppColors.textMutedLight),
                ),
                title: Text(
                  opt['title'] as String,
                  style: TextStyle(
                    fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
                    color: isSelected
                        ? (isDark ? AppColors.primaryLight : AppColors.primary)
                        : (isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight),
                  ),
                ),
                trailing: isSelected
                    ? Icon(
                        Icons.check_circle_rounded,
                        color: isDark ? AppColors.primaryLight : AppColors.primary,
                      )
                    : null,
                onTap: () {
                  Get.back();
                  onSelectSort(opt['key'] as String);
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}
