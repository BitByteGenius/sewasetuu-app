import 'package:flutter/material.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/app_radius.dart';
import '../../app/theme/app_shadows.dart';

/// Premium card container with customizable padding, border, elevation shadows and tap callback.
class AppCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final BorderRadius? borderRadius;
  final Border? border;
  final List<BoxShadow>? shadows;
  final double? width;
  final double? height;

  const AppCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.onTap,
    this.backgroundColor,
    this.borderRadius,
    this.border,
    this.shadows,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final effectiveRadius = borderRadius ?? AppRadius.radiusLg;
    final effectiveBg = backgroundColor ?? (isDark ? AppColors.cardDark : AppColors.cardLight);
    final effectiveBorder = border ??
        Border.all(
          color: isDark ? AppColors.borderDark : AppColors.borderLight,
          width: 1,
        );
    final effectiveShadow = shadows ?? (isDark ? AppShadows.darkCard : AppShadows.card);

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: effectiveBg,
        borderRadius: effectiveRadius,
        border: effectiveBorder,
        boxShadow: effectiveShadow,
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: effectiveRadius,
        child: InkWell(
          onTap: onTap,
          borderRadius: effectiveRadius,
          child: Padding(
            padding: padding,
            child: child,
          ),
        ),
      ),
    );
  }
}
