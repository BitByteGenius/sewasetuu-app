import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_radius.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/app_card.dart';
import '../../../../shared/widgets/app_network_image.dart';
import '../models/shop_order_model.dart';
import '../shop_navigator.dart';

/// Celebratory order confirmation screen
class OrderSuccessScreen extends StatelessWidget {
  final ShopOrderModel order;

  const OrderSuccessScreen({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) ShopNavigator.toShop();
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Order Confirmed'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: AppSpacing.screenPadding,
          child: Column(
            children: [
              AppSpacing.gapV24,
              // Celebration badge
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  color: AppColors.successLight,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check_circle_rounded,
                  color: AppColors.success,
                  size: 48,
                ),
              ),
              AppSpacing.gapV16,
              Text(
                'Order Placed Successfully! 🎉',
                style: AppTextStyles.headlineSmall(isDark).copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
              AppSpacing.gapV8,
              Text(
                'Thank you for supporting authentic regional Indian artisans and heritage businesses.',
                textAlign: TextAlign.center,
                style: AppTextStyles.bodyMedium(isDark).copyWith(
                  color: isDark ? AppColors.textMutedDark : AppColors.textSecondaryLight,
                ),
              ),
              AppSpacing.gapV24,

              // Order Summary Card
              AppCard(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Order Number',
                          style: AppTextStyles.bodySmall(isDark).copyWith(
                            color: isDark ? AppColors.textMutedDark : AppColors.textSecondaryLight,
                          ),
                        ),
                        Text(
                          order.orderNumber,
                          style: AppTextStyles.titleMedium(isDark).copyWith(
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                    const Divider(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Estimated Delivery',
                          style: AppTextStyles.bodySmall(isDark).copyWith(
                            color: isDark ? AppColors.textMutedDark : AppColors.textSecondaryLight,
                          ),
                        ),
                        Text(
                          order.estimatedDelivery,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: isDark ? AppColors.primaryLight : AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                    const Divider(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total Paid',
                          style: AppTextStyles.bodySmall(isDark).copyWith(
                            color: isDark ? AppColors.textMutedDark : AppColors.textSecondaryLight,
                          ),
                        ),
                        Text(
                          '₹${order.total.toStringAsFixed(order.total.truncateToDouble() == order.total ? 0 : 2)}',
                          style: AppTextStyles.priceTag(isDark, fontSize: 17),
                        ),
                      ],
                    ),
                    const Divider(height: 24),
                    // Delivery Address
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Shipping To:',
                          style: AppTextStyles.bodySmall(isDark).copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${order.deliveryAddress.fullName}\n${order.deliveryAddress.formattedAddress}',
                          style: AppTextStyles.bodySmall(isDark).copyWith(
                            height: 1.35,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              AppSpacing.gapV16,

              // Ordered Items Preview
              AppCard(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Ordered Items (${order.items.length})',
                      style: AppTextStyles.titleSmall(isDark).copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    AppSpacing.gapV12,
                    ...order.items.map((item) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          children: [
                            AppNetworkImage(
                              imageUrl: item.product.images.isNotEmpty
                                  ? item.product.images.first
                                  : '',
                              width: 44,
                              height: 44,
                              borderRadius: AppRadius.radiusSm,
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.product.name,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12.5,
                                    ),
                                  ),
                                  Text(
                                    'Qty: ${item.quantity}  •  ₹${item.totalPrice.toStringAsFixed(0)}',
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: isDark ? Colors.grey : Colors.black54,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ],
                ),
              ),
              AppSpacing.gapV32,

              // Continue Shopping CTA
              AppButton.primary(
                text: 'Continue Exploring Bazaar',
                width: double.infinity,
                onPressed: () => ShopNavigator.toShop(),
              ),
              AppSpacing.gapV16,
            ],
          ),
        ),
      ),
    );
  }
}
