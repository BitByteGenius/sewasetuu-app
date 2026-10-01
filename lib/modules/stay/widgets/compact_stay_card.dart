import 'package:flutter/material.dart';
import 'package:sewasetu/app/theme/app_colors.dart';
import 'package:sewasetu/app/theme/app_radius.dart';
import 'package:sewasetu/app/theme/app_shadows.dart';
import 'package:sewasetu/app/theme/app_text_styles.dart';
import 'package:sewasetu/core/utils/formatters.dart';
import 'package:sewasetu/modules/stay/models/property_model.dart';
import 'package:sewasetu/shared/widgets/app_network_image.dart';

/// Redesigned Modern & Compact Accommodation Card following:
/// Image → type/verified badge → property name → location → rating → price → important details → favorite
class CompactStayCard extends StatelessWidget {
  final PropertyModel stay;
  final VoidCallback onTap;
  final ValueChanged<bool>? onFavoriteToggle;
  final double? width;

  const CompactStayCard({
    super.key,
    required this.stay,
    required this.onTap,
    this.onFavoriteToggle,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = isDark ? AppColors.primaryLight : AppColors.primary;
    final mutedTextColor =
        isDark ? AppColors.textMutedDark : AppColors.textMutedLight;
    final displayPrice = stay.displayPricePerMonth > 0
        ? stay.displayPricePerMonth
        : stay.pricePerNight;

    return Container(
      width: width ?? 240,
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : Colors.white,
        borderRadius: AppRadius.radiusLg,
        boxShadow: AppShadows.sm,
        border: Border.all(
          color: isDark ? AppColors.borderDark : AppColors.borderLight,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Image Header with Badges & Favorite Button
            Stack(
              children: [
                AppNetworkImage(
                  imageUrl: stay.images.isNotEmpty ? stay.images.first : '',
                  height: 120,
                  width: double.infinity,
                  borderRadius: BorderRadius.zero,
                ),
                // Gradient tint on top for contrast
                Positioned.fill(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withAlpha(90),
                          Colors.transparent,
                        ],
                        stops: const [0.0, 0.4],
                      ),
                    ),
                  ),
                ),
                // 2. Type / Verified Badge (Top Left)
                Positioned(
                  top: 8,
                  left: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: (isDark ? AppColors.surfaceDark : Colors.white)
                          .withAlpha(235),
                      borderRadius: AppRadius.radiusPill,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          stay.stayType.emoji,
                          style: const TextStyle(fontSize: 11),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          stay.stayType.label,
                          style: AppTextStyles.labelSmall(isDark).copyWith(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        if (stay.isVerified) ...[
                          const SizedBox(width: 4),
                          const Icon(
                            Icons.verified_rounded,
                            size: 11,
                            color: Color(0xFF10B981),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
                // Favorite Button (Top Right)
                Positioned(
                  top: 6,
                  right: 6,
                  child: GestureDetector(
                    onTap: () => onFavoriteToggle?.call(!stay.isFavorite),
                    child: Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: (isDark ? AppColors.surfaceDark : Colors.white)
                            .withAlpha(220),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Icon(
                          stay.isFavorite
                              ? Icons.favorite_rounded
                              : Icons.favorite_border_rounded,
                          size: 15,
                          color: stay.isFavorite
                              ? AppColors.error
                              : (isDark ? Colors.white70 : Colors.black87),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // Card Body Content
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 3. Property Name
                  Text(
                    stay.title,
                    style: AppTextStyles.titleSmall(isDark).copyWith(
                      fontWeight: FontWeight.w800,
                      fontSize: 13,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 3),

                  // 4. Location & 5. Rating Row
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        size: 13,
                        color: mutedTextColor,
                      ),
                      const SizedBox(width: 2),
                      Expanded(
                        child: Text(
                          stay.city,
                          style: AppTextStyles.bodySmall(isDark).copyWith(
                            fontSize: 11,
                            color: mutedTextColor,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(Icons.star_rounded, size: 13, color: Colors.amber),
                      const SizedBox(width: 2),
                      Text(
                        stay.rating.toStringAsFixed(1),
                        style: AppTextStyles.labelSmall(isDark).copyWith(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),

                  // 6. Price & 7. Important Details
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              AppFormatters.formatCurrency(displayPrice),
                              style: AppTextStyles.priceTag(isDark, fontSize: 14).copyWith(
                                color: primaryColor,
                                fontWeight: FontWeight.w800,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              stay.displayPricePerMonth > 0 ? '/ month' : '/ night',
                              style: AppTextStyles.labelSmall(isDark).copyWith(
                                fontSize: 10,
                                color: mutedTextColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                        decoration: BoxDecoration(
                          color: isDark
                              ? AppColors.surfaceVariantDark
                              : AppColors.surfaceVariantLight,
                          borderRadius: AppRadius.radiusSm,
                        ),
                        child: Text(
                          stay.roomConfiguration.isNotEmpty
                              ? stay.roomConfiguration
                              : (stay.furnishingStatus ?? 'Available'),
                          style: AppTextStyles.labelSmall(isDark).copyWith(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: isDark
                                ? AppColors.textSecondaryDark
                                : AppColors.textSecondaryLight,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
