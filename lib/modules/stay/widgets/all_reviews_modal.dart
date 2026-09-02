import 'package:flutter/material.dart';
import 'package:sewasetu/app/theme/app_spacing.dart';
import 'package:sewasetu/modules/stay/models/review_model.dart';
import 'package:sewasetu/modules/stay/widgets/review_item_widget.dart';
import 'package:sewasetu/shared/widgets/app_bottom_sheet.dart';

/// Modal bottom sheet displaying all guest reviews
class AllReviewsModal extends StatelessWidget {
  final List<ReviewModel> reviews;
  final double rating;

  const AllReviewsModal({
    super.key,
    required this.reviews,
    required this.rating,
  });

  static Future<void> show(
    BuildContext context, {
    required List<ReviewModel> reviews,
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
