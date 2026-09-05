import 'package:flutter/material.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_radius.dart';
import '../../../app/theme/app_spacing.dart';
import '../models/vehicle_feature_model.dart';
import '../models/vehicle_model.dart';

/// Features and amenities list for vehicle details screen.
class VehicleFeaturesWidget extends StatelessWidget {
  final VehicleModel vehicle;

  const VehicleFeaturesWidget({
    super.key,
    required this.vehicle,
  });

  IconData _resolveIcon(String iconKey) {
    switch (iconKey) {
      case 'sports_motorsports':
        return Icons.sports_motorsports_rounded;
      case 'terrain':
        return Icons.terrain_rounded;
      case 'smart_screen':
        return Icons.smart_screen_rounded;
      case 'security':
        return Icons.security_rounded;
      case 'ac_unit':
        return Icons.ac_unit_rounded;
      case 'wb_sunny':
        return Icons.wb_sunny_rounded;
      case 'air':
        return Icons.air_rounded;
      case 'shield':
        return Icons.shield_rounded;
      case 'bolt':
        return Icons.bolt_rounded;
      case 'power':
        return Icons.power_rounded;
      case 'speaker':
        return Icons.speaker_rounded;
      case 'visibility':
        return Icons.visibility_rounded;
      case 'phone_android':
        return Icons.phone_android_rounded;
      case 'map':
        return Icons.map_rounded;
      case 'inventory_2':
        return Icons.inventory_2_rounded;
      case 'touch_app':
        return Icons.touch_app_rounded;
      case 'swap_horiz':
        return Icons.swap_horiz_rounded;
      case 'key':
        return Icons.key_rounded;
      case 'desktop_windows':
        return Icons.desktop_windows_rounded;
      case 'all_inclusive':
        return Icons.all_inclusive_rounded;
      case 'swap_calls':
        return Icons.swap_calls_rounded;
      default:
        return Icons.check_circle_outline_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final List<VehicleFeatureModel> features = List.from(vehicle.features);

    // Fallback standard features
    if (features.isEmpty) {
      features.addAll([
        const VehicleFeatureModel(
          id: 'ft_verified',
          name: '100% Verified Clean Vehicle',
          icon: 'shield',
        ),
        const VehicleFeatureModel(
          id: 'ft_rsa',
          name: '24/7 Roadside Assistance (RSA)',
          icon: 'security',
        ),
        if (vehicle.isTwoWheeler)
          const VehicleFeatureModel(
            id: 'ft_helmet',
            name: 'ISI/DOT Certified Helmet Included',
            icon: 'sports_motorsports',
          ),
      ]);
    }

    return Column(
      children: features.map((feature) {
        return Container(
          margin: const EdgeInsets.only(bottom: AppSpacing.sm),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm + 2,
          ),
          decoration: BoxDecoration(
            color: isDark ? AppColors.surfaceDark : AppColors.surfaceVariantLight,
            borderRadius: AppRadius.radiusMd,
            border: Border.all(
              color: isDark ? AppColors.borderDark : AppColors.borderLight,
            ),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: AppColors.primary.withAlpha((255 * 0.12).round()),
                  borderRadius: AppRadius.radiusSm,
                ),
                child: Icon(
                  _resolveIcon(feature.icon),
                  size: 18,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Text(
                  feature.name,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                  ),
                ),
              ),
              const Icon(
                Icons.verified_rounded,
                size: 16,
                color: AppColors.success,
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
