import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_radius.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_card.dart';

/// Financial breakdown card for the shopping cart and checkout screen
class OrderSummaryWidget extends StatelessWidget {
  final double subtotal;
  final double deliveryFee;
  final double discount;
  final double total;
  final String? appliedPromoCode;
  final VoidCallback? onRemovePromo;
  final Function(String)? onApplyPromo;

  const OrderSummaryWidget({
    super.key,
    required this.subtotal,
    required this.deliveryFee,
    required this.discount,
    required this.total,
    this.appliedPromoCode,
    this.onRemovePromo,
    this.onApplyPromo,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final promoController = TextEditingController();

    return AppCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Price Summary',
            style: AppTextStyles.titleMedium(isDark).copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
          AppSpacing.gapV12,
          // Free delivery threshold banner
          if (subtotal > 0 && subtotal < 999.0) ...[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: isDark
                    ? AppColors.primaryContainerDark
                    : AppColors.primaryContainer,
                borderRadius: AppRadius.radiusMd,
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.local_shipping_outlined,
                    size: 18,
                    color: isDark ? AppColors.primaryLight : AppColors.primary,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Add ₹${(999.0 - subtotal).toStringAsFixed(0)} more for FREE Delivery!',
                      style: TextStyle(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w700,
                        color: isDark ? AppColors.primaryLight : AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            AppSpacing.gapV12,
          ],
          // Subtotal row
          _buildRow(
            isDark: isDark,
            label: 'Items Subtotal',
            value: '₹${subtotal.toStringAsFixed(subtotal.truncateToDouble() == subtotal ? 0 : 2)}',
          ),
          const SizedBox(height: 8),
          // Delivery row
          _buildRow(
            isDark: isDark,
            label: 'Artisan Delivery Fee',
            value: deliveryFee == 0.0 ? 'FREE' : '₹${deliveryFee.toStringAsFixed(0)}',
            valueColor: deliveryFee == 0.0 ? AppColors.success : null,
          ),
          if (discount > 0) ...[
            const SizedBox(height: 8),
            _buildRow(
              isDark: isDark,
              label: 'Discount (${appliedPromoCode ?? 'Promo'})',
              value: '-₹${discount.toStringAsFixed(0)}',
              valueColor: AppColors.success,
            ),
          ],
          AppSpacing.gapV12,
          const Divider(),
          AppSpacing.gapV8,
          // Total row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Amount',
                style: AppTextStyles.titleMedium(isDark).copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
              Text(
                '₹${total.toStringAsFixed(total.truncateToDouble() == total ? 0 : 2)}',
                style: AppTextStyles.priceTag(isDark, fontSize: 18),
              ),
            ],
          ),
          if (onApplyPromo != null) ...[
            AppSpacing.gapV16,
            if (appliedPromoCode != null && appliedPromoCode!.isNotEmpty) ...[
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.successLight,
                  borderRadius: AppRadius.radiusMd,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Code $appliedPromoCode applied',
                      style: const TextStyle(
                        color: Color(0xFF065F46),
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                      ),
                    ),
                    InkWell(
                      onTap: onRemovePromo,
                      child: const Icon(
                        Icons.close_rounded,
                        size: 16,
                        color: Color(0xFF065F46),
                      ),
                    ),
                  ],
                ),
              ),
            ] else ...[
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: promoController,
                      textCapitalization: TextCapitalization.characters,
                      style: AppTextStyles.bodyMedium(isDark),
                      decoration: InputDecoration(
                        hintText: 'Try SEWASETU100',
                        hintStyle: TextStyle(
                          fontSize: 12,
                          color: isDark
                              ? AppColors.textMutedDark
                              : AppColors.textMutedLight,
                        ),
                        isDense: true,
                        filled: true,
                        fillColor: isDark
                            ? AppColors.surfaceVariantDark
                            : AppColors.surfaceVariantLight,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 10,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: AppRadius.radiusMd,
                          borderSide: BorderSide(
                            color: isDark
                                ? AppColors.borderDark
                                : AppColors.borderLight,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  TextButton(
                    onPressed: () {
                      if (promoController.text.trim().isNotEmpty) {
                        onApplyPromo!(promoController.text.trim());
                      }
                    },
                    child: const Text('Apply'),
                  ),
                ],
              ),
            ],
          ],
        ],
      ),
    );
  }

  Widget _buildRow({
    required bool isDark,
    required String label,
    required String value,
    Color? valueColor,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTextStyles.bodyMedium(isDark).copyWith(
            color: isDark
                ? AppColors.textSecondaryDark
                : AppColors.textSecondaryLight,
            fontSize: 13,
          ),
        ),
        Text(
          value,
          style: AppTextStyles.bodyMedium(isDark).copyWith(
            fontWeight: FontWeight.w700,
            color: valueColor,
            fontSize: 13,
          ),
        ),
      ],
    );
  }
}
