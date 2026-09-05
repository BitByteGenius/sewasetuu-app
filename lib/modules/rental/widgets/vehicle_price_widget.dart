import 'package:flutter/material.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_radius.dart';
import '../../../app/theme/app_spacing.dart';
import '../models/vehicle_model.dart';

/// Clean price badge and rental terms widget for vehicle details screen.
class VehiclePriceWidget extends StatelessWidget {
  final VehicleModel vehicle;

  const VehiclePriceWidget({
    super.key,
    required this.vehicle,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : AppColors.surfaceVariantLight,
        borderRadius: AppRadius.radiusLg,
        border: Border.all(
          color: isDark ? AppColors.borderDark : AppColors.borderLight,
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'DAILY RENTAL RATE',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.6,
                      color: isDark ? AppColors.textMutedDark : AppColors.textSecondaryLight,
                    ),
                  ),
                  const SizedBox(height: 2),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '₹${vehicle.pricePerDay.toInt()}',
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w900,
                            color: AppColors.primary,
                          ),
                        ),
                        TextSpan(
                          text: ' / day',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: isDark ? AppColors.textMutedDark : AppColors.textSecondaryLight,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              if (vehicle.pricePerHour > 0)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withAlpha((255 * 0.1).round()),
                    borderRadius: AppRadius.radiusMd,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'HOURLY RATE',
                        style: TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.5,
                          color: isDark ? AppColors.primaryLight : AppColors.primary,
                        ),
                      ),
                      Text(
                        '₹${vehicle.pricePerHour.toInt()}/hr',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                          color: isDark ? AppColors.primaryLight : AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          const Divider(height: 1),
          const SizedBox(height: AppSpacing.sm),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildTermItem(
                isDark,
                Icons.account_balance_wallet_outlined,
                vehicle.securityDeposit > 0
                    ? '₹${vehicle.securityDeposit.toInt()} Deposit'
                    : 'Zero Deposit',
                vehicle.securityDeposit == 0 ? AppColors.success : null,
              ),
              _buildTermItem(
                isDark,
                Icons.speed_outlined,
                'Unlimited KMs',
                null,
              ),
              _buildTermItem(
                isDark,
                Icons.cancel_outlined,
                'Free Cancel (${vehicle.freeCancellationHours}h)',
                null,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTermItem(bool isDark, IconData icon, String text, Color? color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 14,
          color: color ?? (isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight),
        ),
        const SizedBox(width: 4),
        Text(
          text,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: color ?? (isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight),
          ),
        ),
      ],
    );
  }
}
