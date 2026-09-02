import 'package:flutter/material.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/app_radius.dart';
import '../../app/theme/app_text_styles.dart';

/// Badges for status, verified badges, discounts, and category pills.
class AppBadge extends StatelessWidget {
  final String text;
  final Widget? icon;
  final Color? backgroundColor;
  final Color? textColor;
  final EdgeInsetsGeometry padding;
  final BorderRadius? borderRadius;

  const AppBadge({
    super.key,
    required this.text,
    this.icon,
    this.backgroundColor,
    this.textColor,
    this.padding = const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    this.borderRadius,
  });

  const AppBadge.verified({
    super.key,
    this.text = 'Verified',
    this.icon = const Icon(Icons.verified, size: 12, color: Colors.white),
    this.backgroundColor = AppColors.badgeGreen,
    this.textColor = Colors.white,
    this.padding = const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    this.borderRadius,
  });

  const AppBadge.featured({
    super.key,
    this.text = 'Featured',
    this.icon = const Icon(Icons.star_rounded, size: 12, color: Colors.white),
    this.backgroundColor = AppColors.primary,
    this.textColor = Colors.white,
    this.padding = const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    this.borderRadius,
  });

  const AppBadge.discount({
    super.key,
    required this.text,
    this.icon,
    this.backgroundColor = AppColors.secondary,
    this.textColor = Colors.black,
    this.padding = const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final effectiveBg = backgroundColor ??
        (isDark ? AppColors.surfaceVariantDark : AppColors.surfaceVariantLight);
    final effectiveTextColor = textColor ??
        (isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight);

    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: effectiveBg,
        borderRadius: borderRadius ?? AppRadius.radiusPill,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            icon!,
            const SizedBox(width: 4),
          ],
          Text(
            text,
            style: AppTextStyles.labelSmall(isDark).copyWith(
              color: effectiveTextColor,
              fontWeight: FontWeight.w700,
              fontSize: 10.5,
            ),
          ),
        ],
      ),
    );
  }
}
