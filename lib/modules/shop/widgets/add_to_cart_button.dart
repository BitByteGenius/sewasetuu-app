import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_button.dart';

/// Sticky bottom bar button for adding a product to the cart with price summary
class AddToCartButton extends StatelessWidget {
  final double price;
  final VoidCallback onAddToCart;
  final bool isInCart;
  final VoidCallback? onGoToCart;

  const AddToCartButton({
    super.key,
    required this.price,
    required this.onAddToCart,
    this.isInCart = false,
    this.onGoToCart,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(20),
            blurRadius: 10,
            offset: const Offset(0, -3),
          ),
        ],
        border: Border(
          top: BorderSide(
            color: isDark ? AppColors.borderDark : AppColors.borderLight,
          ),
        ),
      ),
      child: SafeArea(
        child: Row(
          children: [
            // Price info
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Total Payable',
                  style: AppTextStyles.bodySmall(isDark).copyWith(
                    color: isDark ? AppColors.textMutedDark : AppColors.textMutedLight,
                    fontSize: 11,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '₹${price.toStringAsFixed(price.truncateToDouble() == price ? 0 : 2)}',
                  style: AppTextStyles.priceTag(isDark, fontSize: 18),
                ),
              ],
            ),
            const SizedBox(width: 20),
            // Action button
            Expanded(
              child: isInCart
                  ? AppButton.secondary(
                      text: 'View in Bag',
                      icon: const Icon(Icons.arrow_forward_rounded, size: 18),
                      onPressed: onGoToCart ?? onAddToCart,
                    )
                  : AppButton.primary(
                      text: 'Add to Cart',
                      icon: const Icon(Icons.shopping_bag_outlined, size: 18),
                      onPressed: onAddToCart,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
