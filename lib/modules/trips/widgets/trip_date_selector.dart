import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_radius.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_card.dart';

/// Interactive departure date picker offering quick date chips & full calendar picker
class TripDateSelector extends StatelessWidget {
  final List<DateTime> availableDates;
  final DateTime? selectedDate;
  final ValueChanged<DateTime> onDateSelected;

  const TripDateSelector({
    super.key,
    required this.availableDates,
    required this.selectedDate,
    required this.onDateSelected,
  });

  Future<void> _pickCustomDate(BuildContext context) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? now.add(const Duration(days: 7)),
      firstDate: now.add(const Duration(days: 2)),
      lastDate: now.add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.fromSeed(
              seedColor: AppColors.primary,
              brightness: Theme.of(context).brightness,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      onDateSelected(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final dateFormat = DateFormat('EEE, dd MMM');

    // Combine available dates with the selected date if custom
    final displayDates = List<DateTime>.from(availableDates);
    if (selectedDate != null &&
        !displayDates.any((d) =>
            d.year == selectedDate!.year &&
            d.month == selectedDate!.month &&
            d.day == selectedDate!.day)) {
      displayDates.insert(0, selectedDate!);
    }

    return AppCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.event_available_rounded,
                      size: 20, color: AppColors.primary),
                  const SizedBox(width: 8),
                  Text(
                    'Select Departure Date',
                    style: AppTextStyles.titleMedium(isDark).copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
              TextButton.icon(
                onPressed: () => _pickCustomDate(context),
                icon: const Icon(Icons.calendar_month_outlined, size: 16),
                label: const Text('Other'),
                style: TextButton.styleFrom(
                  foregroundColor:
                      isDark ? AppColors.primaryLight : AppColors.primary,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  textStyle: const TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
          AppSpacing.gapV12,

          // Horizontal Date Chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: displayDates.map((date) {
                final isSelected = selectedDate != null &&
                    date.year == selectedDate!.year &&
                    date.month == selectedDate!.month &&
                    date.day == selectedDate!.day;

                return Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: InkWell(
                    onTap: () => onDateSelected(date),
                    borderRadius: AppRadius.radiusMd,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 10),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? (isDark
                                ? AppColors.primaryLight.withAlpha(40)
                                : AppColors.primary.withAlpha(20))
                            : (isDark
                                ? AppColors.surfaceVariantDark.withAlpha(50)
                                : AppColors.surfaceVariantLight),
                        borderRadius: AppRadius.radiusMd,
                        border: Border.all(
                          color: isSelected
                              ? (isDark
                                  ? AppColors.primaryLight
                                  : AppColors.primary)
                              : (isDark
                                  ? AppColors.borderDark
                                  : AppColors.borderLight),
                          width: isSelected ? 1.5 : 1,
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            dateFormat.format(date),
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: isSelected
                                  ? FontWeight.w800
                                  : FontWeight.w600,
                              color: isSelected
                                  ? (isDark
                                      ? AppColors.primaryLight
                                      : AppColors.primary)
                                  : (isDark
                                      ? AppColors.textPrimaryDark
                                      : AppColors.textPrimaryLight),
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'Guaranteed Batch',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              color: isSelected
                                  ? (isDark
                                      ? AppColors.primaryLight
                                      : AppColors.primary)
                                  : (isDark
                                      ? AppColors.textMutedDark
                                      : AppColors.textMutedLight),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
