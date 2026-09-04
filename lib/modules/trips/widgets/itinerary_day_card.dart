import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_radius.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_card.dart';
import '../models/itinerary_day_model.dart';

/// Interactive expandable card displaying one day's complete schedule
class ItineraryDayCard extends StatelessWidget {
  final ItineraryDayModel day;
  final bool isExpanded;
  final VoidCallback onToggle;
  final bool isLast;

  const ItineraryDayCard({
    super.key,
    required this.day,
    required this.isExpanded,
    required this.onToggle,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Left Timeline Pillar
          Column(
            children: [
              // Day Indicator Circle
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: isExpanded
                      ? (isDark ? AppColors.primaryLight : AppColors.primary)
                      : (isDark
                          ? AppColors.surfaceVariantDark
                          : AppColors.surfaceVariantLight),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isDark
                        ? AppColors.primaryLight
                        : AppColors.primary,
                    width: 2,
                  ),
                ),
                child: Center(
                  child: Text(
                    'D${day.dayNumber}',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w900,
                      color: isExpanded
                          ? (isDark ? Colors.black : Colors.white)
                          : (isDark
                              ? AppColors.primaryLight
                              : AppColors.primary),
                    ),
                  ),
                ),
              ),
              // Connecting line
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    color: isDark ? AppColors.borderDark : AppColors.borderLight,
                  ),
                ),
            ],
          ),
          const SizedBox(width: 12),

          // 2. Right Content Card
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: AppCard(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header Bar (Clickable)
                    InkWell(
                      onTap: onToggle,
                      borderRadius: BorderRadius.circular(8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  day.dayHeader,
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w800,
                                    color: isDark
                                        ? AppColors.primaryLight
                                        : AppColors.primary,
                                    letterSpacing: 0.6,
                                  ),
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  day.title,
                                  style: AppTextStyles.titleSmall(isDark).copyWith(
                                    fontWeight: FontWeight.w800,
                                    height: 1.25,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Icon(
                            isExpanded
                                ? Icons.keyboard_arrow_up_rounded
                                : Icons.keyboard_arrow_down_rounded,
                            color: isDark
                                ? AppColors.textMutedDark
                                : AppColors.textMutedLight,
                          ),
                        ],
                      ),
                    ),

                    // Expanded Details
                    if (isExpanded) ...[
                      const Divider(height: 20),
                      // Narrative description
                      Text(
                        day.description,
                        style: AppTextStyles.bodyMedium(isDark).copyWith(
                          height: 1.45,
                          fontSize: 13,
                        ),
                      ),
                      AppSpacing.gapV12,

                      // Activities List
                      if (day.activities.isNotEmpty) ...[
                        Text(
                          'Key Highlights & Activities',
                          style: AppTextStyles.labelMedium(isDark).copyWith(
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 6),
                        ...day.activities.map((act) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Icon(
                                  Icons.check_circle_rounded,
                                  color: AppColors.primary,
                                  size: 15,
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    act,
                                    style: AppTextStyles.bodySmall(isDark).copyWith(
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                        AppSpacing.gapV12,
                      ],

                      // Meals & Stay Meta Pills
                      Row(
                        children: [
                          if (day.meals.isNotEmpty)
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 8),
                                decoration: BoxDecoration(
                                  color: isDark
                                      ? AppColors.surfaceVariantDark.withAlpha(60)
                                      : AppColors.surfaceVariantLight,
                                  borderRadius: AppRadius.radiusSm,
                                ),
                                child: Row(
                                  children: [
                                    const Icon(Icons.restaurant_rounded,
                                        size: 14, color: AppColors.secondary),
                                    const SizedBox(width: 6),
                                    Expanded(
                                      child: Text(
                                        'Meals: ${day.meals.join(', ')}',
                                        style: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w600,
                                          color: isDark
                                              ? AppColors.textPrimaryDark
                                              : AppColors.textPrimaryLight,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          if (day.meals.isNotEmpty && day.stayLocation != null)
                            const SizedBox(width: 8),
                          if (day.stayLocation != null)
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 8),
                                decoration: BoxDecoration(
                                  color: isDark
                                      ? AppColors.surfaceVariantDark.withAlpha(60)
                                      : AppColors.surfaceVariantLight,
                                  borderRadius: AppRadius.radiusSm,
                                ),
                                child: Row(
                                  children: [
                                    const Icon(Icons.hotel_rounded,
                                        size: 14, color: AppColors.primary),
                                    const SizedBox(width: 6),
                                    Expanded(
                                      child: Text(
                                        day.stayLocation!,
                                        style: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w600,
                                          color: isDark
                                              ? AppColors.textPrimaryDark
                                              : AppColors.textPrimaryLight,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
