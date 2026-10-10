import 'package:flutter/material.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/app_radius.dart';
import '../../app/theme/app_text_styles.dart';

/// Reusable List Tile for settings, profile items, search options, and navigation lists.
class AppListTile extends StatelessWidget {
  final Widget? leading;
  final IconData? leadingIcon;
  final Color? leadingIconColor;
  final Color? leadingBackgroundColor;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry padding;
  final bool showChevron;
  final BorderRadius? borderRadius;

  const AppListTile({
    super.key,
    this.leading,
    this.leadingIcon,
    this.leadingIconColor,
    this.leadingBackgroundColor,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    this.showChevron = false,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    Widget? effectiveLeading = leading;
    if (effectiveLeading == null && leadingIcon != null) {
      final iconColor = leadingIconColor ?? (isDark ? AppColors.primaryLight : AppColors.primary);
      final bgColor = leadingBackgroundColor ??
          (isDark ? AppColors.surfaceVariantDark : AppColors.primaryContainer);

      effectiveLeading = Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: AppRadius.radiusMd,
        ),
        child: Icon(leadingIcon, size: 20, color: iconColor),
      );
    }

    Widget? effectiveTrailing = trailing;
    if (effectiveTrailing == null && showChevron) {
      effectiveTrailing = Icon(
        Icons.chevron_right_rounded,
        color: isDark ? AppColors.textMutedDark : AppColors.textMutedLight,
        size: 20,
      );
    }

    return Material(
      color: Colors.transparent,
      borderRadius: borderRadius ?? AppRadius.radiusMd,
      child: InkWell(
        onTap: onTap,
        borderRadius: borderRadius ?? AppRadius.radiusMd,
        child: Padding(
          padding: padding,
          child: Row(
            children: [
              if (effectiveLeading != null) ...[
                effectiveLeading,
                const SizedBox(width: 14),
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style: AppTextStyles.titleMedium(isDark).copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (subtitle != null) ...[
                      const SizedBox(height: 2),
                      Text(
                        subtitle!,
                        style: AppTextStyles.bodySmall(isDark).copyWith(
                          color: isDark ? AppColors.textMutedDark : AppColors.textSecondaryLight,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              if (effectiveTrailing != null) ...[
                const SizedBox(width: 12),
                effectiveTrailing,
              ],
            ],
          ),
        ),
      ),
    );
  }
}
