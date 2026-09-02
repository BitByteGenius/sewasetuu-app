import 'package:flutter/material.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/app_text_styles.dart';
import '../../core/utils/formatters.dart';

/// Rating display widget showing rating score and optional review count.
class AppRatingBar extends StatelessWidget {
  final double rating;
  final int? reviewsCount;
  final double iconSize;
  final bool showReviewsCount;

  const AppRatingBar({
    super.key,
    required this.rating,
    this.reviewsCount,
    this.iconSize = 14.0,
    this.showReviewsCount = true,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          Icons.star_rounded,
          color: AppColors.starGold,
          size: iconSize,
        ),
        const SizedBox(width: 3),
        Text(
          AppFormatters.formatRating(rating),
          style: AppTextStyles.labelMedium(isDark).copyWith(
            fontWeight: FontWeight.w700,
            fontSize: iconSize * 0.9,
          ),
        ),
        if (showReviewsCount && reviewsCount != null) ...[
          const SizedBox(width: 3),
          Text(
            '(${AppFormatters.formatReviewsCount(reviewsCount!)})',
            style: AppTextStyles.bodySmall(isDark).copyWith(
              color: isDark ? AppColors.textMutedDark : AppColors.textMutedLight,
              fontSize: iconSize * 0.8,
            ),
          ),
        ],
      ],
    );
  }
}
