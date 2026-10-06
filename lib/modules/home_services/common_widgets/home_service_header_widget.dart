import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sewasetu/app/theme/app_colors.dart';

/// Reusable Section Header for Home Services detail screens.
/// Renders service title, rating star, and review count badge in a clean layout.
class HomeServiceTitleRatingHeader extends StatelessWidget {
  final String title;
  final double rating;
  final String ratingCount;

  const HomeServiceTitleRatingHeader({
    super.key,
    required this.title,
    this.rating = 4.8,
    this.ratingCount = '100K+',
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.4,
              color: isDark ? AppColors.textPrimaryDark : const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(
                Icons.star_rounded,
                size: 17,
                color: Color(0xFFF59E0B),
              ),
              const SizedBox(width: 4),
              Text(
                '$rating ',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w700,
                  color: isDark ? AppColors.textPrimaryDark : const Color(0xFF1E293B),
                ),
              ),
              Text(
                '($ratingCount ratings)',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w500,
                  color: isDark ? AppColors.textMutedDark : const Color(0xFF64748B),
                  decoration: TextDecoration.underline,
                  decorationStyle: TextDecorationStyle.dotted,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
