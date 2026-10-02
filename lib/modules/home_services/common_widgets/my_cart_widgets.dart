import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sewasetu/shared/widgets/app_bar/sewa_app_bar.dart';
import 'package:sewasetu/shared/widgets/app_network_image.dart';
import '../home_cleaning/controller/kitchen_cleaning_controller.dart';
import '../home_cleaning/data/kitchen_cleaning_data.dart';
import '../home_cleaning/models/kitchen_cleaning_model.dart';

/// Comprehensive My Cart UI matching the exact reference mockup (media_1790961147895.jpg).
/// Connected to the reactive KitchenCleaningController state architecture.
class MyCartWidgets extends StatelessWidget {
  const MyCartWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.isRegistered<KitchenCleaningController>()
        ? Get.find<KitchenCleaningController>()
        : Get.put(KitchenCleaningController());

    return Scaffold(
      backgroundColor: const Color(0xFFF1F3F9), // Light lavender-gray background
      appBar: SewaAppBar(
        titleText: 'My Cart',
        showBackButton: true,
      ),
      body: Obx(() {
        final cartItems = controller.cartItems;

        if (cartItems.isEmpty) {
          return _buildEmptyCartView(context);
        }

        return Stack(
          children: [
            // Scrollable Content View
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 120),
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
                      return _buildCartItemCard(context, controller, item);
                    },
                  ),

                  const SizedBox(height: 24),

                  // 2. Recommended Add-ons Section
                  _buildRecommendedAddonsSection(context, controller),

                  const SizedBox(height: 24),
                ],
              ),
            ),

            // 3. Fixed Bottom Checkout Bar
            _buildBottomCheckoutBar(context, controller),
          ],
        );
      }),
    );
  }

  Widget _buildCartItemCard(
    BuildContext context,
    KitchenCleaningController controller,
    KitchenCartItem item,
  ) {
    final service = item.service;
    final isPackageType =
        service.originalPrice != null || item.selectedOption != null;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
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
                  color: const Color(0xFFF8FAFC),
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
                          ? const Color(0xFFF3E8FF)
                          : const Color(0xFFFEF3C7),
                      borderRadius: BorderRadius.circular(6),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.08),
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
                            ? const Color(0xFF6B21A8)
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
                    color: const Color(0xFF1E293B),
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
                          color: const Color(0xFF94A3B8),
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
                        color: const Color(0xFF0F172A),
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
                      color: const Color(0xFF64748B),
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
                    color: const Color(0xFFE6F4F1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'REMOVE',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 11.5,
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFF0F766E),
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
                color: const Color(0xFFE6F4F1),
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
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                      child: Icon(Icons.remove,
                          size: 15, color: Color(0xFF0F766E)),
                    ),
                  ),
                  Text(
                    '${item.quantity}',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 13.5,
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFF0F172A),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      HapticFeedback.lightImpact();
                      controller.addItem(service, item.selectedOption);
                    },
                    behavior: HitTestBehavior.opaque,
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                      child:
                          Icon(Icons.add, size: 15, color: Color(0xFF0F766E)),
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
    KitchenCleaningController controller,
  ) {
    final miniServices =
        controller.services.where((s) => s.sectionId == 'mini').toList();
    final addons = miniServices.isNotEmpty
        ? miniServices
        : KitchenCleaningData.allServices
            .where((s) => s.sectionId == 'mini')
            .toList();

    if (addons.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recommended Add-ons',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 16,
            fontWeight: FontWeight.w800,
            color: const Color(0xFF1E293B),
          ),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.03),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: SizedBox(
            height: 175,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: addons.length,
              separatorBuilder: (context, index) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final addon = addons[index];
                return _buildAddonCard(context, controller, addon);
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAddonCard(
    BuildContext context,
    KitchenCleaningController controller,
    KitchenCleaningServiceItem addon,
  ) {
    final isInCart = controller.getItemQuantity(addon.id) > 0;

    return SizedBox(
      width: 110,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image with Floating ADD Button
          Stack(
            children: [
              Container(
                width: 110,
                height: 95,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: const Color(0xFFF8FAFC),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: AppNetworkImage(
                    imageUrl: addon.imageUrl ?? '',
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              // Floating ADD Button
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
                        horizontal: 8, vertical: 3.5),
                    decoration: BoxDecoration(
                      color: isInCart
                          ? const Color(0xFF0F766E)
                          : const Color(0xFFE6F4F1),
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
                        color: isInCart ? Colors.white : const Color(0xFF0F766E),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 6),

          // Add-on Title
          Text(
            addon.title,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 11.5,
              fontWeight: FontWeight.w600,
              height: 1.2,
              color: const Color(0xFF334155),
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),

          const Spacer(),

          // Price
          Text(
            '₹${addon.price.toStringAsFixed(0)}',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14,
              fontWeight: FontWeight.w900,
              color: const Color(0xFF0F172A),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomCheckoutBar(
    BuildContext context,
    KitchenCleaningController controller,
  ) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
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
                    color: const Color(0xFF0F172A),
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
                    HapticFeedback.mediumImpact();
                    Get.snackbar(
                      'Select Address',
                      'Proceeding to address selection with total: ₹${controller.totalCartPrice.toStringAsFixed(0)}',
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: const Color(0xFF0F766E),
                      colorText: Colors.white,
                      duration: const Duration(seconds: 3),
                      margin: const EdgeInsets.all(16),
                      borderRadius: 12,
                    );
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
      ),
    );
  }

  Widget _buildEmptyCartView(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                color: Color(0xFFE6F4F1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.shopping_cart_outlined,
                size: 64,
                color: Color(0xFF0F766E),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Your cart is empty',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: const Color(0xFF1E293B),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Looks like you haven\'t added any services yet.',
              textAlign: TextAlign.center,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 14,
                color: const Color(0xFF64748B),
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