import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_text_styles.dart';

/// Price formatting widget with current price, strike-through original price, and discount badge
class ProductPriceWidget extends StatelessWidget {
  final double price;
  final double? originalPrice;
  final int discountPercentage;
  final String currency;
  final double fontSize;
  final bool showDiscountBadge;

  const ProductPriceWidget({
    super.key,
    required this.price,
    this.originalPrice,
    this.discountPercentage = 0,
    this.currency = '₹',
    this.fontSize = 16,
    this.showDiscountBadge = true,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final hasDiscount = originalPrice != null && originalPrice! > price;

    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 6,
      children: [
        // Main selling price
        Text(
          '$currency${price.toStringAsFixed(price.truncateToDouble() == price ? 0 : 2)}',
          style: AppTextStyles.priceTag(isDark, fontSize: fontSize),
        ),
        // Strikethrough original price
        if (hasDiscount) ...[
          Text(
            '$currency${originalPrice!.toStringAsFixed(0)}',
            style: TextStyle(
              fontSize: fontSize * 0.75,
              color: isDark ? AppColors.textMutedDark : AppColors.textMutedLight,
              decoration: TextDecoration.lineThrough,
              fontWeight: FontWeight.w500,
            ),
          ),
          if (showDiscountBadge && discountPercentage > 0)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
              decoration: BoxDecoration(
                color: AppColors.successLight,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                '$discountPercentage% OFF',
                style: const TextStyle(
                  color: Color(0xFF065F46),
                  fontSize: 9.5,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
        ],
      ],
    );
  }
}
