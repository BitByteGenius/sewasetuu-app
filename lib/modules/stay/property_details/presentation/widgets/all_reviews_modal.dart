import 'package:flutter/material.dart';
import 'package:sewasetu/app/theme/app_spacing.dart';
import 'package:sewasetu/modules/stay/review/domain/entities/review_entity.dart';
import 'package:sewasetu/modules/stay/review/presentation/widgets/review_item_widget.dart';
import 'package:sewasetu/shared/widgets/app_bottom_sheet.dart';

/// Modal bottom sheet displaying all guest reviews
class AllReviewsModal extends StatelessWidget {
  final List<StayReviewEntity> reviews;
  final double rating;

  const AllReviewsModal({
    super.key,
    required this.reviews,
    required this.rating,
  });

  static Future<void> show(
    BuildContext context, {
    required List<StayReviewEntity> reviews,
    required double rating,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => AllReviewsModal(reviews: reviews, rating: rating),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppBottomSheet(
      title: 'All Reviews (${reviews.length})',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: reviews.length,
            separatorBuilder: (context, index) => AppSpacing.gapV12,
            itemBuilder: (context, index) {
              return ReviewItemWidget(review: reviews[index]);
            },
          ),
        ],
      ),
    );
  }
}
