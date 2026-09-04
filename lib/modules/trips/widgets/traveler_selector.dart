import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_card.dart';
import '../models/traveler_model.dart';

/// Interactive counter widget for selecting adults, children, and room count
class TravelerSelector extends StatelessWidget {
  final TravelerModel travelers;
  final ValueChanged<TravelerModel> onChanged;
  final int maxTravelers;
  final int minTravelers;

  const TravelerSelector({
    super.key,
    required this.travelers,
    required this.onChanged,
    this.maxTravelers = 15,
    this.minTravelers = 1,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return AppCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.people_alt_outlined,
                  size: 20, color: AppColors.primary),
              const SizedBox(width: 8),
              Text(
                'Travelers & Rooms',
                style: AppTextStyles.titleMedium(isDark).copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          AppSpacing.gapV16,

          // 1. Adults Stepper (Age 12+)
          _buildCounterRow(
            context: context,
            isDark: isDark,
            title: 'Adults',
            subtitle: 'Age 12 years and above',
            count: travelers.adults,
            canDecrement: travelers.adults > minTravelers,
            canIncrement: travelers.totalTravelers < maxTravelers,
            onDecrement: () {
              if (travelers.adults > minTravelers) {
                // Auto-adjust rooms if adults drop
                final newAdults = travelers.adults - 1;
                final newRooms =
                    travelers.rooms > newAdults ? newAdults : travelers.rooms;
                onChanged(travelers.copyWith(
                  adults: newAdults,
                  rooms: newRooms > 0 ? newRooms : 1,
                ));
              }
            },
            onIncrement: () {
              if (travelers.totalTravelers < maxTravelers) {
                onChanged(travelers.copyWith(adults: travelers.adults + 1));
              }
            },
          ),
          const Divider(height: 24),

          // 2. Children Stepper (Age 2 - 11)
          _buildCounterRow(
            context: context,
            isDark: isDark,
            title: 'Children',
            subtitle: 'Age 2 to 11 years (40% discount)',
            count: travelers.children,
            canDecrement: travelers.children > 0,
            canIncrement: travelers.totalTravelers < maxTravelers,
            onDecrement: () {
              if (travelers.children > 0) {
                onChanged(travelers.copyWith(children: travelers.children - 1));
              }
            },
            onIncrement: () {
              if (travelers.totalTravelers < maxTravelers) {
                onChanged(travelers.copyWith(children: travelers.children + 1));
              }
            },
          ),
          const Divider(height: 24),

          // 3. Rooms Stepper
          _buildCounterRow(
            context: context,
            isDark: isDark,
            title: 'Rooms',
            subtitle: 'Suggested: 2 travelers per room',
            count: travelers.rooms,
            canDecrement: travelers.rooms > 1,
            canIncrement: travelers.rooms < travelers.adults,
            onDecrement: () {
              if (travelers.rooms > 1) {
                onChanged(travelers.copyWith(rooms: travelers.rooms - 1));
              }
            },
            onIncrement: () {
              if (travelers.rooms < travelers.adults) {
                onChanged(travelers.copyWith(rooms: travelers.rooms + 1));
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCounterRow({
    required BuildContext context,
    required bool isDark,
    required String title,
    required String subtitle,
    required int count,
    required bool canDecrement,
    required bool canIncrement,
    required VoidCallback onDecrement,
    required VoidCallback onIncrement,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTextStyles.titleSmall(isDark).copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: AppTextStyles.bodySmall(isDark).copyWith(
                  fontSize: 11.5,
                  color: isDark
                      ? AppColors.textMutedDark
                      : AppColors.textSecondaryLight,
                ),
              ),
            ],
          ),
        ),
        Row(
          children: [
            _buildRoundBtn(
              icon: Icons.remove,
              isEnabled: canDecrement,
              isDark: isDark,
              onTap: onDecrement,
            ),
            SizedBox(
              width: 36,
              child: Center(
                child: Text(
                  '$count',
                  style: AppTextStyles.titleMedium(isDark).copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
            _buildRoundBtn(
              icon: Icons.add,
              isEnabled: canIncrement,
              isDark: isDark,
              onTap: onIncrement,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRoundBtn({
    required IconData icon,
    required bool isEnabled,
    required bool isDark,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: isEnabled ? onTap : null,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: 34,
        height: 34,
        decoration: BoxDecoration(
          color: isEnabled
              ? (isDark
                  ? AppColors.surfaceVariantDark
                  : AppColors.surfaceVariantLight)
              : Colors.transparent,
          shape: BoxShape.circle,
          border: Border.all(
            color: isEnabled
                ? (isDark ? AppColors.primaryLight : AppColors.primary)
                : (isDark ? Colors.white12 : Colors.black12),
          ),
        ),
        child: Icon(
          icon,
          size: 16,
          color: isEnabled
              ? (isDark ? AppColors.primaryLight : AppColors.primary)
              : (isDark ? Colors.white24 : Colors.black26),
        ),
      ),
    );
  }
}
