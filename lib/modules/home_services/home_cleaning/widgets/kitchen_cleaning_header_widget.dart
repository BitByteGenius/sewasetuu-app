import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sewasetu/app/theme/app_colors.dart';
import 'package:sewasetu/shared/widgets/app_network_image.dart';
import '../models/kitchen_cleaning_model.dart';

/// Top header section displaying screen title, rating badge,
/// and the 3 quick-category navigation cards matching reference photos.
class KitchenCleaningHeaderWidget extends StatelessWidget {
  final String title;
  final double rating;
  final String ratingCountText;
  final List<KitchenCleaningNavCategory> categories;
  final String activeCategoryId;
  final ValueChanged<String> onSelectCategory;

  const KitchenCleaningHeaderWidget({
    super.key,
    this.title = 'Kitchen Cleaning',
    this.rating = 4.77,
    this.ratingCountText = '(192.2K+ ratings)',
    required this.categories,
    required this.activeCategoryId,
    required this.onSelectCategory,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title & Ratings Badge Row
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 14),
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
                    color: Color(0xFFF59E0B), // Amber gold star
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
                    ratingCountText,
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
        ),

        // Quick Category Nav Card Container
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
          decoration: BoxDecoration(
            color: isDark ? AppColors.surfaceDark : Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isDark ? AppColors.borderDark : const Color(0xFFE2E8F0),
              width: 1.1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: isDark ? 0.25 : 0.03),
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: categories.map((cat) {
              final isSelected = activeCategoryId == cat.id;

              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(14),
                      onTap: () {
                        HapticFeedback.lightImpact();
                        onSelectCategory(cat.id);
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? (isDark
                                  ? AppColors.primaryLight.withValues(alpha: 0.15)
                                  : const Color(0xFFF0FDF4))
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: isSelected
                                ? (isDark
                                    ? AppColors.primaryLight
                                    : const Color(0xFF0F766E))
                                : Colors.transparent,
                            width: isSelected ? 1.3 : 1.0,
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Image / Graphic Container
                            Container(
                              width: 64,
                              height: 52,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: isDark
                                    ? AppColors.surfaceVariantDark
                                    : const Color(0xFFF8FAFC),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: AppNetworkImage(
                                  imageUrl: cat.imageUrl,
                                  fit: BoxFit.cover,
                                  errorWidget: Center(
                                    child: Icon(
                                      cat.fallbackIcon ?? Icons.cleaning_services_rounded,
                                      size: 26,
                                      color: const Color(0xFF0F766E),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),

                            // Title Text
                            Text(
                              cat.title.replaceAll('\n', ' '),
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 11.5,
                                fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
                                height: 1.2,
                                color: isSelected
                                    ? (isDark
                                        ? AppColors.primaryLight
                                        : const Color(0xFF0F766E))
                                    : (isDark
                                        ? AppColors.textPrimaryDark
                                        : const Color(0xFF334155)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
