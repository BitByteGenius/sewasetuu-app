import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sewasetu/app/theme/app_colors.dart';
import '../models/kitchen_cleaning_model.dart';

/// Horizontal promotional offers carousel widget matching reference screenshot.
class KitchenCleaningOfferCarousel extends StatelessWidget {
  final List<KitchenCleaningOfferBanner> promoBanners;
  final ValueChanged<String> onCopyCode;

  const KitchenCleaningOfferCarousel({
    super.key,
    required this.promoBanners,
    required this.onCopyCode,
  });

  @override
  Widget build(BuildContext context) {
    if (promoBanners.isEmpty) return const SizedBox.shrink();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SizedBox(
      height: 90,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: promoBanners.length,
        separatorBuilder: (context, index) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final banner = promoBanners[index];
          return _buildOfferBanner(context, banner, isDark);
        },
      ),
    );
  }

  Widget _buildOfferBanner(
      BuildContext context, KitchenCleaningOfferBanner banner, bool isDark) {
    return Container(
      width: 310,
      padding: const EdgeInsets.fromLTRB(14, 10, 14, 10),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1B4B) : const Color(0xFFF3E8FF),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? AppColors.borderDark : const Color(0xFFE9D5FF),
          width: 1.1,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Tag text with info icon
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      banner.tagText,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 10.5,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.2,
                        color: isDark
                            ? AppColors.textMutedDark
                            : const Color(0xFF6B21A8),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),

                // Headline
                Text(
                  banner.headline,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 13.5,
                    fontWeight: FontWeight.w800,
                    color: isDark ? Colors.white : const Color(0xFF4C1D95),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),

                // Coupon code pill with copy button
                InkWell(
                  onTap: () => onCopyCode(banner.promoCode),
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xFFC084FC)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          banner.promoCode,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 11,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 0.5,
                            color: const Color(0xFF6B21A8),
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Icon(
                          Icons.copy_rounded,
                          size: 13,
                          color: Color(0xFF6B21A8),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Right graphic avatar
          if (banner.imageUrl != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                banner.imageUrl!,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 60,
                  height: 60,
                  color: Colors.purple.shade100,
                  child: const Icon(Icons.cleaning_services, color: Colors.purple),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
