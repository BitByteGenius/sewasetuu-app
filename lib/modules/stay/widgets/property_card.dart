import 'package:flutter/material.dart';
import 'package:sewasetu/app/theme/app_colors.dart';
import 'package:sewasetu/app/theme/app_radius.dart';
import 'package:sewasetu/app/theme/app_spacing.dart';
import 'package:sewasetu/app/theme/app_text_styles.dart';
import 'package:sewasetu/core/utils/formatters.dart';
import 'package:sewasetu/modules/stay/models/property_model.dart';
import 'package:sewasetu/shared/widgets/app_badge.dart';
import 'package:sewasetu/shared/widgets/app_card.dart';
import 'package:sewasetu/shared/widgets/app_network_image.dart';
import 'package:sewasetu/shared/widgets/app_rating_bar.dart';

enum StayCardStyle { vertical, horizontal, compact }

/// High-end stay property card with image carousel/hero, rating, favorite toggle, and pricing tags.
class StayCardWidget extends StatelessWidget {
  final PropertyModel stay;
  final VoidCallback onTap;
  final ValueChanged<bool>? onFavoriteToggle;
  final StayCardStyle style;
  final double? width;

  const StayCardWidget({
    super.key,
    required this.stay,
    required this.onTap,
    this.onFavoriteToggle,
    this.style = StayCardStyle.vertical,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (style == StayCardStyle.horizontal) {
      return _buildHorizontalCard(context, isDark);
    } else if (style == StayCardStyle.compact) {
      return _buildCompactCard(context, isDark);
    }

    return _buildVerticalCard(context, isDark);
  }

  Widget _buildVerticalCard(BuildContext context, bool isDark) {
    return AppCard(
      padding: EdgeInsets.zero,
      width: width,
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image Header with Badges & Favorite Button
          Stack(
            children: [
              Hero(
                tag: 'stay-img-${stay.id}',
                child: AppNetworkImage(
                  imageUrl: stay.images.isNotEmpty ? stay.images.first : '',
                  height: 180,
                  width: double.infinity,
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(AppRadius.lg)),
                ),
              ),
              // Gradient Overlay
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(AppRadius.lg)),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withAlpha((255 * 0.35).round()),
                        Colors.transparent,
                        Colors.black.withAlpha((255 * 0.2).round()),
                      ],
                      stops: const [0.0, 0.4, 1.0],
                    ),
                  ),
                ),
              ),
              // Category Pill (Top Left)
              Positioned(
                top: 12,
                left: 12,
                child: AppBadge(
                  text: '${stay.stayType.emoji} ${stay.stayType.label}',
                  backgroundColor: isDark ? AppColors.surfaceDark.withAlpha(220) : Colors.white.withAlpha(240),
                  textColor: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                ),
              ),
              // Favorite Button (Top Right)
              Positioned(
                top: 10,
                right: 10,
                child: _buildFavoriteButton(isDark),
              ),
              // Verified badge (Bottom Left on Image)
              if (stay.isVerified)
                const Positioned(
                  bottom: 10,
                  left: 12,
                  child: AppBadge.verified(),
                ),
            ],
          ),
          // Content
          Padding(
            padding: AppSpacing.edgeInsetsLg,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Location & Rating
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            size: 15,
                            color: isDark ? AppColors.textMutedDark : AppColors.textMutedLight,
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              stay.city,
                              style: AppTextStyles.bodySmall(isDark).copyWith(
                                color: isDark ? AppColors.textMutedDark : AppColors.textMutedLight,
                                fontWeight: FontWeight.w500,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                    AppRatingBar(
                      rating: stay.rating,
                      reviewsCount: stay.reviewsCount,
                    ),
                  ],
                ),
                AppSpacing.gapV8,
                // Title
                Text(
                  stay.title,
                  style: AppTextStyles.titleMedium(isDark).copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                AppSpacing.gapV4,
                // Configuration info
                Text(
                  stay.roomConfiguration,
                  style: AppTextStyles.bodySmall(isDark),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                AppSpacing.gapV12,
                const Divider(height: 1),
                AppSpacing.gapV12,
                // Pricing
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Starting from',
                          style: AppTextStyles.labelSmall(isDark),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            Text(
                              AppFormatters.formatCurrency(stay.pricePerNight),
                              style: AppTextStyles.priceTag(isDark),
                            ),
                            Text(
                              ' / night',
                              style: AppTextStyles.bodySmall(isDark),
                            ),
                          ],
                        ),
                      ],
                    ),
                    if (stay.pricePerMonth != null)
                      Text(
                        '${AppFormatters.formatCurrency(stay.pricePerMonth!)}/mo',
                        style: AppTextStyles.labelSmall(isDark).copyWith(
                          color: isDark ? AppColors.primaryLight : AppColors.primary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHorizontalCard(BuildContext context, bool isDark) {
    return AppCard(
      padding: EdgeInsets.zero,
      onTap: onTap,
      child: Row(
        children: [
          // Image
          ClipRRect(
            borderRadius: const BorderRadius.horizontal(left: Radius.circular(AppRadius.lg)),
            child: SizedBox(
              width: 130,
              height: 140,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  AppNetworkImage(
                    imageUrl: stay.images.isNotEmpty ? stay.images.first : '',
                    borderRadius: BorderRadius.zero,
                  ),
                  Positioned(
                    top: 8,
                    left: 8,
                    child: AppBadge(
                      text: stay.stayType.emoji,
                      padding: const EdgeInsets.all(4),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Info
          Expanded(
            child: Padding(
              padding: AppSpacing.edgeInsetsMd,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          stay.city,
                          style: AppTextStyles.labelSmall(isDark),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      AppRatingBar(
                        rating: stay.rating,
                        iconSize: 12,
                        showReviewsCount: false,
                      ),
                    ],
                  ),
                  AppSpacing.gapV4,
                  Text(
                    stay.title,
                    style: AppTextStyles.titleSmall(isDark),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  AppSpacing.gapV4,
                  Text(
                    stay.roomConfiguration,
                    style: AppTextStyles.bodySmall(isDark),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  AppSpacing.gapV8,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          '${AppFormatters.formatCurrency(stay.pricePerNight)} / night',
                          style: AppTextStyles.labelMedium(isDark).copyWith(
                            color: isDark ? AppColors.primaryLight : AppColors.primary,
                            fontWeight: FontWeight.w800,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 8),
                      _buildFavoriteButton(isDark, size: 28),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompactCard(BuildContext context, bool isDark) {
    return AppCard(
      padding: EdgeInsets.zero,
      width: width ?? 240,
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppNetworkImage(
            imageUrl: stay.images.isNotEmpty ? stay.images.first : '',
            height: 130,
            width: double.infinity,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(AppRadius.lg)),
          ),
          Padding(
            padding: AppSpacing.edgeInsetsMd,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        stay.stayType.label,
                        style: AppTextStyles.labelSmall(isDark).copyWith(
                          color: isDark ? AppColors.primaryLight : AppColors.primary,
                          fontWeight: FontWeight.w700,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 6),
                    AppRatingBar(
                      rating: stay.rating,
                      iconSize: 12,
                      showReviewsCount: false,
                    ),
                  ],
                ),
                AppSpacing.gapV4,
                Text(
                  stay.title,
                  style: AppTextStyles.titleSmall(isDark),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                AppSpacing.gapV4,
                Text(
                  '${AppFormatters.formatCurrency(stay.pricePerNight)} / night',
                  style: AppTextStyles.priceTag(isDark, fontSize: 15),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFavoriteButton(bool isDark, {double size = 34}) {
    return StatefulBuilder(
      builder: (context, setState) {
        return GestureDetector(
          onTap: () {
            onFavoriteToggle?.call(!stay.isFavorite);
          },
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: isDark ? AppColors.surfaceDark.withAlpha(200) : Colors.white.withAlpha(230),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Icon(
                stay.isFavorite ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                size: size * 0.52,
                color: stay.isFavorite ? AppColors.error : (isDark ? Colors.white70 : Colors.black87),
              ),
            ),
          ),
        );
      },
    );
  }
}

typedef PropertyCard = StayCardWidget;
