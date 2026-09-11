import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_radius.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_bar/app_bar.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/app_card.dart';
import '../controllers/checkout_controller.dart';
import '../models/address_model.dart';
import '../shop_navigator.dart';

/// Dedicated screen for selecting, adding, and deleting delivery addresses
class SelectAddressScreen extends StatefulWidget {
  const SelectAddressScreen({super.key});

  @override
  State<SelectAddressScreen> createState() => _SelectAddressScreenState();
}

class _SelectAddressScreenState extends State<SelectAddressScreen> {
  late final ShopCheckoutController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.isRegistered<ShopCheckoutController>()
        ? Get.find<ShopCheckoutController>()
        : Get.put(ShopCheckoutController());
  }

  void _confirmDeleteAddress(BuildContext context, ShopAddressModel address) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    Get.dialog(
      AlertDialog(
        backgroundColor: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
        shape: RoundedRectangleBorder(borderRadius: AppRadius.radiusLg),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.red.withAlpha(25),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.delete_outline_rounded, color: Colors.red, size: 22),
            ),
            const SizedBox(width: 12),
            Text(
              'Delete Address?',
              style: AppTextStyles.titleMedium(isDark).copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
        content: Text(
          'Are you sure you want to remove this delivery address?\n\n"${address.fullName}, ${address.city}"',
          style: AppTextStyles.bodyMedium(isDark).copyWith(
            height: 1.4,
          ),
        ),
        actionsPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              'Cancel',
              style: TextStyle(
                color: isDark ? AppColors.textMutedDark : AppColors.textMutedLight,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () {
              Get.back();
              final success = controller.deleteAddress(address.id);
              if (success) {
                Get.snackbar(
                  'Address Deleted',
                  'The delivery address was removed.',
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.black.withAlpha(200),
                  colorText: Colors.white,
                  margin: const EdgeInsets.all(16),
                  borderRadius: 12,
                  duration: const Duration(seconds: 2),
                );
              }
            },
            child: const Text('Delete', style: TextStyle(fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: const SewaAppBar(
        titleText: 'Delivery Address',
        showBackButton: true,
      ),
      body: Obx(() {
        return SingleChildScrollView(
          padding: AppSpacing.screenPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Checkout Step Indicator
              _buildStepIndicator(isDark: isDark),
              AppSpacing.gapV16,

              // 2. Add New Address Button
              InkWell(
                onTap: () => ShopNavigator.toAddAddress(),
                borderRadius: AppRadius.radiusLg,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: isDark
                        ? AppColors.primaryContainerDark.withAlpha(60)
                        : AppColors.primaryContainer.withAlpha(50),
                    borderRadius: AppRadius.radiusLg,
                    border: Border.all(
                      color: isDark ? AppColors.primaryLight : AppColors.primary,
                      width: 1.2,
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
                          Icons.add_rounded,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      AppSpacing.gapH12,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Add New Address',
                              style: AppTextStyles.titleSmall(isDark).copyWith(
                                fontWeight: FontWeight.w800,
                                color: isDark ? AppColors.primaryLight : AppColors.primary,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'Ship to a new home, office, or family location',
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
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 14,
                        color: isDark ? AppColors.primaryLight : AppColors.primary,
                      ),
                    ],
                  ),
                ),
              ),
              AppSpacing.gapV20,

              // 3. Saved Addresses Section Header
              Text(
                'Saved Addresses (${controller.addresses.length})',
                style: AppTextStyles.titleMedium(isDark).copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
              AppSpacing.gapV12,

              // 4. Saved Addresses List / Empty State
              if (controller.addresses.isEmpty)
                _buildEmptyAddressState(isDark: isDark)
              else
                ...List.generate(controller.addresses.length, (index) {
                  final addr = controller.addresses[index];
                  final isSelected = controller.selectedAddressIndex.value == index;

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _buildAddressCard(
                      context: context,
                      isDark: isDark,
                      address: addr,
                      isSelected: isSelected,
                      onSelect: () => controller.selectAddress(index),
                      onDelete: () => _confirmDeleteAddress(context, addr),
                    ),
                  );
                }),
              const SizedBox(height: 30),
            ],
          ),
        );
      }),
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
            final hasAddress = controller.hasAddress;

            return AppButton.primary(
              text: hasAddress
                  ? 'Deliver to this Address'
                  : 'Add Address to Continue',
              icon: Icon(
                hasAddress
                    ? Icons.check_circle_rounded
                    : Icons.add_location_alt_rounded,
                size: 20,
              ),
              width: double.infinity,
              onPressed: () {
                if (!hasAddress) {
                  ShopNavigator.toAddAddress();
                } else {
                  // Navigate to Checkout
                  ShopNavigator.toCheckout();
                }
              },
            );
          }),
        ),
      ),
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
          // Step 1: Address (Active)
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: isDark ? AppColors.primaryLight : AppColors.primary,
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Text(
                '1',
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
            'Address',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w800,
              color: isDark ? AppColors.primaryLight : AppColors.primary,
            ),
          ),
          Expanded(
            child: Container(
              height: 1.5,
              margin: const EdgeInsets.symmetric(horizontal: 12),
              color: isDark ? Colors.white24 : Colors.black12,
            ),
          ),
          // Step 2: Payment
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: isDark ? Colors.white12 : Colors.black12,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '2',
                style: TextStyle(
                  color: isDark ? Colors.white60 : Colors.black54,
                  fontWeight: FontWeight.w700,
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
              fontWeight: FontWeight.w500,
              color: isDark ? Colors.white60 : Colors.black54,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyAddressState({required bool isDark}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 20),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.surfaceVariantDark.withAlpha(30)
            : AppColors.surfaceVariantLight.withAlpha(40),
        borderRadius: AppRadius.radiusLg,
        border: Border.all(
          color: isDark ? AppColors.borderDark : AppColors.borderLight,
        ),
      ),
      child: Column(
        children: [
          Icon(
            Icons.location_off_outlined,
            size: 48,
            color: isDark ? AppColors.textMutedDark : AppColors.textMutedLight,
          ),
          AppSpacing.gapV12,
          Text(
            'No Saved Addresses Found',
            style: AppTextStyles.titleSmall(isDark).copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Please add a delivery address to proceed with placing your order.',
            textAlign: TextAlign.center,
            style: AppTextStyles.bodySmall(isDark).copyWith(
              color: isDark ? AppColors.textMutedDark : AppColors.textMutedLight,
            ),
          ),
          AppSpacing.gapV16,
          AppButton.primary(
            text: 'Add First Address',
            icon: const Icon(Icons.add_location_alt_rounded, size: 18),
            onPressed: () => ShopNavigator.toAddAddress(),
          ),
        ],
      ),
    );
  }

  Widget _buildAddressCard({
    required BuildContext context,
    required bool isDark,
    required ShopAddressModel address,
    required bool isSelected,
    required VoidCallback onSelect,
    required VoidCallback onDelete,
  }) {
    IconData typeIcon;
    switch (address.type.toLowerCase()) {
      case 'work':
        typeIcon = Icons.business_rounded;
        break;
      case 'other':
        typeIcon = Icons.location_on_rounded;
        break;
      default:
        typeIcon = Icons.home_rounded;
    }

    return AppCard(
      onTap: onSelect,
      backgroundColor: isSelected
          ? (isDark
              ? AppColors.primaryContainerDark.withAlpha(70)
              : AppColors.primaryContainer.withAlpha(60))
          : null,
      borderColor: isSelected
          ? (isDark ? AppColors.primaryLight : AppColors.primary)
          : null,
      borderWidth: isSelected ? 1.5 : 1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Radio selection button
              Icon(
                isSelected
                    ? Icons.radio_button_checked_rounded
                    : Icons.radio_button_off_rounded,
                color: isSelected
                    ? (isDark ? AppColors.primaryLight : AppColors.primary)
                    : Colors.grey,
                size: 22,
              ),
              const SizedBox(width: 10),

              // Full Name
              Expanded(
                child: Text(
                  address.fullName,
                  style: AppTextStyles.titleSmall(isDark).copyWith(
                    fontWeight: FontWeight.w800,
                    fontSize: 15,
                  ),
                ),
              ),

              // Address Type Badge (Home / Work)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: isDark
                      ? AppColors.surfaceVariantDark
                      : AppColors.surfaceVariantLight,
                  borderRadius: AppRadius.radiusSm,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      typeIcon,
                      size: 12,
                      color: isDark
                          ? AppColors.primaryLight
                          : AppColors.primary,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      address.type.toUpperCase(),
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                        color: isDark
                            ? AppColors.textPrimaryDark
                            : AppColors.textPrimaryLight,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 6),

              // Default Badge
              if (address.isDefault) ...[
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                  decoration: BoxDecoration(
                    color: Colors.teal.withAlpha(30),
                    borderRadius: AppRadius.radiusSm,
                    border: Border.all(color: Colors.teal.withAlpha(80)),
                  ),
                  child: const Text(
                    'DEFAULT',
                    style: TextStyle(
                      fontSize: 9.5,
                      fontWeight: FontWeight.w800,
                      color: Colors.teal,
                    ),
                  ),
                ),
                const SizedBox(width: 4),
              ],

              // Delete Button
              IconButton(
                icon: const Icon(Icons.delete_outline_rounded, size: 20),
                color: Colors.red.shade400,
                tooltip: 'Delete address',
                constraints: const BoxConstraints(),
                padding: const EdgeInsets.all(4),
                onPressed: onDelete,
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Street Address & Landmark
          Padding(
            padding: const EdgeInsets.only(left: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  address.formattedAddress,
                  style: AppTextStyles.bodyMedium(isDark).copyWith(
                    height: 1.4,
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
                      address.phone,
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
    );
  }
}
