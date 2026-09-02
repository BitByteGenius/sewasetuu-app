import 'package:flutter/material.dart';
import 'package:sewasetu/app/theme/app_colors.dart';
import 'package:sewasetu/app/theme/app_radius.dart';
import 'package:sewasetu/app/theme/app_text_styles.dart';

/// Tactile increment / decrement counter stepper for guest count and room selection
class AppCounterStepper extends StatelessWidget {
  final int value;
  final int min;
  final int max;
  final ValueChanged<int> onChanged;
  final String? label;
  final String? subtitle;

  const AppCounterStepper({
    super.key,
    required this.value,
    this.min = 0,
    this.max = 20,
    required this.onChanged,
    this.label,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final canDecrement = value > min;
    final canIncrement = value < max;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (label != null)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  label!,
                  style: AppTextStyles.titleMedium(isDark).copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    subtitle!,
                    style: AppTextStyles.bodySmall(isDark),
                  ),
                ],
              ],
            ),
          ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildButton(
              context: context,
              icon: Icons.remove_rounded,
              isEnabled: canDecrement,
              isDark: isDark,
              onTap: canDecrement ? () => onChanged(value - 1) : null,
            ),
            SizedBox(
              width: 44,
              child: Center(
                child: Text(
                  '$value',
                  style: AppTextStyles.titleMedium(isDark).copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
            _buildButton(
              context: context,
              icon: Icons.add_rounded,
              isEnabled: canIncrement,
              isDark: isDark,
              onTap: canIncrement ? () => onChanged(value + 1) : null,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildButton({
    required BuildContext context,
    required IconData icon,
    required bool isEnabled,
    required bool isDark,
    required VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: AppRadius.radiusPill,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: isEnabled
                ? (isDark ? AppColors.borderDark : AppColors.borderLight)
                : (isDark ? AppColors.borderDark.withAlpha(80) : AppColors.borderLight.withAlpha(120)),
          ),
          color: isEnabled
              ? (isDark ? AppColors.surfaceVariantDark : Colors.white)
              : Colors.transparent,
        ),
        child: Center(
          child: Icon(
            icon,
            size: 18,
            color: isEnabled
                ? (isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight)
                : (isDark ? AppColors.textMutedDark : AppColors.textMutedLight),
          ),
        ),
      ),
    );
  }
}
