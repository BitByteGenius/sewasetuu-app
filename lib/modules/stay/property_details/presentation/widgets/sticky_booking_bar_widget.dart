import 'package:flutter/material.dart';
import '../../../../../app/theme/app_colors.dart';
import '../../../../../app/theme/app_radius.dart';
import '../../../../../app/theme/app_shadows.dart';
import '../../../../../app/theme/app_spacing.dart';
import '../../../../../app/theme/app_text_styles.dart';
import '../../../../../core/utils/formatters.dart';
import '../../../../../shared/widgets/app_button.dart';

/// Sticky bottom booking action bar with pricing summary and "Book Now" CTA.
class StickyBookingBarWidget extends StatelessWidget {
  final double pricePerNight;
  final double? pricePerMonth;
  final VoidCallback onBookNow;
  final bool isBooking;

  const StickyBookingBarWidget({
    super.key,
    required this.pricePerNight,
    this.pricePerMonth,
    required this.onBookNow,
    this.isBooking = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 14,
        bottom: MediaQuery.of(context).padding.bottom + 14,
      ),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
        borderRadius: AppRadius.topXl,
        boxShadow: isDark ? AppShadows.darkCard : AppShadows.bottomNav,
        border: Border(
          top: BorderSide(
            color: isDark ? AppColors.borderDark : AppColors.borderLight,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          // Pricing Breakdown
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      AppFormatters.formatCurrency(pricePerNight),
                      style: AppTextStyles.priceTag(isDark, fontSize: 22),
                    ),
                    Text(
                      ' / night',
                      style: AppTextStyles.bodySmall(isDark).copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                if (pricePerMonth != null) ...[
                  AppSpacing.gapV4,
                  Text(
                    'Or ${AppFormatters.formatCurrency(pricePerMonth!)}/mo for long stay',
                    style: AppTextStyles.labelSmall(isDark).copyWith(
                      color: isDark ? AppColors.primaryLight : AppColors.primary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ],
            ),
          ),
          // Book Now CTA
          AppButton.primary(
            text: 'Reserve / Book',
            size: AppButtonSize.large,
            isLoading: isBooking,
            onPressed: onBookNow,
          ),
        ],
      ),
    );
  }
}
