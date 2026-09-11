import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_bar/app_bar.dart';
import '../../../../shared/widgets/app_button.dart';
import '../controllers/cart_controller.dart';
import '../shop_navigator.dart';
import '../widgets/cart_item_card.dart';
import '../widgets/empty_cart_widget.dart';
import '../widgets/order_summary_widget.dart';

/// Shopping cart screen managing item quantities, promo codes and checkout CTA
class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cartCtrl = Get.isRegistered<CartController>()
        ? Get.find<CartController>()
        : Get.put(CartController(), permanent: true);

    return Scaffold(
      appBar: SewaAppBar(
        titleText: 'Shopping Bag',
        subtitleText: '${cartCtrl.totalUnits} items in bag',
        showBackButton: true,
        actions: [
          Obx(() {
            if (cartCtrl.cartItems.isEmpty) return const SizedBox.shrink();
            return TextButton(
              onPressed: () {
                Get.defaultDialog(
                  title: 'Clear Bag?',
                  middleText: 'Are you sure you want to remove all items?',
                  textConfirm: 'Clear',
                  textCancel: 'Cancel',
                  confirmTextColor: Colors.white,
                  buttonColor: AppColors.error,
                  onConfirm: () {
                    cartCtrl.clearCart();
                    Get.back();
                  },
                );
              },
              child: const Text('Clear All'),
            );
          }),
        ],
      ),
      body: Obx(() {
        if (cartCtrl.cartItems.isEmpty) {
          return EmptyCartWidget(
            onStartShopping: () => Get.back(),
          );
        }

        return SingleChildScrollView(
          padding: AppSpacing.screenPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Items List
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: cartCtrl.cartItems.length,
                separatorBuilder: (context, index) => AppSpacing.gapV12,
                itemBuilder: (context, index) {
                  final item = cartCtrl.cartItems[index];
                  return CartItemCard(
                    item: item,
                    onIncrement: () => cartCtrl.increaseQuantity(item),
                    onDecrement: () => cartCtrl.decreaseQuantity(item),
                    onRemove: () => cartCtrl.removeFromCart(item),
                  );
                },
              ),
              AppSpacing.gapV20,

              // Order Breakdown & Coupon
              OrderSummaryWidget(
                subtotal: cartCtrl.subtotal,
                deliveryFee: cartCtrl.deliveryFee,
                discount: cartCtrl.discount,
                total: cartCtrl.totalAmount,
                appliedPromoCode: cartCtrl.appliedPromoCode.value,
                onApplyPromo: cartCtrl.applyCoupon,
                onRemovePromo: cartCtrl.removeCoupon,
              ),
              const SizedBox(height: 30),
            ],
          ),
        );
      }),
      // Bottom Checkout bar
      bottomNavigationBar: Obx(() {
        if (cartCtrl.cartItems.isEmpty) return const SizedBox.shrink();

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
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total Amount',
                      style: AppTextStyles.bodySmall(isDark).copyWith(
                        color: isDark
                            ? AppColors.textMutedDark
                            : AppColors.textMutedLight,
                        fontSize: 11,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '₹${cartCtrl.totalAmount.toStringAsFixed(cartCtrl.totalAmount.truncateToDouble() == cartCtrl.totalAmount ? 0 : 2)}',
                      style: AppTextStyles.priceTag(isDark, fontSize: 18),
                    ),
                  ],
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: AppButton.primary(
                    text: 'Proceed to Checkout',
                    icon: const Icon(Icons.lock_outline_rounded, size: 18),
                    onPressed: () => ShopNavigator.toSelectAddress(),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
