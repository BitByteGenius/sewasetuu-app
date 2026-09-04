import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../models/itinerary_day_model.dart';
import 'itinerary_day_card.dart';

/// Complete Day-by-Day timeline presentation for trip package itineraries
class ItineraryTimeline extends StatelessWidget {
  final List<ItineraryDayModel> itinerary;
  final Set<int> expandedDays;
  final ValueChanged<int> onToggleDay;
  final VoidCallback onExpandAll;
  final VoidCallback onCollapseAll;

  const ItineraryTimeline({
    super.key,
    required this.itinerary,
    required this.expandedDays,
    required this.onToggleDay,
    required this.onExpandAll,
    required this.onCollapseAll,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final allExpanded = expandedDays.length == itinerary.length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Day-by-Day Itinerary',
              style: AppTextStyles.titleLarge(isDark).copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
            TextButton(
              onPressed: allExpanded ? onCollapseAll : onExpandAll,
              style: TextButton.styleFrom(
                foregroundColor:
                    isDark ? AppColors.primaryLight : AppColors.primary,
                padding: const EdgeInsets.symmetric(horizontal: 8),
              ),
              child: Text(
                allExpanded ? 'Collapse All' : 'Expand All',
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ),
        AppSpacing.gapV12,
        ...itinerary.asMap().entries.map((entry) {
          final index = entry.key;
          final day = entry.value;
          final isLast = index == itinerary.length - 1;
          final isExpanded = expandedDays.contains(day.dayNumber);

          return ItineraryDayCard(
            day: day,
            isExpanded: isExpanded,
            isLast: isLast,
            onToggle: () => onToggleDay(day.dayNumber),
          );
        }),
      ],
    );
  }
}
