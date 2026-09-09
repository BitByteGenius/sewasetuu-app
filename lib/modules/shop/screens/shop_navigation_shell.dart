import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sewasetu/app/theme/app_colors.dart';
import 'package:sewasetu/app/theme/app_radius.dart';
import 'package:sewasetu/app/theme/app_spacing.dart';
import 'package:sewasetu/app/theme/app_text_styles.dart';
import 'package:sewasetu/shared/widgets/app_button.dart';
import 'package:sewasetu/shared/widgets/app_card.dart';
import 'package:sewasetu/shared/widgets/app_empty_state.dart';
import '../controllers/shop_navigation_controller.dart';
import '../widgets/shop_navigation_bar.dart';
import 'cart_screen.dart';
import 'states_screen.dart';

/// Navigation shell hosting the 4 Shop tabs with the floating e-commerce navigation bar
class ShopNavigationShell extends StatelessWidget {
  final Widget discoverView;

  const ShopNavigationShell({
    super.key,
    required this.discoverView,
  });

  @override
  Widget build(BuildContext context) {
    final navCtrl = Get.isRegistered<ShopNavigationController>()
        ? Get.find<ShopNavigationController>()
        : Get.put(ShopNavigationController());

    return Scaffold(
      body: Stack(
        children: [
          // IndexedStack maintains state of each Shop tab
          Obx(() {
            return IndexedStack(
              index: navCtrl.currentIndex.value,
              children: [
                // 0: Discover / Bazaar Feed
                discoverView,

                // 1: Categories / States Hub
                const StatesScreen(),

                // 2: Shopping Bag
                const CartScreen(),

                // 3: Orders
                _ShopOrdersTabView(navCtrl: navCtrl),
              ],
            );
          }),

          // Floating Bottom Navigation Bar
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: ShopNavigationBar(controller: navCtrl),
          ),
        ],
      ),
    );
  }
}

/// Dedicated Orders Tab inside Shop module
class _ShopOrdersTabView extends StatelessWidget {
  final ShopNavigationController navCtrl;

  const _ShopOrdersTabView({required this.navCtrl});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
        title: Text(
          'My Orders',
          style: AppTextStyles.headlineSmall(isDark).copyWith(
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 96),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Active orders preview card
            AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFF6D00).withValues(alpha: 0.12),
                          borderRadius: AppRadius.radiusPill,
                        ),
                        child: const Text(
                          'In Transit',
                          style: TextStyle(
                            color: Color(0xFFFF6D00),
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Text(
                        'Order #ORD-7821',
                        style: AppTextStyles.bodySmall(isDark).copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  AppSpacing.gapV12,
                  Text(
                    'Kashmiri Pashmina Shawl (Hand-woven)',
                    style: AppTextStyles.titleMedium(isDark).copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Artisan Cooperative • Srinagar, Kashmir',
                    style: AppTextStyles.bodySmall(isDark).copyWith(
                      color: isDark ? AppColors.textMutedDark : AppColors.textSecondaryLight,
                    ),
                  ),
                  AppSpacing.gapV12,
                  const Divider(height: 1),
                  AppSpacing.gapV12,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Estimated Arrival',
                            style: AppTextStyles.labelSmall(isDark),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'Friday, 14 Oct',
                            style: AppTextStyles.bodyMedium(isDark).copyWith(
                              fontWeight: FontWeight.w700,
                              color: AppColors.success,
                            ),
                          ),
                        ],
                      ),
                      AppButton(
                        text: 'Track Order',
                        variant: AppButtonVariant.outline,
                        size: AppButtonSize.small,
                        onPressed: () {
                          Get.snackbar(
                            'Order Tracking',
                            'Package is sorted at Regional Sorting Center, Guwahati.',
                            snackPosition: SnackPosition.BOTTOM,
                            margin: const EdgeInsets.only(bottom: 80, left: 16, right: 16),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),

            AppSpacing.gapV24,

            Text(
              'Past Orders',
              style: AppTextStyles.titleMedium(isDark).copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),

            AppSpacing.gapV12,

            // Empty state for past orders
            AppEmptyState(
              icon: Icons.receipt_long_outlined,
              title: 'No Older Orders',
              description: 'Your previous artisan purchases and craft receipts will appear here.',
              actionText: 'Explore More Crafts',
              onAction: () => navCtrl.toHome(),
            ),
          ],
        ),
      ),
    );
  }
}
