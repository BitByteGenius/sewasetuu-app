import 'package:flutter/material.dart';
import 'package:sewasetu/app/theme/app_colors.dart';
import 'package:sewasetu/app/theme/app_radius.dart';
import 'package:sewasetu/app/theme/app_spacing.dart';
import 'package:sewasetu/app/theme/app_text_styles.dart';

/// Amenities display with modern circular icons and labels.
class AmenitiesGridWidget extends StatelessWidget {
  final List<String> amenities;

  const AmenitiesGridWidget({
    super.key,
    required this.amenities,
  });

  IconData _getIconForAmenity(String amenity) {
    final lower = amenity.toLowerCase();
    if (lower.contains('wifi')) return Icons.wifi_rounded;
    if (lower.contains('breakfast') || lower.contains('meal') || lower.contains('food')) {
      return Icons.restaurant_rounded;
    }
    if (lower.contains('ac') || lower.contains('conditioner')) return Icons.ac_unit_rounded;
    if (lower.contains('parking')) return Icons.local_parking_rounded;
    if (lower.contains('geyser') || lower.contains('water')) return Icons.hot_tub_rounded;
    if (lower.contains('pool')) return Icons.pool_rounded;
    if (lower.contains('kitchen')) return Icons.kitchen_rounded;
    if (lower.contains('security')) return Icons.shield_outlined;
    if (lower.contains('laundry')) return Icons.local_laundry_service_outlined;
    if (lower.contains('tv')) return Icons.tv_rounded;
    if (lower.contains('view') || lower.contains('mountain')) return Icons.landscape_outlined;
    if (lower.contains('fire') || lower.contains('bbq')) return Icons.outdoor_grill_outlined;
    return Icons.check_circle_outline_rounded;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: amenities.map((amenity) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: isDark ? AppColors.surfaceVariantDark : AppColors.surfaceVariantLight,
            borderRadius: AppRadius.radiusMd,
            border: Border.all(
              color: isDark ? AppColors.borderDark : AppColors.borderLight,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                _getIconForAmenity(amenity),
                size: 18,
                color: isDark ? AppColors.primaryLight : AppColors.primary,
              ),
              AppSpacing.gapH8,
              Text(
                amenity,
                style: AppTextStyles.labelMedium(isDark),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
