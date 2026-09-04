import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_radius.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_card.dart';
import '../../../../shared/widgets/app_network_image.dart';
import '../models/cart_item_model.dart';
import 'quantity_selector.dart';

/// Item row card inside the shopping bag
class CartItemCard extends StatelessWidget {
  final CartItemModel item;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final VoidCallback onRemove;

  const CartItemCard({
    super.key,
    required this.item,
    required this.onIncrement,
    required this.onDecrement,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final product = item.product;

    return AppCard(
      padding: const EdgeInsets.all(12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Thumbnail
          AppNetworkImage(
            imageUrl: product.images.isNotEmpty
                ? product.images.first
                : '',
            width: 80,
            height: 80,
            borderRadius: AppRadius.radiusMd,
          ),
          AppSpacing.gapH12,
          // Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.stateName.toUpperCase(),
                            style: AppTextStyles.labelSmall(isDark).copyWith(
                              fontSize: 9.5,
                              color: isDark
                                  ? AppColors.primaryLight
                                  : AppColors.primary,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            product.name,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.titleSmall(isDark).copyWith(
                              fontWeight: FontWeight.w700,
                              fontSize: 13,
                              height: 1.25,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close_rounded, size: 18),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      color: isDark
                          ? AppColors.textMutedDark
                          : AppColors.textMutedLight,
                      onPressed: onRemove,
                    ),
                  ],
                ),
                if (item.selectedVariant != null) ...[
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: isDark
                          ? AppColors.surfaceVariantDark
                          : AppColors.surfaceVariantLight,
                      borderRadius: AppRadius.radiusSm,
                    ),
                    child: Text(
                      'Variant: ${item.selectedVariant!.name}',
                      style: TextStyle(
                        fontSize: 10.5,
                        color: isDark
                            ? AppColors.textSecondaryDark
                            : AppColors.textSecondaryLight,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
                AppSpacing.gapV8,
                // Price & Quantity stepper
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '₹${item.totalPrice.toStringAsFixed(item.totalPrice.truncateToDouble() == item.totalPrice ? 0 : 2)}',
                      style: AppTextStyles.priceTag(isDark, fontSize: 16),
                    ),
                    QuantitySelector(
                      quantity: item.quantity,
                      height: 32,
                      onIncrement: onIncrement,
                      onDecrement: onDecrement,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
