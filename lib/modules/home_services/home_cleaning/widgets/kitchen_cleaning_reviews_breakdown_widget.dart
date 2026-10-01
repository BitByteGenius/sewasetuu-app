import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sewasetu/app/theme/app_colors.dart';
import '../models/kitchen_cleaning_model.dart';

/// Ratings & Reviews distribution card matching reference image.
class KitchenCleaningReviewsBreakdownWidget extends StatelessWidget {
  final RatingBreakdownModel ratingData;

  const KitchenCleaningReviewsBreakdownWidget({
    super.key,
    required this.ratingData,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark ? AppColors.borderDark : const Color(0xFFE2E8F0),
          width: 1.1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Ratings & Reviews',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: isDark ? AppColors.textPrimaryDark : const Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 16),

          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Left side: Avg Rating Number
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    ratingData.avgRating.toStringAsFixed(2),
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 38,
                      fontWeight: FontWeight.w900,
                      color: isDark
                          ? AppColors.textPrimaryDark
                          : const Color(0xFF1E293B),
                    ),
                  ),
                  Text(
                    'avg rating',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: isDark
                          ? AppColors.textMutedDark
                          : const Color(0xFF64748B),
                    ),
                  ),
                ],
              ),

              const SizedBox(width: 20),

              // Right side: Star Bars Breakdown
              Expanded(
                child: Column(
                  children: [5, 4, 3, 2, 1].map((star) {
                    final count = ratingData.starCounts[star] ?? 0;
                    final fraction = ratingData.totalCount > 0
                        ? count / ratingData.totalCount
                        : 0.0;

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2.5),
                      child: Row(
                        children: [
                          Icon(
                            Icons.star_rounded,
                            size: 13,
                            color: isDark
                                ? AppColors.textMutedDark
                                : const Color(0xFF64748B),
                          ),
                          const SizedBox(width: 3),
                          Text(
                            '$star',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 11.5,
                              fontWeight: FontWeight.w700,
                              color: isDark
                                  ? AppColors.textPrimaryDark
                                  : const Color(0xFF475569),
                            ),
                          ),
                          const SizedBox(width: 8),

                          // Progress Bar Track
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: LinearProgressIndicator(
                                value: fraction.clamp(0.02, 1.0),
                                minHeight: 6,
                                backgroundColor: isDark
                                    ? AppColors.surfaceVariantDark
                                    : const Color(0xFFF1F5F9),
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  isDark
                                      ? const Color(0xFFEAB308)
                                      : const Color(0xFF1E293B),
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(width: 8),

                          SizedBox(
                            width: 44,
                            child: Text(
                              '$count',
                              textAlign: TextAlign.end,
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: isDark
                                    ? AppColors.textMutedDark
                                    : const Color(0xFF64748B),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
