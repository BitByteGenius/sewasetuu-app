import 'package:flutter/material.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_radius.dart';
import '../../../app/theme/app_spacing.dart';
import '../models/vehicle_model.dart';
import '../models/vehicle_specification_model.dart';

/// Clean, structured specification tiles for vehicle performance and dimensions.
class VehicleSpecificationsWidget extends StatelessWidget {
  final VehicleModel vehicle;

  const VehicleSpecificationsWidget({
    super.key,
    required this.vehicle,
  });

  IconData _resolveIcon(String? iconName) {
    switch (iconName) {
      case 'settings':
        return Icons.settings_suggest_rounded;
      case 'local_gas_station':
        return Icons.local_gas_station_rounded;
      case 'height':
        return Icons.swap_vert_rounded;
      case 'luggage':
        return Icons.luggage_rounded;
      case 'battery_charging_full':
        return Icons.battery_charging_full_rounded;
      case 'speed':
        return Icons.speed_rounded;
      case 'people':
        return Icons.people_outline_rounded;
      case 'eco':
        return Icons.eco_rounded;
      case 'timer':
        return Icons.timer_outlined;
      case 'build':
        return Icons.build_rounded;
      case 'bolt':
        return Icons.bolt_rounded;
      default:
        return Icons.info_outline_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Build default specs if specifications list is short
    final List<VehicleSpecificationModel> specs = List.from(vehicle.specifications);

    if (specs.isEmpty) {
      specs.addAll([
        VehicleSpecificationModel(
          key: 'trans',
          label: 'Transmission',
          value: vehicle.transmission,
          iconName: 'settings',
        ),
        VehicleSpecificationModel(
          key: 'fuel',
          label: 'Fuel Type',
          value: vehicle.fuelType,
          iconName: 'local_gas_station',
        ),
        VehicleSpecificationModel(
          key: 'seats',
          label: 'Seating',
          value: vehicle.isTwoWheeler ? '2 Persons' : '${vehicle.seats} Seats',
          iconName: 'people',
        ),
        VehicleSpecificationModel(
          key: 'mileage',
          label: 'Mileage / Range',
          value: vehicle.mileage,
          iconName: 'speed',
        ),
        if (vehicle.enginePower.isNotEmpty)
          VehicleSpecificationModel(
            key: 'power',
            label: 'Engine Power',
            value: vehicle.enginePower,
            iconName: 'bolt',
          ),
      ]);
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = constraints.maxWidth > 500 ? 3 : 2;

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: specs.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            childAspectRatio: 2.2,
            crossAxisSpacing: AppSpacing.sm,
            mainAxisSpacing: AppSpacing.sm,
          ),
          itemBuilder: (context, index) {
            final spec = specs[index];
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: 8),
              decoration: BoxDecoration(
                color: isDark ? AppColors.surfaceDark : AppColors.surfaceVariantLight,
                borderRadius: AppRadius.radiusLg,
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
                      borderRadius: AppRadius.radiusMd,
                    ),
                    child: Icon(
                      _resolveIcon(spec.iconName),
                      size: 18,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          spec.label,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: isDark ? AppColors.textMutedDark : AppColors.textSecondaryLight,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          spec.value,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
