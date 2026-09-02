import 'package:flutter/material.dart';
import 'package:sewasetu/app/theme/app_spacing.dart';
import 'package:sewasetu/shared/widgets/app_counter_stepper.dart';

/// Guest and Room count selection step
class SearchGuestsStep extends StatelessWidget {
  final int adults;
  final int children;
  final int rooms;
  final ValueChanged<int> onAdultsChanged;
  final ValueChanged<int> onChildrenChanged;
  final ValueChanged<int> onRoomsChanged;

  const SearchGuestsStep({
    super.key,
    required this.adults,
    required this.children,
    required this.rooms,
    required this.onAdultsChanged,
    required this.onChildrenChanged,
    required this.onRoomsChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Adults Stepper
        AppCounterStepper(
          label: 'Adults',
          subtitle: 'Ages 13 or above',
          value: adults,
          min: 1,
          max: 16,
          onChanged: onAdultsChanged,
        ),
        AppSpacing.gapV16,
        const Divider(height: 1),
        AppSpacing.gapV16,

        // Children Stepper
        AppCounterStepper(
          label: 'Children',
          subtitle: 'Ages 2–12',
          value: children,
          min: 0,
          max: 10,
          onChanged: onChildrenChanged,
        ),
        AppSpacing.gapV16,
        const Divider(height: 1),
        AppSpacing.gapV16,

        // Rooms Stepper
        AppCounterStepper(
          label: 'Rooms',
          subtitle: 'Number of living units',
          value: rooms,
          min: 1,
          max: 8,
          onChanged: onRoomsChanged,
        ),
      ],
    );
  }
}
