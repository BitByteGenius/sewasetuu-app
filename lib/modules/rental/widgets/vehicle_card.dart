import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_radius.dart';
import '../../../app/theme/app_shadows.dart';
import '../../../app/theme/app_spacing.dart';
import '../../../app/theme/app_text_styles.dart';
import '../controllers/rental_favorites_controller.dart';
import '../models/vehicle_model.dart';
import '../screens/vehicle_details_screen.dart';

/// Premium vehicle card for catalog feeds, popular lists, and search results.
class VehicleCard extends StatelessWidget {
  final VehicleModel vehicle;
  final VoidCallback? onTap;

  const VehicleCard({
    super.key,
    required this.vehicle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final favCtrl = Get.isRegistered<RentalFavoritesController>()
        ? Get.find<RentalFavoritesController>()
        : null;

    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
        borderRadius: AppRadius.radiusXl,
        boxShadow: AppShadows.card,
        border: Border.all(
          color: isDark ? AppColors.borderDark : AppColors.borderLight,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap ?? () => Get.to(() => const VehicleDetailsScreen(), arguments: vehicle),
          borderRadius: AppRadius.radiusXl,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Vehicle Image with Badges
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(AppRadius.xl)),
                    child: AspectRatio(
                      aspectRatio: 16 / 9.5,
                      child: CachedNetworkImage(
                        imageUrl: vehicle.primaryImage,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          color: isDark ? AppColors.surfaceVariantDark : AppColors.shimmerBase,
                          child: const Center(
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                        ),
                        errorWidget: (context, url, error) => Container(
                          color: isDark ? AppColors.surfaceVariantDark : AppColors.surfaceVariantLight,
                          child: const Icon(Icons.directions_car, color: Colors.grey, size: 48),
                        ),
                      ),
                    ),
                  ),

                  // Top Gradient for badge legibility
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    height: 50,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black.withAlpha((255 * 0.45).round()),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Left Badges
                  Positioned(
                    top: AppSpacing.sm,
                    left: AppSpacing.sm,
                    child: Row(
                      children: [
                        if (vehicle.isPremium)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            margin: const EdgeInsets.only(right: 4),
                            decoration: BoxDecoration(
                              color: AppColors.secondary,
                              borderRadius: AppRadius.radiusXs,
                            ),
                            child: const Text(
                              'PREMIUM',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 9,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 0.6,
                              ),
                            ),
                          ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: Colors.black.withAlpha((255 * 0.75).round()),
                            borderRadius: AppRadius.radiusXs,
                          ),
                          child: Text(
                            vehicle.category.toUpperCase(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 9,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Right Favorite Button
                  if (favCtrl != null)
                    Positioned(
                      top: AppSpacing.sm,
                      right: AppSpacing.sm,
                      child: Obx(() {
                        final isFav = favCtrl.isFavorite(vehicle.id);
                        return Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () => favCtrl.toggleFavorite(vehicle),
                            borderRadius: AppRadius.radiusFull,
                            child: Container(
                              padding: const EdgeInsets.all(AppSpacing.xs + 2),
                              decoration: BoxDecoration(
                                color: Colors.white.withAlpha((255 * 0.9).round()),
                                shape: BoxShape.circle,
                                boxShadow: AppShadows.soft,
                              ),
                              child: Icon(
                                isFav ? Icons.favorite : Icons.favorite_border,
                                size: 18,
                                color: isFav ? Colors.redAccent : Colors.black87,
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                ],
              ),

              // 2. Details Body
              Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Brand & Rating Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          vehicle.brand.toUpperCase(),
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.8,
                            color: isDark ? AppColors.textMutedDark : AppColors.textSecondaryLight,
                          ),
                        ),
                        Row(
                          children: [
                            const Icon(Icons.star_rounded, size: 16, color: AppColors.secondary),
                            const SizedBox(width: 2),
                            Text(
                              vehicle.rating.toStringAsFixed(1),
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                              ),
                            ),
                            if (vehicle.reviewCount > 0)
                              Text(
                                ' (${vehicle.reviewCount})',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: isDark ? AppColors.textMutedDark : AppColors.textMutedLight,
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),

                    // Vehicle Name
                    Text(
                      vehicle.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.titleLarge(isDark).copyWith(
                        fontWeight: FontWeight.w800,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sm),

                    // Key Specs row
                    Row(
                      children: [
                        _buildSpecDot(isDark, vehicle.transmission),
                        _buildDividerDot(isDark),
                        _buildSpecDot(isDark, vehicle.fuelType),
                        _buildDividerDot(isDark),
                        _buildSpecDot(
                          isDark,
                          vehicle.isTwoWheeler ? '2-Wheeler' : '${vehicle.seats} Seats',
                        ),
                      ],
                    ),

                    const SizedBox(height: AppSpacing.md),
                    const Divider(height: 1),
                    const SizedBox(height: AppSpacing.sm),

                    // Price & Action
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: '₹${vehicle.pricePerDay.toInt().toString()}',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w800,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                  TextSpan(
                                    text: ' / day',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: isDark ? AppColors.textMutedDark : AppColors.textSecondaryLight,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (vehicle.securityDeposit > 0)
                              Text(
                                '₹${vehicle.securityDeposit.toInt()} refundable deposit',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: isDark ? AppColors.textMutedDark : AppColors.textMutedLight,
                                ),
                              )
                            else
                              const Text(
                                'Zero deposit',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.success,
                                ),
                              ),
                          ],
                        ),
                        ElevatedButton(
                          onPressed: onTap ?? () => Get.to(() => const VehicleDetailsScreen(), arguments: vehicle),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppSpacing.md + 4,
                              vertical: AppSpacing.xs + 2,
                            ),
                            shape: const RoundedRectangleBorder(
                              borderRadius: AppRadius.radiusFull,
                            ),
                            elevation: 0,
                          ),
                          child: const Text(
                            'Rent Ride',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
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
      ),
    );
  }

  Widget _buildSpecDot(bool isDark, String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
      ),
    );
  }

  Widget _buildDividerDot(bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: Text(
        '•',
        style: TextStyle(
          color: isDark ? AppColors.textMutedDark : AppColors.textMutedLight,
          fontSize: 10,
        ),
      ),
    );
  }
}
