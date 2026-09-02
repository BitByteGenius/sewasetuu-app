import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sewasetu/app/theme/app_colors.dart';
import 'package:sewasetu/app/theme/app_radius.dart';
import 'package:sewasetu/app/theme/app_spacing.dart';
import 'package:sewasetu/app/theme/app_text_styles.dart';

enum DateFlexibility { exact, oneDay, threeDays, anyWeekend }

/// Interactive Check-in & Check-out Date Range Picker with flexibility options
class SearchDatesStep extends StatelessWidget {
  final DateTime? checkIn;
  final DateTime? checkOut;
  final DateFlexibility flexibility;
  final Function(DateTime checkIn, DateTime checkOut) onDatesSelected;
  final ValueChanged<DateFlexibility> onFlexibilityChanged;

  const SearchDatesStep({
    super.key,
    required this.checkIn,
    required this.checkOut,
    required this.flexibility,
    required this.onDatesSelected,
    required this.onFlexibilityChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final formatter = DateFormat('EEE, dd MMM');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Selected Date Cards
        Row(
          children: [
            Expanded(
              child: _buildDatePill(
                isDark: isDark,
                title: 'CHECK-IN',
                value: checkIn != null ? formatter.format(checkIn!) : 'Add date',
                icon: Icons.calendar_today_rounded,
                onTap: () => _pickDateRange(context),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildDatePill(
                isDark: isDark,
                title: 'CHECK-OUT',
                value: checkOut != null ? formatter.format(checkOut!) : 'Add date',
                icon: Icons.event_available_rounded,
                onTap: () => _pickDateRange(context),
              ),
            ),
          ],
        ),
        AppSpacing.gapV24,

        // Quick Preset Days
        Text(
          'Quick Selection',
          style: AppTextStyles.labelMedium(isDark).copyWith(
            fontWeight: FontWeight.w700,
            color: isDark ? AppColors.textMutedDark : AppColors.textMutedLight,
          ),
        ),
        AppSpacing.gapV12,
        Row(
          children: [
            _buildPresetChip(
              isDark: isDark,
              label: 'This Weekend',
              onTap: () {
                final now = DateTime.now();
                final daysUntilSaturday = DateTime.saturday - now.weekday;
                final sat = now.add(Duration(days: daysUntilSaturday >= 0 ? daysUntilSaturday : daysUntilSaturday + 7));
                final sun = sat.add(const Duration(days: 2));
                onDatesSelected(sat, sun);
              },
            ),
            const SizedBox(width: 8),
            _buildPresetChip(
              isDark: isDark,
              label: 'Next 1 Week',
              onTap: () {
                final now = DateTime.now().add(const Duration(days: 1));
                onDatesSelected(now, now.add(const Duration(days: 7)));
              },
            ),
            const SizedBox(width: 8),
            _buildPresetChip(
              isDark: isDark,
              label: '1 Month',
              onTap: () {
                final now = DateTime.now().add(const Duration(days: 1));
                onDatesSelected(now, now.add(const Duration(days: 30)));
              },
            ),
          ],
        ),
        AppSpacing.gapV24,

        // Flexible Dates Options
        Text(
          'Flexible with dates?',
          style: AppTextStyles.labelMedium(isDark).copyWith(
            fontWeight: FontWeight.w700,
            color: isDark ? AppColors.textMutedDark : AppColors.textMutedLight,
          ),
        ),
        AppSpacing.gapV12,
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _buildFlexChip(isDark, 'Exact dates', DateFlexibility.exact),
            _buildFlexChip(isDark, '± 1 day', DateFlexibility.oneDay),
            _buildFlexChip(isDark, '± 3 days', DateFlexibility.threeDays),
            _buildFlexChip(isDark, 'Any weekend', DateFlexibility.anyWeekend),
          ],
        ),
      ],
    );
  }

  Widget _buildDatePill({
    required bool isDark,
    required String title,
    required String value,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: isDark ? AppColors.surfaceVariantDark : AppColors.surfaceVariantLight,
          borderRadius: AppRadius.radiusMd,
          border: Border.all(
            color: isDark ? AppColors.borderDark : AppColors.borderLight,
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 20,
              color: isDark ? AppColors.primaryLight : AppColors.primary,
            ),
            AppSpacing.gapH8,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.labelSmall(isDark).copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 10,
                  ),
                ),
                Text(
                  value,
                  style: AppTextStyles.titleSmall(isDark).copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPresetChip({
    required bool isDark,
    required String label,
    required VoidCallback onTap,
  }) {
    return ActionChip(
      label: Text(label),
      backgroundColor: isDark ? AppColors.surfaceVariantDark : AppColors.surfaceVariantLight,
      labelStyle: AppTextStyles.labelMedium(isDark),
      onPressed: onTap,
    );
  }

  Widget _buildFlexChip(bool isDark, String label, DateFlexibility target) {
    final isSelected = flexibility == target;

    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      selectedColor: isDark ? AppColors.primaryContainerDark : AppColors.primaryContainer,
      backgroundColor: isDark ? AppColors.surfaceVariantDark : AppColors.surfaceVariantLight,
      labelStyle: AppTextStyles.labelMedium(isDark).copyWith(
        color: isSelected
            ? (isDark ? AppColors.primaryLight : AppColors.primary)
            : (isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight),
        fontWeight: isSelected ? FontWeight.w800 : FontWeight.w500,
      ),
      onSelected: (selected) {
        if (selected) onFlexibilityChanged(target);
      },
    );
  }

  Future<void> _pickDateRange(BuildContext context) async {
    final initialRange = DateTimeRange(
      start: checkIn ?? DateTime.now().add(const Duration(days: 1)),
      end: checkOut ?? DateTime.now().add(const Duration(days: 3)),
    );

    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      initialDateRange: initialRange,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context),
          child: child!,
        );
      },
    );

    if (picked != null) {
      onDatesSelected(picked.start, picked.end);
    }
  }
}
