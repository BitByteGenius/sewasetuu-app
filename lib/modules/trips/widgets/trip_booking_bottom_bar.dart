import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_button.dart';

/// Fixed bottom action bar on the trip details screen displaying live pricing and the primary CTA
class TripBookingBottomBar extends StatelessWidget {
  final double totalPrice;
  final double pricePerPerson;
  final String travelerSummary;
  final VoidCallback onBookNow;
  final bool isCustomized;

  const TripBookingBottomBar({
    super.key,
    required this.totalPrice,
    required this.pricePerPerson,
    required this.travelerSummary,
    required this.onBookNow,
    this.isCustomized = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(20),
            blurRadius: 10,
            offset: const Offset(0, -3),
          ),
        ],
        border: Border(
          top: BorderSide(
            color: isDark ? AppColors.borderDark : AppColors.borderLight,
          ),
        ),
      ),
      child: SafeArea(
        child: Row(
          children: [
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
                        '₹${totalPrice.toStringAsFixed(0)}',
                        style: AppTextStyles.priceTag(isDark, fontSize: 20),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '(Total)',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: isDark
                              ? AppColors.textMutedDark
                              : AppColors.textMutedLight,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    travelerSummary,
                    style: TextStyle(
                      fontSize: 11,
                      color: isDark
                          ? AppColors.textSecondaryDark
                          : AppColors.textSecondaryLight,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            AppButton.primary(
              text: 'Book This Trip',
              icon: const Icon(Icons.arrow_forward_rounded, size: 18),
              onPressed: onBookNow,
            ),
          ],
        ),
      ),
    );
  }
}
