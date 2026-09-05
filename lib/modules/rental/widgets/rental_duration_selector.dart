import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_radius.dart';
import '../../../app/theme/app_spacing.dart';
import '../controllers/rental_search_controller.dart';

/// Quick duration presets and custom date/time selector widget.
class RentalDurationSelector extends StatelessWidget {
  const RentalDurationSelector({super.key});

  void _applyQuickPreset(RentalSearchController ctrl, int days) {
    final now = DateTime.now();
    final pickup = DateTime(now.year, now.month, now.day + 1, 10, 0);
    final returnDate = pickup.add(Duration(days: days));

    ctrl.updatePickupDateTime(pickup, const TimeOfDay(hour: 10, minute: 0));
    ctrl.updateReturnDateTime(returnDate, const TimeOfDay(hour: 10, minute: 0));
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final searchCtrl = Get.find<RentalSearchController>();

    final presets = [
      {'label': '1 Day', 'days': 1},
      {'label': '3 Days (Weekend)', 'days': 3},
      {'label': '7 Days (Weekly)', 'days': 7},
    ];

    return Obx(() {
      final currentDays = searchCtrl.searchModel.value.durationDays;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'QUICK DURATION PRESETS',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.6,
              color: isDark ? AppColors.textMutedDark : AppColors.textSecondaryLight,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: presets.map((p) {
              final days = p['days'] as int;
              final label = p['label'] as String;
              final isSelected = currentDays == days;

              return ChoiceChip(
                label: Text(label),
                selected: isSelected,
                selectedColor: AppColors.primary,
                backgroundColor: isDark ? AppColors.surfaceVariantDark : AppColors.surfaceVariantLight,
                labelStyle: TextStyle(
                  fontSize: 12,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                  color: isSelected
                      ? Colors.white
                      : (isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight),
                ),
                shape: const RoundedRectangleBorder(
                  borderRadius: AppRadius.radiusFull,
                ),
                onSelected: (_) => _applyQuickPreset(searchCtrl, days),
              );
            }).toList(),
          ),
        ],
      );
    });
  }
}
