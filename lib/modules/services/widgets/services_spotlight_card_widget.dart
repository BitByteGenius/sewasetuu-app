import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sewasetu/app/theme/app_colors.dart';
import 'package:sewasetu/shared/widgets/app_network_image.dart';
import '../models/service_spotlight_item.dart';

/// "In the Spotlight" featured service showcase card matching reference design
class ServicesSpotlightCardWidget extends StatelessWidget {
  final ServiceSpotlightItem spotlight;
  final VoidCallback onBook;

  const ServicesSpotlightCardWidget({
    super.key,
    required this.spotlight,
    required this.onBook,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Title
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'In the Spotlight',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.3,
              color: isDark ? AppColors.textPrimaryDark : const Color(0xFF1E293B),
            ),
          ),
        ),
        const SizedBox(height: 12),

        // Spotlight Card
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Container(
            decoration: BoxDecoration(
              color: isDark ? AppColors.surfaceDark : Colors.white,
              borderRadius: BorderRadius.circular(22),
              border: Border.all(
                color: isDark ? AppColors.borderDark : const Color(0xFFE2E8F0),
                width: 1.2,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: isDark ? 0.35 : 0.05),
                  blurRadius: 14,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Header Row
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            spotlight.title,
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 18,
                              fontWeight: FontWeight.w900,
                              color: const Color(0xFF1D4ED8), // Vibrant Royal Blue
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            spotlight.subtitle,
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: isDark ? AppColors.textMutedDark : const Color(0xFF64748B),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Discount Badge
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: const Color(0xFF0284C7),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF0284C7).withValues(alpha: 0.35),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            spotlight.discountBadgeText,
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 11,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            'Use Code: ${spotlight.promoCode}',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 8.5,
                              fontWeight: FontWeight.w700,
                              color: Colors.white.withValues(alpha: 0.9),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),

                // Featured Center Image
                ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: SizedBox(
                    height: 155,
                    width: double.infinity,
                    child: AppNetworkImage(
                      imageUrl: spotlight.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 14),

                // Trust Badges Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: spotlight.badges.map((badge) {
                    return _buildTrustBadge(badge, isDark);
                  }).toList(),
                ),
                const SizedBox(height: 14),

                // Outlined Booking Button
                SizedBox(
                  width: double.infinity,
                  height: 44,
                  child: OutlinedButton(
                    onPressed: onBook,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF0F766E),
                      side: const BorderSide(
                        color: Color(0xFF0F766E),
                        width: 1.4,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                    ),
                    child: Text(
                      spotlight.ctaText,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 13.5,
                        fontWeight: FontWeight.w800,
                        color: isDark ? const Color(0xFF2DD4BF) : const Color(0xFF0F766E),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTrustBadge(SpotlightBadge badge, bool isDark) {
    IconData icon;
    Color iconColor;

    switch (badge.iconType) {
      case 'smile':
        icon = Icons.sentiment_satisfied_alt_rounded;
        iconColor = const Color(0xFF0284C7);
        break;
      case 'star':
        icon = Icons.star_border_rounded;
        iconColor = const Color(0xFF0284C7);
        break;
      default:
        icon = Icons.verified_outlined;
        iconColor = const Color(0xFF0284C7);
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 18, color: iconColor),
        const SizedBox(width: 5),
        Text(
          badge.label,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 10,
            fontWeight: FontWeight.w600,
            height: 1.2,
            color: isDark ? AppColors.textPrimaryDark : const Color(0xFF334155),
          ),
        ),
      ],
    );
  }
}
