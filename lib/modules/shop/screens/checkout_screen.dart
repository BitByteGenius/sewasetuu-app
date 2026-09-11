import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_radius.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_bar/app_bar.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/app_card.dart';
import '../../../../shared/widgets/app_network_image.dart';
import '../controllers/cart_controller.dart';
import '../controllers/checkout_controller.dart';
import '../shop_navigator.dart';
import '../widgets/order_summary_widget.dart';

/// Professional checkout screen featuring address summary with Change option,
/// order items preview, payment method selection, and order placement.
class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  late final ShopCheckoutController controller;
  late final CartController cartCtrl;
  bool _isItemsExpanded = false;

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
      appBar: const SewaAppBar(
        titleText: 'Checkout & Payment',
        showBackButton: true,
      ),
      body: SingleChildScrollView(
        padding: AppSpacing.screenPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Checkout Step Indicator (Step 2 Active)
            _buildStepIndicator(isDark: isDark),
            AppSpacing.gapV16,

            // 2. Selected Delivery Address Card
            _buildAddressSection(isDark: isDark),
            AppSpacing.gapV16,

            // 3. Delivery Estimate Banner
            _buildDeliveryEstimateBanner(isDark: isDark),
            AppSpacing.gapV16,

            // 4. Order Items Preview (Collapsible)
            _buildOrderItemsSection(isDark: isDark),
            AppSpacing.gapV20,

            // 5. Payment Method Selector
            _buildPaymentMethodSection(isDark: isDark),
            AppSpacing.gapV20,

            // 6. Order Financial Breakdown
            OrderSummaryWidget(
              subtotal: cartCtrl.subtotal,
              deliveryFee: cartCtrl.deliveryFee,
              discount: cartCtrl.discount,
              total: cartCtrl.totalAmount,
              appliedPromoCode: cartCtrl.appliedPromoCode.value,
            ),
            const SizedBox(height: 16),

            // 7. Security Trust Banner
            _buildSecurityBadge(isDark: isDark),
            const SizedBox(height: 36),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomBar(isDark: isDark),
    );
  }

  Widget _buildStepIndicator({required bool isDark}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.surfaceVariantDark.withAlpha(50)
            : AppColors.surfaceVariantLight.withAlpha(60),
        borderRadius: AppRadius.radiusMd,
      ),
      child: Row(
        children: [
          // Step 1: Address (Completed)
          Container(
            width: 24,
            height: 24,
            decoration: const BoxDecoration(
              color: Colors.teal,
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Icon(Icons.check_rounded, color: Colors.white, size: 16),
            ),
          ),
          const SizedBox(width: 8),
          const Text(
            'Address',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: Colors.teal,
            ),
          ),
          Expanded(
            child: Container(
              height: 1.5,
              margin: const EdgeInsets.symmetric(horizontal: 12),
              color: Colors.teal.withAlpha(120),
            ),
          ),
          // Step 2: Payment & Order (Active)
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: isDark ? AppColors.primaryLight : AppColors.primary,
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Text(
                '2',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 12,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            'Payment & Order',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w800,
              color: isDark ? AppColors.primaryLight : AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddressSection({required bool isDark}) {
    return Obx(() {
      final addr = controller.currentAddress;

      if (addr == null) {
        return AppCard(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.warning_amber_rounded, color: Colors.amber, size: 22),
                  const SizedBox(width: 8),
                  Text(
                    'No Delivery Address Selected',
                    style: AppTextStyles.titleSmall(isDark).copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                'Please add or select a delivery address to place your order.',
                style: AppTextStyles.bodySmall(isDark),
              ),
              const SizedBox(height: 12),
              AppButton.primary(
                text: 'Add Delivery Address',
                icon: const Icon(Icons.add_location_alt_rounded, size: 18),
                onPressed: () => ShopNavigator.toSelectAddress(),
              ),
            ],
          ),
        );
      }

      return AppCard(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: (isDark ? AppColors.primaryLight : AppColors.primary)
                            .withAlpha(30),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.location_on_rounded,
                        color: isDark ? AppColors.primaryLight : AppColors.primary,
                        size: 18,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Delivering To',
                      style: AppTextStyles.titleSmall(isDark).copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(width: 8),
                    _buildAddressTypeBadge(isDark: isDark, type: addr.type),
                  ],
                ),
                // Change Address Button
                TextButton.icon(
                  onPressed: () => ShopNavigator.toSelectAddress(),
                  icon: const Icon(Icons.edit_location_alt_outlined, size: 16),
                  label: const Text('Change'),
                  style: TextButton.styleFrom(
                    foregroundColor:
                        isDark ? AppColors.primaryLight : AppColors.primary,
                    textStyle: const TextStyle(fontWeight: FontWeight.w800),
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                  ),
                ),
              ],
            ),
            const Divider(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        addr.fullName,
                        style: AppTextStyles.titleSmall(isDark).copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        addr.formattedAddress,
                        style: AppTextStyles.bodyMedium(isDark).copyWith(
                          height: 1.35,
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Icon(
                            Icons.phone_outlined,
                            size: 14,
                            color: isDark
                                ? AppColors.textMutedDark
                                : AppColors.textSecondaryLight,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            addr.phone,
                            style: AppTextStyles.bodySmall(isDark).copyWith(
                              fontWeight: FontWeight.w600,
                              color: isDark
                                  ? AppColors.textMutedDark
                                  : AppColors.textSecondaryLight,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }

  Widget _buildAddressTypeBadge({required bool isDark, required String type}) {
    IconData icon;
    switch (type.toLowerCase()) {
      case 'work':
        icon = Icons.business_rounded;
        break;
      case 'other':
        icon = Icons.location_on_rounded;
        break;
      default:
        icon = Icons.home_rounded;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceVariantDark : AppColors.surfaceVariantLight,
        borderRadius: AppRadius.radiusSm,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 11, color: isDark ? AppColors.primaryLight : AppColors.primary),
          const SizedBox(width: 3),
          Text(
            type.toUpperCase(),
            style: const TextStyle(fontSize: 9.5, fontWeight: FontWeight.w800),
          ),
        ],
      ),
    );
  }

  Widget _buildDeliveryEstimateBanner({required bool isDark}) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.primaryContainerDark.withAlpha(40)
            : AppColors.primaryContainer.withAlpha(40),
        borderRadius: AppRadius.radiusMd,
        border: Border.all(
          color: (isDark ? AppColors.primaryLight : AppColors.primary).withAlpha(50),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: isDark ? AppColors.primaryLight : AppColors.primary,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.local_shipping_rounded,
              color: Colors.white,
              size: 16,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Standard Artisan Delivery (3 - 5 Days)',
                  style: AppTextStyles.labelLarge(isDark).copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text(
                  'Carefully packaged & insured directly from the makers',
                  style: AppTextStyles.bodySmall(isDark).copyWith(
                    fontSize: 11.5,
                    color: isDark
                        ? AppColors.textMutedDark
                        : AppColors.textSecondaryLight,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderItemsSection({required bool isDark}) {
    final items = cartCtrl.cartItems;

    return AppCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              setState(() {
                _isItemsExpanded = !_isItemsExpanded;
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.shopping_bag_outlined, size: 18),
                    const SizedBox(width: 8),
                    Text(
                      'Items in Order (${cartCtrl.totalUnits})',
                      style: AppTextStyles.titleSmall(isDark).copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      _isItemsExpanded ? 'Hide' : 'View Details',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: isDark ? AppColors.primaryLight : AppColors.primary,
                      ),
                    ),
                    Icon(
                      _isItemsExpanded
                          ? Icons.keyboard_arrow_up_rounded
                          : Icons.keyboard_arrow_down_rounded,
                      size: 18,
                      color: isDark ? AppColors.primaryLight : AppColors.primary,
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (_isItemsExpanded) ...[
            const Divider(height: 18),
            ...items.map((item) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: SizedBox(
                        width: 48,
                        height: 48,
                        child: AppNetworkImage(
                          imageUrl: item.product.images.isNotEmpty
                              ? item.product.images.first
                              : '',
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.product.name,
                            style: AppTextStyles.bodyMedium(isDark).copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          if (item.selectedVariant != null)
                            Text(
                              item.selectedVariant!.name,
                              style: AppTextStyles.bodySmall(isDark).copyWith(
                                color: isDark
                                    ? AppColors.textMutedDark
                                    : AppColors.textSecondaryLight,
                                fontSize: 11,
                              ),
                            ),
                          Text(
                            'Qty: ${item.quantity}',
                            style: AppTextStyles.bodySmall(isDark).copyWith(
                              fontSize: 11.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      '₹${item.totalPrice.toStringAsFixed(0)}',
                      style: AppTextStyles.titleSmall(isDark).copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              );
            }),
          ] else ...[
            const SizedBox(height: 10),
            // Horizontal preview avatars
            SizedBox(
              height: 42,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: items.length,
                separatorBuilder: (context, index) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final item = items[index];
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: SizedBox(
                      width: 42,
                      height: 42,
                      child: AppNetworkImage(
                        imageUrl: item.product.images.isNotEmpty
                            ? item.product.images.first
                            : '',
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildPaymentMethodSection({required bool isDark}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Payment Method',
          style: AppTextStyles.titleMedium(isDark).copyWith(
            fontWeight: FontWeight.w800,
          ),
        ),
        AppSpacing.gapV12,
        Obx(() {
          return AppCard(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Column(
              children: controller.paymentMethods.map((method) {
                final isSelected = controller.selectedPaymentMethod.value == method;

                IconData icon;
                String subtitle;
                if (method.contains('UPI')) {
                  icon = Icons.qr_code_rounded;
                  subtitle = 'Google Pay, PhonePe, Paytm, BHIM';
                } else if (method.contains('Card')) {
                  icon = Icons.credit_card_rounded;
                  subtitle = 'Visa, Mastercard, RuPay & more';
                } else if (method.contains('Net Banking')) {
                  icon = Icons.account_balance_rounded;
                  subtitle = 'All major Indian banks';
                } else {
                  icon = Icons.local_atm_rounded;
                  subtitle = 'Pay cash or UPI upon delivery';
                }

                return InkWell(
                  onTap: () => controller.selectPaymentMethod(method),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? (isDark
                              ? AppColors.primaryLight.withAlpha(20)
                              : AppColors.primary.withAlpha(15))
                          : Colors.transparent,
                    ),
                    child: Row(
                      children: [
                        Icon(
                          isSelected
                              ? Icons.radio_button_checked
                              : Icons.radio_button_unchecked,
                          color: isSelected
                              ? (isDark
                                  ? AppColors.primaryLight
                                  : AppColors.primary)
                              : (isDark
                                  ? AppColors.textMutedDark
                                  : AppColors.textMutedLight),
                          size: 20,
                        ),
                        const SizedBox(width: 12),
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: isDark
                                ? AppColors.surfaceVariantDark
                                : AppColors.surfaceVariantLight,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            icon,
                            size: 18,
                            color: isSelected
                                ? (isDark
                                    ? AppColors.primaryLight
                                    : AppColors.primary)
                                : (isDark
                                    ? AppColors.textPrimaryDark
                                    : AppColors.textPrimaryLight),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                method,
                                style: TextStyle(
                                  fontSize: 13.5,
                                  fontWeight: isSelected
                                      ? FontWeight.w800
                                      : FontWeight.w600,
                                ),
                              ),
                              Text(
                                subtitle,
                                style: AppTextStyles.bodySmall(isDark).copyWith(
                                  fontSize: 11,
                                  color: isDark
                                      ? AppColors.textMutedDark
                                      : AppColors.textSecondaryLight,
                                ),
                              ),
                            ],
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
      ],
    );
  }

  Widget _buildSecurityBadge({required bool isDark}) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.verified_user_rounded,
            size: 16,
            color: isDark ? AppColors.primaryLight : AppColors.primary,
          ),
          const SizedBox(width: 6),
          Text(
            '100% Safe & Secure Payments | SSL Encrypted',
            style: AppTextStyles.bodySmall(isDark).copyWith(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: isDark ? AppColors.textMutedDark : AppColors.textSecondaryLight,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar({required bool isDark}) {
    return Container(
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
          final totalAmountStr =
              cartCtrl.totalAmount.toStringAsFixed(
                  cartCtrl.totalAmount.truncateToDouble() == cartCtrl.totalAmount ? 0 : 2);

          return Row(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'TOTAL PAYABLE',
                    style: AppTextStyles.labelSmall(isDark).copyWith(
                      letterSpacing: 0.8,
                      color: isDark ? AppColors.textMutedDark : AppColors.textMutedLight,
                    ),
                  ),
                  Text(
                    '₹$totalAmountStr',
                    style: AppTextStyles.priceTag(isDark, fontSize: 18),
                  ),
                ],
              ),
              const SizedBox(width: 20),
              Expanded(
                child: AppButton.primary(
                  text: 'Place Order',
                  icon: const Icon(Icons.lock_outline_rounded, size: 18),
                  isLoading: controller.isPlacingOrder.value,
                  onPressed: () async {
                    if (controller.currentAddress == null) {
                      ShopNavigator.toSelectAddress();
                      return;
                    }

                    final order = await controller.placeOrder(cartCtrl);
                    if (order != null) {
                      ShopNavigator.toOrderSuccess(order);
                    }
                  },
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
