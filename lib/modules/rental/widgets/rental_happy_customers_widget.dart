import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_radius.dart';
import '../../../app/theme/app_shadows.dart';
import '../../../app/theme/app_spacing.dart';
import '../data/datasources/rental_mock_datasource.dart';
import '../models/rental_review_model.dart';

/// Premium Happy Customers & Road Trip Stories showcase widget.
/// Displays verified travelers, real road-trip photos, vehicle badges, and authentic descriptions.
class RentalHappyCustomersWidget extends StatelessWidget {
  final List<RentalReviewModel>? customReviews;

  const RentalHappyCustomersWidget({
    super.key,
    this.customReviews,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final reviews = customReviews ?? RentalMockDatasource.reviews;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1. Header & Rating Summary
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Badge Pill
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.primary.withAlpha((255 * 0.12).round()),
                  borderRadius: AppRadius.radiusFull,
                  border: Border.all(
                    color: AppColors.primary.withAlpha((255 * 0.25).round()),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.sentiment_satisfied_alt_rounded,
                      size: 14,
                      color: AppColors.primary,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'COMMUNITY OF TRAVELERS',
                      style: TextStyle(
                        fontSize: 10.5,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.8,
                        color: isDark ? AppColors.primaryLight : AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: AppSpacing.sm),

              // Title Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Text(
                      'Happy Customers & Journeys',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.5,
                        color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFEF3C7),
                      borderRadius: AppRadius.radiusMd,
                      border: Border.all(color: const Color(0xFFFDE68A)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(Icons.star_rounded, size: 15, color: Color(0xFFD97706)),
                        SizedBox(width: 3),
                        Text(
                          '4.9 / 5.0',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF92400E),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 4),

              Text(
                'Real road trip memories and honest stories from verified SewaSetu travelers across India.',
                style: TextStyle(
                  fontSize: 12.5,
                  height: 1.35,
                  color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                ),
              ),

              const SizedBox(height: AppSpacing.md),

              // Trust Highlights Row
              _buildTrustHighlights(isDark),
            ],
          ),
        ),

        const SizedBox(height: AppSpacing.md),

        // 2. Horizontal Road Trip Stories Carousel
        SizedBox(
          height: 410,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: reviews.length,
            separatorBuilder: (context, index) => const SizedBox(width: AppSpacing.md),
            itemBuilder: (context, index) {
              final review = reviews[index];
              return _CustomerStoryCard(
                review: review,
                isDark: isDark,
                onTap: () => _showStoryModal(context, review, isDark),
              );
            },
          ),
        ),

        const SizedBox(height: AppSpacing.lg),

        // 3. Bottom Community Invite Banner
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
          child: _buildShareInviteBanner(context, isDark),
        ),
      ],
    );
  }

  Widget _buildTrustHighlights(bool isDark) {
    final highlights = [
      {'icon': Icons.directions_car_rounded, 'label': '12k+ Trips'},
      {'icon': Icons.verified_user_rounded, 'label': '100% Verified'},
      {'icon': Icons.thumb_up_alt_rounded, 'label': '99.4% Satisfied'},
      {'icon': Icons.support_agent_rounded, 'label': '24/7 Roadside'},
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: highlights.map((h) {
          return Container(
            margin: const EdgeInsets.only(right: 8),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: isDark
                  ? AppColors.surfaceVariantDark.withAlpha((255 * 0.5).round())
                  : AppColors.surfaceVariantLight,
              borderRadius: AppRadius.radiusFull,
              border: Border.all(
                color: isDark ? AppColors.borderDark : AppColors.borderLight,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  h['icon'] as IconData,
                  size: 13,
                  color: AppColors.primary,
                ),
                const SizedBox(width: 5),
                Text(
                  h['label'] as String,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildShareInviteBanner(BuildContext context, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isDark
              ? [
                  const Color(0xFF1E293B),
                  const Color(0xFF0F172A),
                ]
              : [
                  AppColors.primary.withAlpha((255 * 0.08).round()),
                  AppColors.secondary.withAlpha((255 * 0.08).round()),
                ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: AppRadius.radiusLg,
        border: Border.all(
          color: isDark
              ? AppColors.borderDark
              : AppColors.primary.withAlpha((255 * 0.2).round()),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.primary.withAlpha((255 * 0.15).round()),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.camera_alt_outlined,
              size: 20,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Have a road trip story to tell?',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Tag @SewaSetuRentals or submit your trip memories to earn ₹500 in rental credits!',
                  style: TextStyle(
                    fontSize: 11.5,
                    color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showStoryModal(BuildContext context, RentalReviewModel review, bool isDark) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => _StoryDetailModal(review: review, isDark: isDark),
    );
  }
}

/// Single card representing a happy customer road trip story.
class _CustomerStoryCard extends StatelessWidget {
  final RentalReviewModel review;
  final bool isDark;
  final VoidCallback onTap;

  const _CustomerStoryCard({
    required this.review,
    required this.isDark,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    const cardWidth = 310.0;

    return Container(
      width: cardWidth,
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : Colors.white,
        borderRadius: AppRadius.radiusXl,
        boxShadow: AppShadows.card,
        border: Border.all(
          color: isDark ? AppColors.borderDark : AppColors.borderLight,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: AppRadius.radiusXl,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Road Trip Photo with Route Overlay
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(AppRadius.xl),
                    ),
                    child: SizedBox(
                      height: 155,
                      width: double.infinity,
                      child: review.tripPhoto != null
                          ? CachedNetworkImage(
                              imageUrl: review.tripPhoto!,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Container(
                                color: isDark
                                    ? AppColors.surfaceVariantDark
                                    : AppColors.surfaceVariantLight,
                                child: const Center(
                                  child: SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: CircularProgressIndicator(strokeWidth: 2),
                                  ),
                                ),
                              ),
                              errorWidget: (context, url, error) => Container(
                                color: isDark ? const Color(0xFF1E293B) : const Color(0xFFE2E8F0),
                                child: const Icon(
                                  Icons.directions_car_rounded,
                                  size: 40,
                                  color: Colors.grey,
                                ),
                              ),
                            )
                          : Container(
                              color: isDark ? const Color(0xFF1E293B) : const Color(0xFFE2E8F0),
                              child: const Icon(
                                Icons.photo_library_outlined,
                                size: 40,
                                color: Colors.grey,
                              ),
                            ),
                    ),
                  ),

                  // Gradient overlay on photo
                  Positioned.fill(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(AppRadius.xl),
                        ),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black.withAlpha((255 * 0.25).round()),
                            Colors.transparent,
                            Colors.black.withAlpha((255 * 0.7).round()),
                          ],
                          stops: const [0.0, 0.5, 1.0],
                        ),
                      ),
                    ),
                  ),

                  // Top Left: Route Pill
                  if (review.tripRoute != null)
                    Positioned(
                      top: 10,
                      left: 10,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: Colors.black.withAlpha((255 * 0.65).round()),
                          borderRadius: AppRadius.radiusFull,
                          border: Border.all(
                            color: Colors.white.withAlpha((255 * 0.2).round()),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.alt_route_rounded,
                              size: 11,
                              color: Color(0xFF60A5FA),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              review.tripRoute!,
                              style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                  // Top Right: Tap to preview badge
                  Positioned(
                    top: 10,
                    right: 10,
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.black.withAlpha((255 * 0.55).round()),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.fullscreen_rounded,
                        size: 14,
                        color: Colors.white,
                      ),
                    ),
                  ),

                  // Bottom Left: City / Destination Tag
                  if (review.cityName != null)
                    Positioned(
                      bottom: 8,
                      left: 10,
                      child: Row(
                        children: [
                          const Icon(
                            Icons.location_on_rounded,
                            size: 12,
                            color: Colors.white70,
                          ),
                          const SizedBox(width: 2),
                          Text(
                            review.cityName!,
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),

              // 2. Card Body Content
              Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // User Header Row
                    Row(
                      children: [
                        // Customer Avatar
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: SizedBox(
                            width: 38,
                            height: 38,
                            child: review.userAvatar != null
                                ? CachedNetworkImage(
                                    imageUrl: review.userAvatar!,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => Container(
                                      color: AppColors.primary.withAlpha((255 * 0.1).round()),
                                    ),
                                    errorWidget: (context, url, error) => _buildInitialAvatar(),
                                  )
                                : _buildInitialAvatar(),
                          ),
                        ),

                        const SizedBox(width: AppSpacing.sm),

                        // Name & Duration
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                review.userName,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  color: isDark
                                      ? AppColors.textPrimaryDark
                                      : AppColors.textPrimaryLight,
                                ),
                              ),
                              const SizedBox(height: 1),
                              Text(
                                review.duration ?? 'Verified Road Trip',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: isDark
                                      ? AppColors.textMutedDark
                                      : AppColors.textSecondaryLight,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Verified Badge
                        if (review.verifiedRental)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: AppColors.success.withAlpha((255 * 0.12).round()),
                              borderRadius: AppRadius.radiusFull,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                Icon(
                                  Icons.verified_rounded,
                                  size: 12,
                                  color: AppColors.success,
                                ),
                                SizedBox(width: 3),
                                Text(
                                  'Verified',
                                  style: TextStyle(
                                    fontSize: 9.5,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.success,
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),

                    const SizedBox(height: 10),

                    // Rating and Vehicle Tag Row
                    Row(
                      children: [
                        // Star Rating
                        Row(
                          children: List.generate(5, (starIdx) {
                            final filled = starIdx < review.rating.floor();
                            return Icon(
                              filled ? Icons.star_rounded : Icons.star_half_rounded,
                              size: 14,
                              color: const Color(0xFFF59E0B),
                            );
                          }),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          review.rating.toStringAsFixed(1),
                          style: TextStyle(
                            fontSize: 11.5,
                            fontWeight: FontWeight.w700,
                            color: isDark
                                ? AppColors.textPrimaryDark
                                : AppColors.textPrimaryLight,
                          ),
                        ),

                        const Spacer(),

                        // Vehicle Pill
                        if (review.vehicleModelName != null)
                          Flexible(
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 7,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: isDark
                                    ? AppColors.surfaceVariantDark
                                    : AppColors.surfaceVariantLight,
                                borderRadius: AppRadius.radiusSm,
                                border: Border.all(
                                  color: isDark
                                      ? AppColors.borderDark
                                      : AppColors.borderLight,
                                ),
                              ),
                              child: Text(
                                review.vehicleModelName!,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: isDark
                                      ? AppColors.textSecondaryDark
                                      : AppColors.textSecondaryLight,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),

                    const SizedBox(height: 10),

                    // Testimonial Comment Description
                    Text(
                      '"${review.comment}"',
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12,
                        height: 1.42,
                        fontStyle: FontStyle.italic,
                        color: isDark
                            ? AppColors.textSecondaryDark
                            : AppColors.textSecondaryLight,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInitialAvatar() {
    final initials = review.userName.isNotEmpty
        ? review.userName.trim().split(' ').map((e) => e.isNotEmpty ? e[0] : '').take(2).join()
        : 'U';

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primary, AppColors.secondary],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: Text(
          initials,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

/// Fullscreen or BottomSheet expanded view of the customer trip memory
class _StoryDetailModal extends StatelessWidget {
  final RentalReviewModel review;
  final bool isDark;

  const _StoryDetailModal({
    required this.review,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.85,
      ),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(AppRadius.xxl)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Drag handle
          Center(
            child: Container(
              margin: const EdgeInsets.only(top: 10, bottom: 8),
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                color: isDark ? Colors.white24 : Colors.black12,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),

          Flexible(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.lg,
                AppSpacing.xs,
                AppSpacing.lg,
                AppSpacing.xxl,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Full Photo
                  if (review.tripPhoto != null)
                    ClipRRect(
                      borderRadius: AppRadius.radiusXl,
                      child: SizedBox(
                        height: 220,
                        width: double.infinity,
                        child: CachedNetworkImage(
                          imageUrl: review.tripPhoto!,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                  const SizedBox(height: AppSpacing.md),

                  // Route & City tags
                  Wrap(
                    spacing: 8,
                    runSpacing: 6,
                    children: [
                      if (review.tripRoute != null)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withAlpha((255 * 0.12).round()),
                            borderRadius: AppRadius.radiusFull,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.alt_route_rounded, size: 13, color: AppColors.primary),
                              const SizedBox(width: 4),
                              Text(
                                review.tripRoute!,
                                style: const TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.primary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      if (review.vehicleModelName != null)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: isDark ? AppColors.surfaceVariantDark : AppColors.surfaceVariantLight,
                            borderRadius: AppRadius.radiusFull,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.directions_car_rounded, size: 13),
                              const SizedBox(width: 4),
                              Text(
                                review.vehicleModelName!,
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),

                  const SizedBox(height: AppSpacing.md),

                  // User Info
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 22,
                        backgroundImage: review.userAvatar != null
                            ? NetworkImage(review.userAvatar!)
                            : null,
                        child: review.userAvatar == null
                            ? Text(review.userName.substring(0, 1))
                            : null,
                      ),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              review.userName,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                              ),
                            ),
                            Text(
                              '${review.duration ?? 'Verified Trip'} • ${review.cityName ?? 'India'}',
                              style: TextStyle(
                                fontSize: 12,
                                color: isDark ? AppColors.textMutedDark : AppColors.textSecondaryLight,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.star_rounded, size: 18, color: Color(0xFFF59E0B)),
                          const SizedBox(width: 2),
                          Text(
                            review.rating.toStringAsFixed(1),
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w800,
                              color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: AppSpacing.md),
                  const Divider(),
                  const SizedBox(height: AppSpacing.sm),

                  // Description
                  Text(
                    'Trip Story',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                      color: isDark ? AppColors.textMutedDark : AppColors.textSecondaryLight,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    review.comment,
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.55,
                      color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                    ),
                  ),

                  const SizedBox(height: AppSpacing.xl),

                  // Close button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 13),
                        shape: RoundedRectangleBorder(borderRadius: AppRadius.radiusLg),
                      ),
                      child: const Text(
                        'Close',
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
