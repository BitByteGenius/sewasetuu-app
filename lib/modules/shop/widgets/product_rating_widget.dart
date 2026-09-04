import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';

/// Rating star badge with score and review count
class ProductRatingWidget extends StatelessWidget {
  final double rating;
  final int reviewCount;
  final bool showCount;
  final double iconSize;

  const ProductRatingWidget({
    super.key,
    required this.rating,
    this.reviewCount = 0,
    this.showCount = true,
    this.iconSize = 13,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.star_rounded,
          color: AppColors.secondary,
          size: iconSize,
        ),
        const SizedBox(width: 3),
        Text(
          rating.toStringAsFixed(1),
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 12,
          ),
        ),
        if (showCount && reviewCount > 0) ...[
          const SizedBox(width: 2),
          Text(
            '($reviewCount)',
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 11,
            ),
          ),
        ],
      ],
    );
  }
}
