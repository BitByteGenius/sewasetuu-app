import 'package:flutter/material.dart';
import 'package:sewasetu/app/theme/app_colors.dart';
import 'package:sewasetu/app/theme/app_radius.dart';
import 'package:sewasetu/app/theme/app_spacing.dart';
import 'package:sewasetu/app/theme/app_text_styles.dart';

/// Destination / Location Search Step with autocomplete and popular chips
class SearchLocationStep extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onSelectDestination;

  const SearchLocationStep({
    super.key,
    required this.controller,
    required this.onSelectDestination,
  });

  static const List<Map<String, String>> popularDestinations = [
    {'title': 'Shillong', 'subtitle': 'Meghalaya • Mountain retreat', 'emoji': '🌲'},
    {'title': 'Guwahati', 'subtitle': 'Assam • Gateway to Northeast', 'emoji': '🏙️'},
    {'title': 'Goa', 'subtitle': 'India • Beaches & homestays', 'emoji': '🏖️'},
    {'title': 'Manali', 'subtitle': 'Himachal • Snow & wooden cottages', 'emoji': '🏔️'},
    {'title': 'Jaipur', 'subtitle': 'Rajasthan • Heritage havelis', 'emoji': '🏰'},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Location Text Field
        Container(
          height: 52,
          decoration: BoxDecoration(
            color: isDark ? AppColors.surfaceVariantDark : AppColors.surfaceVariantLight,
            borderRadius: AppRadius.radiusMd,
            border: Border.all(
              color: isDark ? AppColors.borderDark : AppColors.borderLight,
            ),
          ),
          child: TextField(
            controller: controller,
            style: AppTextStyles.titleMedium(isDark),
            decoration: InputDecoration(
              hintText: 'Search destinations (e.g. Shillong, Goa)',
              prefixIcon: Icon(
                Icons.search_rounded,
                color: isDark ? AppColors.primaryLight : AppColors.primary,
              ),
              suffixIcon: controller.text.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear_rounded, size: 18),
                      onPressed: () => controller.clear(),
                    )
                  : null,
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(vertical: 14),
            ),
          ),
        ),
        AppSpacing.gapV16,

        Text(
          'Popular Getaway Destinations',
          style: AppTextStyles.labelMedium(isDark).copyWith(
            fontWeight: FontWeight.w700,
            color: isDark ? AppColors.textMutedDark : AppColors.textMutedLight,
          ),
        ),
        AppSpacing.gapV12,

        // Popular Destination Rows
        ...popularDestinations.map((dest) {
          final isSelected = controller.text.toLowerCase() == dest['title']!.toLowerCase();

          return InkWell(
            onTap: () => onSelectDestination(dest['title']!),
            borderRadius: AppRadius.radiusMd,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
              child: Row(
                children: [
                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: isDark ? AppColors.surfaceVariantDark : AppColors.surfaceVariantLight,
                      borderRadius: AppRadius.radiusMd,
                    ),
                    child: Center(
                      child: Text(dest['emoji']!, style: const TextStyle(fontSize: 20)),
                    ),
                  ),
                  AppSpacing.gapH12,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          dest['title']!,
                          style: AppTextStyles.titleMedium(isDark).copyWith(
                            fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
                            color: isSelected
                                ? (isDark ? AppColors.primaryLight : AppColors.primary)
                                : null,
                          ),
                        ),
                        Text(
                          dest['subtitle']!,
                          style: AppTextStyles.bodySmall(isDark),
                        ),
                      ],
                    ),
                  ),
                  if (isSelected)
                    Icon(
                      Icons.check_circle_rounded,
                      color: isDark ? AppColors.primaryLight : AppColors.primary,
                    ),
                ],
              ),
            ),
          );
        }),
      ],
    );
  }
}
