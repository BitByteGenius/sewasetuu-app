import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_radius.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/app_card.dart';
import '../controllers/cart_controller.dart';
import '../controllers/checkout_controller.dart';
import '../shop_navigator.dart';
import '../widgets/order_summary_widget.dart';

/// Checkout screen for delivery address selection, payment method and placing order
class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  late final ShopCheckoutController controller;
  late final CartController cartCtrl;

  @override
  void initState() {
    super.initState();
    controller = Get.isRegistered<ShopCheckoutController>()
        ? Get.find<ShopCheckoutController>()
        : Get.put(ShopCheckoutController());

    cartCtrl = Get.find<CartController>();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Checkout & Payment',
          style: AppTextStyles.titleMedium(isDark).copyWith(
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: AppSpacing.screenPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Delivery Address Section
            Text(
              'Delivery Address',
              style: AppTextStyles.titleMedium(isDark).copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
            AppSpacing.gapV12,
            Obx(() {
              return Column(
                children: List.generate(controller.addresses.length, (index) {
                  final addr = controller.addresses[index];
                  final isSelected = controller.selectedAddressIndex.value == index;

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: AppCard(
                      onTap: () => controller.selectAddress(index),
                      backgroundColor: isSelected
                          ? (isDark
                              ? AppColors.primaryContainerDark.withAlpha(80)
                              : AppColors.primaryContainer.withAlpha(70))
                          : null,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            isSelected
                                ? Icons.radio_button_checked_rounded
                                : Icons.radio_button_off_rounded,
                            color: isSelected
                                ? (isDark
                                    ? AppColors.primaryLight
                                    : AppColors.primary)
                                : Colors.grey,
                            size: 20,
                          ),
                          AppSpacing.gapH12,
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      addr.fullName,
                                      style: AppTextStyles.titleSmall(isDark).copyWith(
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                    if (addr.isDefault)
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
                                        child: const Text(
                                          'DEFAULT',
                                          style: TextStyle(
                                            fontSize: 9.5,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  addr.formattedAddress,
                                  style: AppTextStyles.bodySmall(isDark).copyWith(
                                    height: 1.35,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Phone: ${addr.phone}',
                                  style: AppTextStyles.bodySmall(isDark).copyWith(
                                    color: isDark
                                        ? AppColors.textMutedDark
                                        : AppColors.textSecondaryLight,
                                    fontSize: 11.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              );
            }),
            AppSpacing.gapV16,

            // 2. Payment Method
            Text(
              'Select Payment Method',
              style: AppTextStyles.titleMedium(isDark).copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
            AppSpacing.gapV12,
            Obx(() {
              return AppCard(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: controller.paymentMethods.map((method) {
                    final isSelected =
                        controller.selectedPaymentMethod.value == method;
                    return InkWell(
                      onTap: () => controller.selectPaymentMethod(method),
                      borderRadius: BorderRadius.circular(8),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: Row(
                          children: [
                            Icon(
                              isSelected
                                  ? Icons.radio_button_checked
                                  : Icons.radio_button_unchecked,
                              color: isSelected
                                  ? (isDark ? AppColors.primaryLight : AppColors.primary)
                                  : (isDark ? AppColors.textMutedDark : AppColors.textMutedLight),
                              size: 20,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                method,
                                style: TextStyle(
                                  fontSize: 13.5,
                                  fontWeight: isSelected
                                      ? FontWeight.w700
                                      : FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              );
            }),
            AppSpacing.gapV20,

            // 3. Order Breakdown
            OrderSummaryWidget(
              subtotal: cartCtrl.subtotal,
              deliveryFee: cartCtrl.deliveryFee,
              discount: cartCtrl.discount,
              total: cartCtrl.totalAmount,
              appliedPromoCode: cartCtrl.appliedPromoCode.value,
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
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
          child: Obx(() {
            return AppButton.primary(
              text: 'Place Order • ₹${cartCtrl.totalAmount.toStringAsFixed(cartCtrl.totalAmount.truncateToDouble() == cartCtrl.totalAmount ? 0 : 2)}',
              isLoading: controller.isPlacingOrder.value,
              width: double.infinity,
              onPressed: () async {
                final order = await controller.placeOrder(cartCtrl);
                if (order != null) {
                  ShopNavigator.toOrderSuccess(order);
                }
              },
            );
          }),
        ),
      ),
    );
  }
}
