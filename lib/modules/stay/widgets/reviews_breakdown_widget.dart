import 'package:flutter/material.dart';
import 'package:sewasetu/app/theme/app_colors.dart';
import 'package:sewasetu/app/theme/app_radius.dart';
import 'package:sewasetu/app/theme/app_spacing.dart';
import 'package:sewasetu/app/theme/app_text_styles.dart';

/// 6-dimension ratings progress bars widget inspired by modern luxury hospitality reviews
class ReviewsBreakdownWidget extends StatelessWidget {
  final double overallRating;
  final int totalReviews;

  const ReviewsBreakdownWidget({
    super.key,
    required this.overallRating,
    required this.totalReviews,
  });

  static const List<Map<String, dynamic>> dimensions = [
    {'label': 'Cleanliness', 'score': 4.9, 'icon': Icons.cleaning_services_outlined},
    {'label': 'Accuracy', 'score': 4.8, 'icon': Icons.verified_outlined},
    {'label': 'Communication', 'score': 5.0, 'icon': Icons.chat_bubble_outline_rounded},
    {'label': 'Location', 'score': 4.9, 'icon': Icons.location_on_outlined},
    {'label': 'Check-in', 'score': 4.8, 'icon': Icons.key_outlined},
    {'label': 'Value', 'score': 4.7, 'icon': Icons.sell_outlined},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Big Rating Score Header
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(Icons.star_rounded, size: 36, color: AppColors.starGold),
            const SizedBox(width: 8),
            Text(
              overallRating.toStringAsFixed(2),
              style: AppTextStyles.displaySmall(isDark).copyWith(
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(width: 12),
            Text('•', style: AppTextStyles.headlineSmall(isDark)),
            const SizedBox(width: 12),
            Text(
              '$totalReviews Guest Reviews',
              style: AppTextStyles.titleMedium(isDark).copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        AppSpacing.gapV16,

        // 6 Rating Dimension Progress Bars
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 12,
            childAspectRatio: 3.2,
          ),
          itemCount: dimensions.length,
          itemBuilder: (context, index) {
            final dim = dimensions[index];
            final score = dim['score'] as double;
            final icon = dim['icon'] as IconData;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(icon, size: 14, color: isDark ? AppColors.textMutedDark : AppColors.textMutedLight),
                        const SizedBox(width: 6),
                        Text(
                          dim['label'] as String,
                          style: AppTextStyles.labelSmall(isDark).copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      score.toStringAsFixed(1),
                      style: AppTextStyles.labelSmall(isDark).copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                ClipRRect(
                  borderRadius: AppRadius.radiusPill,
                  child: LinearProgressIndicator(
                    value: score / 5.0,
                    minHeight: 4,
                    backgroundColor: isDark ? AppColors.surfaceVariantDark : AppColors.surfaceVariantLight,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      isDark ? AppColors.primaryLight : AppColors.primary,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
