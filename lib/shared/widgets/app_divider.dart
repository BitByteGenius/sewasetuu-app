import 'package:flutter/material.dart';
import '../../app/theme/app_colors.dart';

/// Reusable styled divider component with dark/light mode support.
class AppDivider extends StatelessWidget {
  final double height;
  final double thickness;
  final double indent;
  final double endIndent;
  final Color? color;

  const AppDivider({
    super.key,
    this.height = 1.0,
    this.thickness = 1.0,
    this.indent = 0.0,
    this.endIndent = 0.0,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final effectiveColor = color ?? (isDark ? AppColors.borderDark : AppColors.borderLight);

    return Divider(
      height: height,
      thickness: thickness,
      indent: indent,
      endIndent: endIndent,
      color: effectiveColor,
    );
  }
}
