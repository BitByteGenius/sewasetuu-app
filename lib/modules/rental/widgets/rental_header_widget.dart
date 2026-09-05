import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_radius.dart';
import '../../../app/theme/app_spacing.dart';
import '../../../app/theme/app_text_styles.dart';
import '../screens/rental_bookings_screen.dart';
import 'city_selector_widget.dart';

/// Top bar header for the Rental module with greeting, city pill, and bookings action.
class RentalHeaderWidget extends StatelessWidget {
  final VoidCallback? onNotificationTap;

  const RentalHeaderWidget({
    super.key,
    this.onNotificationTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.sm,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: AppRadius.radiusXs,
                      ),
                      child: const Text(
                        'SEWASETU RENTALS',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.8,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  'Explore your next ride',
                  style: AppTextStyles.headlineSmall(isDark).copyWith(
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.4,
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CitySelectorWidget(isCompact: true),
              const SizedBox(width: AppSpacing.sm),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => Get.to(() => const RentalBookingsScreen()),
                  borderRadius: AppRadius.radiusFull,
                  child: Container(
                    padding: const EdgeInsets.all(AppSpacing.sm),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isDark ? AppColors.surfaceVariantDark : AppColors.surfaceVariantLight,
                      border: Border.all(
                        color: isDark ? AppColors.borderDark : AppColors.borderLight,
                      ),
                    ),
                    child: const Icon(
                      Icons.receipt_long_outlined,
                      size: 20,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
