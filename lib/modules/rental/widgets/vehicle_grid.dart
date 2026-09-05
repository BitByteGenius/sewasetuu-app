import 'package:flutter/material.dart';
import '../../../app/theme/app_spacing.dart';
import '../models/vehicle_model.dart';
import 'vehicle_card.dart';

/// Responsive vehicle grid that adapts across mobile phones, tablets, and web.
class VehicleGrid extends StatelessWidget {
  final List<VehicleModel> vehicles;
  final ScrollPhysics? physics;
  final bool shrinkWrap;
  final EdgeInsetsGeometry? padding;

  const VehicleGrid({
    super.key,
    required this.vehicles,
    this.physics,
    this.shrinkWrap = false,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;

        // Tablet / Desktop Grid mode
        if (width >= 600) {
          final crossAxisCount = width >= 950 ? 3 : 2;
          return GridView.builder(
            padding: padding ?? const EdgeInsets.all(AppSpacing.lg),
            physics: physics,
            shrinkWrap: shrinkWrap,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              childAspectRatio: 0.88,
              crossAxisSpacing: AppSpacing.md,
              mainAxisSpacing: AppSpacing.md,
            ),
            itemCount: vehicles.length,
            itemBuilder: (context, index) {
              return VehicleCard(vehicle: vehicles[index]);
            },
          );
        }

        // Mobile Phone List mode
        return ListView.builder(
          padding: padding ?? const EdgeInsets.all(AppSpacing.lg),
          physics: physics,
          shrinkWrap: shrinkWrap,
          itemCount: vehicles.length,
          itemBuilder: (context, index) {
            return VehicleCard(vehicle: vehicles[index]);
          },
        );
      },
    );
  }
}
