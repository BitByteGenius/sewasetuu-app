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

/// High-end stay property card with image carousel/hero, rating, favorite toggle, and monthly pricing.
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
    final monthlyPrice = stay.displayPricePerMonth;
    final primaryColor = isDark ? AppColors.primaryLight : AppColors.primary;
    final mutedTextColor =
        isDark ? AppColors.textMutedDark : AppColors.textMutedLight;

    return AppCard(
      padding: EdgeInsets.zero,
      width: width,
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image Header with Badges & Favorite Button
          Stack(
            children: [
              Hero(
                tag: 'stay-img-${stay.id}',
                child: AppNetworkImage(
                  imageUrl: stay.images.isNotEmpty ? stay.images.first : '',
                  height: 155,
                  width: double.infinity,
                  borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(AppRadius.lg)),
                ),
              ),
              // Gradient Overlay
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(AppRadius.lg)),
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
                top: 10,
                left: 10,
                child: AppBadge(
                  text: '${stay.stayType.emoji} ${stay.stayType.label}',
                  backgroundColor: isDark
                      ? AppColors.surfaceDark.withAlpha(220)
                      : Colors.white.withAlpha(240),
                  textColor: isDark
                      ? AppColors.textPrimaryDark
                      : AppColors.textPrimaryLight,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                ),
              ),
              // Favorite Button (Top Right)
              Positioned(
                top: 8,
                right: 8,
                child: _buildFavoriteButton(isDark),
              ),
              // Verified badge (Bottom Left on Image)
              if (stay.isVerified)
                const Positioned(
                  bottom: 8,
                  left: 10,
                  child: AppBadge.verified(),
                ),
            ],
          ),
          // Content
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 10, 14, 12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
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
                            size: 14,
                            color: mutedTextColor,
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              stay.city,
                              style: AppTextStyles.bodySmall(isDark).copyWith(
                                color: mutedTextColor,
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
                const SizedBox(height: 6),
                // Title
                Text(
                  stay.title,
                  style: AppTextStyles.titleMedium(isDark).copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                AppSpacing.gapV4,
                // Configuration & Furnishing
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        stay.furnishingStatus != null &&
                                stay.furnishingStatus!.isNotEmpty
                            ? '${stay.roomConfiguration} • ${stay.furnishingStatus}'
                            : stay.roomConfiguration,
                        style: AppTextStyles.bodySmall(isDark).copyWith(
                          fontSize: 12,
                          color: mutedTextColor,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                AppSpacing.gapV8,
                Divider(
                  height: 1,
                  thickness: 0.5,
                  color: isDark ? AppColors.borderDark : AppColors.borderLight,
                ),
                AppSpacing.gapV8,
                // Monthly Pricing & Supporting Info
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
                            'Monthly rent',
                            style: AppTextStyles.labelSmall(isDark).copyWith(
                              fontSize: 10,
                              color: mutedTextColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.alphabetic,
                            children: [
                              Flexible(
                                child: Text(
                                  monthlyPrice > 0
                                      ? AppFormatters.formatCurrency(
                                          monthlyPrice)
                                      : 'Contact Us',
                                  style:
                                      AppTextStyles.priceTag(isDark).copyWith(
                                    fontSize: 17,
                                    color: primaryColor,
                                    fontWeight: FontWeight.w800,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              if (monthlyPrice > 0)
                                Text(
                                  ' / mo',
                                  style:
                                      AppTextStyles.bodySmall(isDark).copyWith(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12,
                                    color: primaryColor,
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    // Supporting info: Nightly price or Deposit
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (stay.pricePerNight > 0)
                          Text(
                            '${AppFormatters.formatCurrency(stay.pricePerNight)} / night',
                            style: AppTextStyles.labelSmall(isDark).copyWith(
                              color: mutedTextColor,
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          )
                        else if (stay.depositAmount != null &&
                            stay.depositAmount! > 0)
                          Text(
                            'Deposit: ${AppFormatters.formatCurrency(stay.depositAmount!)}',
                            style: AppTextStyles.labelSmall(isDark).copyWith(
                              color: mutedTextColor,
                              fontSize: 11,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                      ],
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
    final monthlyPrice = stay.displayPricePerMonth;
    final primaryColor = isDark ? AppColors.primaryLight : AppColors.primary;
    final mutedTextColor =
        isDark ? AppColors.textMutedDark : AppColors.textMutedLight;

    return AppCard(
      padding: EdgeInsets.zero,
      onTap: onTap,
      child: SizedBox(
        height: 118,
        child: Row(
          children: [
            // Image
            ClipRRect(
              borderRadius: const BorderRadius.horizontal(
                  left: Radius.circular(AppRadius.lg)),
              child: SizedBox(
                width: 115,
                height: 118,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    AppNetworkImage(
                      imageUrl: stay.images.isNotEmpty ? stay.images.first : '',
                      borderRadius: BorderRadius.zero,
                    ),
                    Positioned(
                      top: 6,
                      left: 6,
                      child: AppBadge(
                        text: stay.stayType.emoji,
                        padding: const EdgeInsets.all(3),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Info
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            stay.city,
                            style: AppTextStyles.labelSmall(isDark).copyWith(
                              color: mutedTextColor,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        AppRatingBar(
                          rating: stay.rating,
                          iconSize: 11,
                          showReviewsCount: false,
                        ),
                      ],
                    ),
                    Text(
                      stay.title,
                      style: AppTextStyles.titleSmall(isDark).copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      stay.roomConfiguration,
                      style: AppTextStyles.bodySmall(isDark).copyWith(
                        fontSize: 11,
                        color: mutedTextColor,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            monthlyPrice > 0
                                ? '${AppFormatters.formatCurrency(monthlyPrice)} / mo'
                                : '${AppFormatters.formatCurrency(stay.pricePerNight)} / night',
                            style: AppTextStyles.labelMedium(isDark).copyWith(
                              color: primaryColor,
                              fontWeight: FontWeight.w800,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 6),
                        _buildFavoriteButton(isDark, size: 26),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCompactCard(BuildContext context, bool isDark) {
    final monthlyPrice = stay.displayPricePerMonth;
    final primaryColor = isDark ? AppColors.primaryLight : AppColors.primary;
    final mutedTextColor =
        isDark ? AppColors.textMutedDark : AppColors.textMutedLight;

    return AppCard(
      padding: EdgeInsets.zero,
      width: width ?? 230,
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppNetworkImage(
            imageUrl: stay.images.isNotEmpty ? stay.images.first : '',
            height: 115,
            width: double.infinity,
            borderRadius:
                const BorderRadius.vertical(top: Radius.circular(AppRadius.lg)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        stay.stayType.label,
                        style: AppTextStyles.labelSmall(isDark).copyWith(
                          color: primaryColor,
                          fontWeight: FontWeight.w700,
                          fontSize: 11,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 4),
                    AppRatingBar(
                      rating: stay.rating,
                      iconSize: 11,
                      showReviewsCount: false,
                    ),
                  ],
                ),
                AppSpacing.gapV4,
                Text(
                  stay.title,
                  style: AppTextStyles.titleSmall(isDark).copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                AppSpacing.gapV4,
                Text(
                  monthlyPrice > 0
                      ? '${AppFormatters.formatCurrency(monthlyPrice)} / mo'
                      : '${AppFormatters.formatCurrency(stay.pricePerNight)} / night',
                  style: AppTextStyles.priceTag(isDark, fontSize: 14).copyWith(
                    color: primaryColor,
                    fontWeight: FontWeight.w800,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                if (stay.pricePerNight > 0 && monthlyPrice > 0)
                  Text(
                    '${AppFormatters.formatCurrency(stay.pricePerNight)} / night',
                    style: AppTextStyles.labelSmall(isDark).copyWith(
                      color: mutedTextColor,
                      fontSize: 10,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFavoriteButton(bool isDark, {double size = 32}) {
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
              color: isDark
                  ? AppColors.surfaceDark.withAlpha(200)
                  : Colors.white.withAlpha(230),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Icon(
                stay.isFavorite
                    ? Icons.favorite_rounded
                    : Icons.favorite_border_rounded,
                size: size * 0.52,
                color: stay.isFavorite
                    ? AppColors.error
                    : (isDark ? Colors.white70 : Colors.black87),
              ),
            ),
          ),
        );
      },
    );
  }
}

typedef PropertyCard = StayCardWidget;
