import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sewasetu/app/theme/app_colors.dart';
import 'package:sewasetu/shared/widgets/app_bar/sewa_app_bar.dart';
import 'package:sewasetu/shared/widgets/app_network_image.dart';
import '../home_cleaning/controller/my_cart_controller.dart';
import '../home_cleaning/models/kitchen_cleaning_model.dart';

/// Comprehensive My Cart UI matching the exact reference mockup.
/// Connected to MyCartController logic with native sticky bottom bar & separate add-on cards.
class MyCartWidgets extends StatelessWidget {
  const MyCartWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final controller = Get.isRegistered<MyCartController>()
        ? Get.find<MyCartController>()
        : Get.put(MyCartController());

    return Obx(() {
      final cartItems = controller.cartItems;
      final hasCartItems = controller.hasCartItems;

      return Scaffold(
        backgroundColor:
            isDark ? AppColors.backgroundDark : const Color(0xFFF1F3F9),
        appBar: const SewaAppBar(
          titleText: 'My Cart',
          showBackButton: true,
        ),
        body: !hasCartItems
            ? _buildEmptyCartView(context, isDark)
            : SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 1. Cart Items List
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: cartItems.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final item = cartItems[index];
                        return _buildCartItemCard(
                            context, controller, item, isDark);
                      },
                    ),

                    const SizedBox(height: 24),

                    // 2. Recommended Add-ons Section (Separate cards)
                    _buildRecommendedAddonsSection(context, controller, isDark),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
        bottomNavigationBar: hasCartItems
            ? _buildStickyBottomCheckoutBar(context, controller, isDark)
            : null,
      );
    });
  }

  Widget _buildCartItemCard(
    BuildContext context,
    MyCartController controller,
    KitchenCartItem item,
    bool isDark,
  ) {
    final service = item.service;
    final isPackageType =
        service.originalPrice != null || item.selectedOption != null;

    final cardBgColor = isDark ? AppColors.surfaceDark : Colors.white;
    final cardBorderColor =
        isDark ? AppColors.borderDark : const Color(0xFFE2E8F0);
    final titleTextColor =
        isDark ? AppColors.textPrimaryDark : const Color(0xFF1E293B);
    final subtitleTextColor =
        isDark ? AppColors.textMutedDark : const Color(0xFF64748B);
    final priceTextColor =
        isDark ? AppColors.textPrimaryDark : const Color(0xFF0F172A);
    final strikethroughColor =
        isDark ? AppColors.textMutedDark : const Color(0xFF94A3B8);
    final actionBgColor =
        isDark ? const Color(0xFF132338) : const Color(0xFFE6F4F1);
    final actionTextColor =
        isDark ? const Color(0xFF14B8A6) : const Color(0xFF0F766E);

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: cardBgColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: cardBorderColor, width: 1.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.25 : 0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left: Image & Badge overlay
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 68,
                height: 68,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: isDark
                      ? AppColors.surfaceVariantDark
                      : const Color(0xFFF8FAFC),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: AppNetworkImage(
                    imageUrl: service.imageUrl ?? '',
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              // Top badge tag (e.g. Essential ★ / Machine Clean)
              if (service.badgeText != null)
                Positioned(
                  top: -8,
                  left: -4,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 2.5),
                    decoration: BoxDecoration(
                      color: service.badgeText!.contains('Machine')
                          ? (isDark
                              ? const Color(0xFF581C87)
                              : const Color(0xFFF3E8FF))
                          : const Color(0xFFFEF3C7),
                      borderRadius: BorderRadius.circular(6),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.12),
                          blurRadius: 3,
                        ),
                      ],
                    ),
                    child: Text(
                      service.badgeText!,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 9.5,
                        fontWeight: FontWeight.w800,
                        color: service.badgeText!.contains('Machine')
                            ? (isDark
                                ? const Color(0xFFF3E8FF)
                                : const Color(0xFF6B21A8))
                            : const Color(0xFF92400E),
                      ),
                    ),
                  ),
                ),
            ],
          ),

          const SizedBox(width: 14),

          // Middle: Title, Strikethrough Price / Price, Subtitle
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  service.title,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: titleTextColor,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),

                // Price Row (Strikethrough original price + Bold price)
                Row(
                  children: [
                    if (service.originalPrice != null) ...[
                      Text(
                        '₹${service.originalPrice!.toStringAsFixed(0)}',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: strikethroughColor,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      const SizedBox(width: 6),
                    ],
                    Text(
                      '₹${item.unitPrice.toStringAsFixed(0)}',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 16.5,
                        fontWeight: FontWeight.w900,
                        color: priceTextColor,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 4),

                // Selected Option / Subtitle
                if (item.selectedOption?.name != null ||
                    service.description != null)
                  Text(
                    item.selectedOption?.name ?? service.description ?? '',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: subtitleTextColor,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
              ],
            ),
          ),

          const SizedBox(width: 8),

          // Right: REMOVE button OR [- 1 +] Stepper Action
          if (isPackageType && item.quantity == 1)
            Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: () {
                  HapticFeedback.lightImpact();
                  controller.removeItemCompletely(service.id);
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    color: actionBgColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'REMOVE',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 11.5,
                      fontWeight: FontWeight.w800,
                      color: actionTextColor,
                      letterSpacing: 0.2,
                    ),
                  ),
                ),
              ),
            )
          else
            Container(
              height: 34,
              decoration: BoxDecoration(
                color: actionBgColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: () {
                      HapticFeedback.lightImpact();
                      controller.decrementItem(service.id);
                    },
                    behavior: HitTestBehavior.opaque,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 6),
                      child: Icon(Icons.remove,
                          size: 15, color: actionTextColor),
                    ),
                  ),
                  Text(
                    '${item.quantity}',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 13.5,
                      fontWeight: FontWeight.w800,
                      color: priceTextColor,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      HapticFeedback.lightImpact();
                      controller.addItem(service, item.selectedOption);
                    },
                    behavior: HitTestBehavior.opaque,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 6),
                      child: Icon(Icons.add, size: 15, color: actionTextColor),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildRecommendedAddonsSection(
    BuildContext context,
    MyCartController controller,
    bool isDark,
  ) {
    final addons = controller.recommendedAddons;
    if (addons.isEmpty) return const SizedBox.shrink();

    final sectionTitleColor =
        isDark ? AppColors.textPrimaryDark : const Color(0xFF1E293B);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recommended Add-ons',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 16,
            fontWeight: FontWeight.w800,
            color: sectionTitleColor,
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 185,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: addons.length,
            separatorBuilder: (context, index) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final addon = addons[index];
              return _buildAddonCard(context, controller, addon, isDark);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildAddonCard(
    BuildContext context,
    MyCartController controller,
    KitchenCleaningServiceItem addon,
    bool isDark,
  ) {
    final isInCart = controller.isItemInCart(addon.id);

    final cardBgColor = isDark ? AppColors.surfaceDark : Colors.white;
    final cardBorderColor =
        isDark ? AppColors.borderDark : const Color(0xFFE2E8F0);
    final titleColor =
        isDark ? AppColors.textPrimaryDark : const Color(0xFF334155);
    final priceColor =
        isDark ? AppColors.textPrimaryDark : const Color(0xFF0F172A);
    final btnBgColor = isInCart
        ? const Color(0xFF0F766E)
        : (isDark ? const Color(0xFF132338) : const Color(0xFFE6F4F1));
    final btnTextColor = isInCart
        ? Colors.white
        : (isDark ? const Color(0xFF14B8A6) : const Color(0xFF0F766E));

    return Container(
      width: 130,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: cardBgColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: cardBorderColor, width: 1.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.25 : 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image with Floating ADD / ADDED Button
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: 90,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: isDark
                      ? AppColors.surfaceVariantDark
                      : const Color(0xFFF8FAFC),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: AppNetworkImage(
                    imageUrl: addon.imageUrl ?? '',
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              // Floating ADD / ADDED Button
              Positioned(
                bottom: 6,
                right: 6,
                child: GestureDetector(
                  onTap: () {
                    HapticFeedback.lightImpact();
                    if (isInCart) {
                      controller.decrementItem(addon.id);
                    } else {
                      controller.addItem(addon);
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 9, vertical: 4),
                    decoration: BoxDecoration(
                      color: btnBgColor,
                      borderRadius: BorderRadius.circular(7),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.12),
                          blurRadius: 4,
                          offset: const Offset(0, 1.5),
                        ),
                      ],
                    ),
                    child: Text(
                      isInCart ? 'ADDED' : 'ADD',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 10.5,
                        fontWeight: FontWeight.w800,
                        color: btnTextColor,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          // Add-on Title
          Text(
            addon.title,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              height: 1.25,
              color: titleColor,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),

          const Spacer(),

          // Price
          Text(
            '₹${addon.price.toStringAsFixed(0)}',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14.5,
              fontWeight: FontWeight.w900,
              color: priceColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStickyBottomCheckoutBar(
    BuildContext context,
    MyCartController controller,
    bool isDark,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : Colors.white,
        border: Border(
          top: BorderSide(
            color: isDark ? AppColors.borderDark : const Color(0xFFE2E8F0),
            width: 1.0,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.08),
            blurRadius: 12,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Total Amount
              Text(
                '₹${controller.totalCartPrice.toStringAsFixed(0)}',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                  color: isDark ? AppColors.textPrimaryDark : const Color(0xFF0F172A),
                ),
              ),

              // Select Address CTA Button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0F766E), // Emerald Teal CTA
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  controller.proceedToAddressSelection();
                },
                child: Text(
                  'Select Address',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyCartView(BuildContext context, bool isDark) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF132338) : const Color(0xFFE6F4F1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.shopping_cart_outlined,
                size: 64,
                color: isDark ? const Color(0xFF14B8A6) : const Color(0xFF0F766E),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Your cart is empty',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: isDark ? AppColors.textPrimaryDark : const Color(0xFF1E293B),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Looks like you haven\'t added any services yet.',
              textAlign: TextAlign.center,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 14,
                color: isDark ? AppColors.textMutedDark : const Color(0xFF64748B),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0F766E),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () => Get.back(),
              child: Text(
                'Browse Services',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 14.5,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}