import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sewasetu/app/theme/app_colors.dart';
import '../controllers/cart_controller.dart';
import '../controllers/shop_navigation_controller.dart';
import 'shop_navigation_item.dart';

/// Premium floating e-commerce navigation bar for the Shop (Bazaar) module
class ShopNavigationBar extends StatelessWidget {
  final ShopNavigationController controller;

  const ShopNavigationBar({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cartCtrl = Get.isRegistered<CartController>()
        ? Get.find<CartController>()
        : Get.put(CartController(), permanent: true);

    final themeAccent = isDark ? AppColors.primaryLight : AppColors.primary;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Container(
          height: 66,
          decoration: BoxDecoration(
            color: isDark
                ? AppColors.surfaceDark.withValues(alpha: 0.96)
                : AppColors.surfaceLight.withValues(alpha: 0.96),
            borderRadius: BorderRadius.circular(33),
            border: Border.all(
              color: isDark
                  ? themeAccent.withValues(alpha: 0.25)
                  : themeAccent.withValues(alpha: 0.16),
              width: 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: themeAccent.withValues(alpha: isDark ? 0.14 : 0.08),
                blurRadius: 18,
                offset: const Offset(0, 6),
                spreadRadius: 1,
              ),
              BoxShadow(
                color: Colors.black.withValues(alpha: isDark ? 0.35 : 0.06),
                blurRadius: 12,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(33),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                child: Obx(() {
                  final currentIndex = controller.currentIndex.value;
                  final cartCount = cartCtrl.itemCount;

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      // 0: Home
                      ShopNavigationItem(
                        outlineIcon: Icons.storefront_outlined,
                        activeIcon: Icons.storefront_rounded,
                        label: 'Home',
                        isSelected: currentIndex == 0,
                        onTap: () => controller.changeTab(0),
                      ),

                      // 1: Categories
                      ShopNavigationItem(
                        outlineIcon: Icons.grid_view_outlined,
                        activeIcon: Icons.grid_view_rounded,
                        label: 'Categories',
                        isSelected: currentIndex == 1,
                        onTap: () => controller.changeTab(1),
                      ),

                      // 2: Cart (Live reactive badge)
                      ShopNavigationItem(
                        outlineIcon: Icons.shopping_bag_outlined,
                        activeIcon: Icons.shopping_bag_rounded,
                        label: 'Cart',
                        isSelected: currentIndex == 2,
                        badgeCount: cartCount,
                        onTap: () => controller.changeTab(2),
                      ),

                      // 3: Orders
                      ShopNavigationItem(
                        outlineIcon: Icons.receipt_long_outlined,
                        activeIcon: Icons.receipt_long_rounded,
                        label: 'Orders',
                        isSelected: currentIndex == 3,
                        onTap: () => controller.changeTab(3),
                      ),
                    ],
                  );
                }),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
