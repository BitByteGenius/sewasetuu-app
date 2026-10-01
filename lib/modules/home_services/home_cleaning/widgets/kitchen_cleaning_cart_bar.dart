import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

/// Floating bottom cart bar displaying total selected items, price, and View Cart CTA button
/// with smooth entrance and exit animations.
class KitchenCleaningCartBar extends StatelessWidget {
  final int itemQuantity;
  final double totalPrice;
  final VoidCallback onViewCart;

  const KitchenCleaningCartBar({
    super.key,
    required this.itemQuantity,
    required this.totalPrice,
    required this.onViewCart,
  });

  @override
  Widget build(BuildContext context) {
    final isVisible = itemQuantity > 0;

    return Positioned(
      left: 16,
      right: 16,
      bottom: 16,
      child: SafeArea(
        child: AnimatedSlide(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutCubic,
          offset: isVisible ? Offset.zero : const Offset(0, 2.0),
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 250),
            opacity: isVisible ? 1.0 : 0.0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
              decoration: BoxDecoration(
                color: const Color(0xFF0F766E), // Deep Emerald/Teal from app theme
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF0F766E).withValues(alpha: 0.35),
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Left: Item count & total price
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '$itemQuantity ${itemQuantity == 1 ? 'Item' : 'Items'} Added',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFFCCFBF1),
                        ),
                      ),
                      Text(
                        '₹${totalPrice.toStringAsFixed(0)}',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),

                  // Right: View Cart Button
                  GestureDetector(
                    onTap: () {
                      HapticFeedback.lightImpact();
                      onViewCart();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'View Cart',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 13.5,
                              fontWeight: FontWeight.w800,
                              color: const Color(0xFF0F766E),
                            ),
                          ),
                          const SizedBox(width: 4),
                          const Icon(
                            Icons.arrow_forward_rounded,
                            size: 16,
                            color: Color(0xFF0F766E),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
