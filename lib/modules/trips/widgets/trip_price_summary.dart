import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_radius.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_card.dart';
import '../controllers/trip_details_controller.dart';

/// Financial breakdown card for selected trip package, party size, and taxes
class TripPriceSummary extends StatelessWidget {
  final TripDetailsController controller;

  const TripPriceSummary({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final package = controller.package;
    final travelers = controller.travelers.value;

    return AppCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.receipt_long_rounded,
                  size: 20, color: AppColors.primary),
              const SizedBox(width: 8),
              Text(
                'Fare Breakdown',
                style: AppTextStyles.titleMedium(isDark).copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          AppSpacing.gapV12,

          // Adults Fare Row
          _buildRow(
            label:
                'Adults (${travelers.adults} × ₹${package.basePrice.toStringAsFixed(0)})',
            value: '₹${controller.adultSubtotal.toStringAsFixed(0)}',
            isDark: isDark,
          ),

          // Children Fare Row (if any)
          if (travelers.children > 0) ...[
            const SizedBox(height: 8),
            _buildRow(
              label:
                  'Children (${travelers.children} × ₹${(package.basePrice * 0.6).toStringAsFixed(0)})',
              value: '₹${controller.childSubtotal.toStringAsFixed(0)}',
              isDark: isDark,
            ),
          ],

          const SizedBox(height: 8),
          _buildRow(
            label: 'GST & Tourism Taxes (5%)',
            value: '₹${controller.gstTax.toStringAsFixed(0)}',
            isDark: isDark,
          ),

          const Divider(height: 20),

          // Grand Total
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Payable',
                style: AppTextStyles.titleMedium(isDark).copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
              Text(
                '₹${controller.grandTotal.toStringAsFixed(0)}',
                style: AppTextStyles.priceTag(isDark, fontSize: 18),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Flexible Advance Booking Deposit Badge
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.green.withAlpha(isDark ? 30 : 20),
              borderRadius: AppRadius.radiusSm,
              border: Border.all(color: Colors.green.withAlpha(60)),
            ),
            child: Row(
              children: [
                const Icon(Icons.verified_rounded,
                    color: Colors.green, size: 16),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Book now by paying only 25% deposit (₹${controller.bookingDeposit.toStringAsFixed(0)}). Remaining on arrival.',
                    style: const TextStyle(
                      fontSize: 11.5,
                      fontWeight: FontWeight.w600,
                      color: Colors.green,
                      height: 1.3,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRow({
    required String label,
    required String value,
    required bool isDark,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTextStyles.bodyMedium(isDark).copyWith(
            color: isDark
                ? AppColors.textSecondaryDark
                : AppColors.textSecondaryLight,
            fontSize: 13,
          ),
        ),
        Text(
          value,
          style: AppTextStyles.titleSmall(isDark).copyWith(
            fontWeight: FontWeight.w700,
            fontSize: 13.5,
          ),
        ),
      ],
    );
  }
}
