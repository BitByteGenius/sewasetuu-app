import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_radius.dart';
import '../../../app/theme/app_spacing.dart';
import '../controllers/rental_controller.dart';
import '../models/vehicle_model.dart';

/// Horizontal selector for vehicle types (All, Cars, Bikes, Scooters, SUVs, Luxury, Electric).
class VehicleTypeSelector extends StatelessWidget {
  final RentalVehicleType? selectedType;
  final Function(RentalVehicleType)? onTypeSelected;

  const VehicleTypeSelector({
    super.key,
    this.selectedType,
    this.onTypeSelected,
  });

  IconData _getIcon(RentalVehicleType type) {
    switch (type) {
      case RentalVehicleType.all:
        return Icons.grid_view_rounded;
      case RentalVehicleType.car:
        return Icons.directions_car_rounded;
      case RentalVehicleType.bike:
        return Icons.two_wheeler_rounded;
      case RentalVehicleType.scooter:
        return Icons.moped_rounded;
      case RentalVehicleType.suv:
        return Icons.directions_car_filled_rounded;
      case RentalVehicleType.luxury:
        return Icons.diamond_rounded;
      case RentalVehicleType.electric:
        return Icons.bolt_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final rentalCtrl = Get.isRegistered<RentalController>() ? Get.find<RentalController>() : null;

    final types = RentalVehicleType.values;

    return SizedBox(
      height: 48,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
        scrollDirection: Axis.horizontal,
        itemCount: types.length,
        separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.sm),
        itemBuilder: (context, index) {
          final type = types[index];

          if (rentalCtrl != null && selectedType == null) {
            return Obx(() {
              final isSelected = rentalCtrl.selectedCategoryTab.value == type;
              return _buildChip(context, type, isSelected, isDark, () {
                if (onTypeSelected != null) {
                  onTypeSelected!(type);
                } else {
                  rentalCtrl.selectCategoryTab(type);
                }
              });
            });
          }

          final isSelected = selectedType == type;
          return _buildChip(context, type, isSelected, isDark, () {
            onTypeSelected?.call(type);
          });
        },
      ),
    );
  }

  Widget _buildChip(
    BuildContext context,
    RentalVehicleType type,
    bool isSelected,
    bool isDark,
    VoidCallback onTap,
  ) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: AppRadius.radiusFull,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected
                ? AppColors.primary
                : (isDark ? AppColors.surfaceDark : AppColors.surfaceLight),
            borderRadius: AppRadius.radiusFull,
            border: Border.all(
              color: isSelected
                  ? AppColors.primary
                  : (isDark ? AppColors.borderDark : AppColors.borderLight),
              width: 1.2,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                _getIcon(type),
                size: 17,
                color: isSelected
                    ? Colors.white
                    : (isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight),
              ),
              const SizedBox(width: 6),
              Text(
                type.label,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                  color: isSelected
                      ? Colors.white
                      : (isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
