import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_radius.dart';
import '../../../app/theme/app_spacing.dart';
import '../../../app/theme/app_text_styles.dart';
import '../models/rental_search_model.dart';
import '../models/vehicle_model.dart';

/// Compact summary card showing chosen vehicle, dates, and city.
class RentalBookingSummaryWidget extends StatelessWidget {
  final VehicleModel vehicle;
  final RentalSearchModel? searchModel;

  const RentalBookingSummaryWidget({
    super.key,
    required this.vehicle,
    this.searchModel,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
        borderRadius: AppRadius.radiusXl,
        border: Border.all(
          color: isDark ? AppColors.borderDark : AppColors.borderLight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Vehicle thumbnail
              ClipRRect(
                borderRadius: AppRadius.radiusMd,
                child: SizedBox(
                  width: 90,
                  height: 65,
                  child: CachedNetworkImage(
                    imageUrl: vehicle.primaryImage,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(color: Colors.grey.shade900),
                    errorWidget: (context, url, error) => Container(
                      color: Colors.grey.shade900,
                      child: const Icon(Icons.directions_car, color: Colors.white38),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      vehicle.brand.toUpperCase(),
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.6,
                        color: isDark ? AppColors.textMutedDark : AppColors.textSecondaryLight,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      vehicle.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.titleMedium(isDark).copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${vehicle.transmission} • ${vehicle.fuelType} • ${vehicle.seats} Seats',
                      style: TextStyle(
                        fontSize: 11,
                        color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          if (searchModel != null) ...[
            const SizedBox(height: AppSpacing.md),
            const Divider(height: 1),
            const SizedBox(height: AppSpacing.sm),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildTripColumn(
                  isDark,
                  'PICKUP',
                  searchModel!.pickupLocation,
                  '${searchModel!.pickupDateTime.day}/${searchModel!.pickupDateTime.month}, ${searchModel!.pickupDateTime.hour.toString().padLeft(2, "0")}:${searchModel!.pickupDateTime.minute.toString().padLeft(2, "0")}',
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: (isDark ? AppColors.surfaceVariantDark : AppColors.primaryContainer)
                        .withAlpha((255 * 0.6).round()),
                    borderRadius: AppRadius.radiusFull,
                  ),
                  child: Text(
                    '${searchModel!.durationDays} ${searchModel!.durationDays == 1 ? "day" : "days"}',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: isDark ? AppColors.primaryLight : AppColors.primary,
                    ),
                  ),
                ),
                _buildTripColumn(
                  isDark,
                  'RETURN',
                  searchModel!.dropoffLocation,
                  '${searchModel!.returnDateTime.day}/${searchModel!.returnDateTime.month}, ${searchModel!.returnDateTime.hour.toString().padLeft(2, "0")}:${searchModel!.returnDateTime.minute.toString().padLeft(2, "0")}',
                  crossAxisAlignment: CrossAxisAlignment.end,
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildTripColumn(
    bool isDark,
    String tag,
    String location,
    String time, {
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.start,
  }) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Text(
          tag,
          style: TextStyle(
            fontSize: 9,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.6,
            color: isDark ? AppColors.textMutedDark : AppColors.textSecondaryLight,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          time,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
          ),
        ),
        Text(
          location,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 10,
            color: isDark ? AppColors.textMutedDark : AppColors.textSecondaryLight,
          ),
        ),
      ],
    );
  }
}
