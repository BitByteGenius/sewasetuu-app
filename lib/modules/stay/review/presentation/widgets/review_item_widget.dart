import 'package:flutter/material.dart';
import 'package:sewasetu/app/theme/app_radius.dart';
import 'package:sewasetu/app/theme/app_spacing.dart';
import 'package:sewasetu/app/theme/app_text_styles.dart';
import 'package:sewasetu/shared/widgets/app_card.dart';
import 'package:sewasetu/shared/widgets/app_network_image.dart';
import 'package:sewasetu/shared/widgets/app_rating_bar.dart';
import 'package:sewasetu/modules/stay/review/domain/entities/review_entity.dart';

/// Review card item presenting reviewer details, rating, and feedback comment.
class ReviewItemWidget extends StatelessWidget {
  final StayReviewEntity review;

  const ReviewItemWidget({
    super.key,
    required this.review,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return AppCard(
      padding: AppSpacing.edgeInsetsMd,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              AppNetworkImage(
                imageUrl: review.userAvatar,
                width: 40,
                height: 40,
                borderRadius: AppRadius.radiusPill,
              ),
              AppSpacing.gapH12,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review.userName,
                      style: AppTextStyles.titleSmall(isDark).copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      review.dateText,
                      style: AppTextStyles.bodySmall(isDark),
                    ),
                  ],
                ),
              ),
              AppRatingBar(
                rating: review.rating,
                showReviewsCount: false,
              ),
            ],
          ),
          AppSpacing.gapV12,
          Text(
            review.comment,
            style: AppTextStyles.bodyMedium(isDark),
          ),
        ],
      ),
    );
  }
}
