import 'package:flutter/material.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_radius.dart';
import '../../../app/theme/app_spacing.dart';
import '../../../app/theme/app_text_styles.dart';

/// Clean, informative empty state widget tailored for vehicle rentals.
class RentalEmptyState extends StatelessWidget {
  final IconData icon;
  final String title;
  final String message;
  final String? actionText;
  final VoidCallback? onAction;

  const RentalEmptyState({
    super.key,
    this.icon = Icons.directions_car_outlined,
    required this.title,
    required this.message,
    this.actionText,
    this.onAction,
  });

  factory RentalEmptyState.noVehicles({
    VoidCallback? onResetFilters,
  }) {
    return RentalEmptyState(
      icon: Icons.no_crash_outlined,
      title: 'No Vehicles Found',
      message:
          'No vehicles match your selected dates, vehicle category, or filter criteria. Try adjusting your parameters.',
      actionText: onResetFilters != null ? 'Reset Filters' : null,
      onAction: onResetFilters,
    );
  }

  factory RentalEmptyState.comingSoonCity({
    required String cityName,
    VoidCallback? onSwitchCity,
  }) {
    return RentalEmptyState(
      icon: Icons.location_city_outlined,
      title: 'Launching Soon in $cityName',
      message:
          'We are actively preparing curated bikes, SUVs, and cars for $cityName in Phase 2. Please choose an available city for now.',
      actionText: onSwitchCity != null ? 'Select Another City' : null,
      onAction: onSwitchCity,
    );
  }

  factory RentalEmptyState.noBookings({
    VoidCallback? onExplore,
  }) {
    return RentalEmptyState(
      icon: Icons.car_rental_outlined,
      title: 'No Rental Bookings Yet',
      message:
          'You haven\'t reserved any vehicles yet. Find the perfect ride for your next road trip or weekend getaway.',
      actionText: onExplore != null ? 'Explore Vehicles' : null,
      onAction: onExplore,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xxl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                color: (isDark ? AppColors.surfaceVariantDark : AppColors.primaryContainer)
                    .withAlpha((255 * 0.7).round()),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 44,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              title,
              style: AppTextStyles.headlineSmall(isDark),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              message,
              style: AppTextStyles.bodyMedium(isDark).copyWith(
                color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
              ),
              textAlign: TextAlign.center,
            ),
            if (actionText != null && onAction != null) ...[
              const SizedBox(height: AppSpacing.xl),
              ElevatedButton(
                onPressed: onAction,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.xxl,
                    vertical: AppSpacing.md,
                  ),
                  shape: const RoundedRectangleBorder(
                    borderRadius: AppRadius.radiusFull,
                  ),
                  elevation: 0,
                ),
                child: Text(
                  actionText!,
                  style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
