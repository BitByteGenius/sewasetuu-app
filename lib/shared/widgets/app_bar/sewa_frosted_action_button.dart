import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:sewasetu/app/theme/app_colors.dart';

/// Premium circular frosted action button for image overlays, AppBars, and Hero screens.
class SewaFrostedActionButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;
  final VoidCallback? onPressed;
  final String? tooltip;
  final double size;
  final double iconSize;
  final Color? backgroundColor;
  final Color? iconColor;
  final Widget? badge;

  const SewaFrostedActionButton({
    super.key,
    required this.icon,
    this.onTap,
    this.onPressed,
    this.tooltip,
    this.size = 40,
    this.iconSize = 18,
    this.backgroundColor,
    this.iconColor,
    this.badge,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final effectiveAction = onTap ?? onPressed;

    final defaultBg = isDark
        ? Colors.black.withValues(alpha: 0.55)
        : Colors.white.withValues(alpha: 0.85);

    final defaultFg = isDark ? Colors.white : AppColors.textPrimaryLight;

    Widget button = ClipOval(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Material(
          color: backgroundColor ?? defaultBg,
          shape: const CircleBorder(),
          child: InkWell(
            onTap: effectiveAction,
            customBorder: const CircleBorder(),
            child: SizedBox(
              width: size,
              height: size,
              child: Center(
                child: Icon(
                  icon,
                  size: iconSize,
                  color: iconColor ?? defaultFg,
                ),
              ),
            ),
          ),
        ),
      ),
    );

    if (tooltip != null) {
      button = Tooltip(message: tooltip!, child: button);
    }

    if (badge != null) {
      button = Stack(
        clipBehavior: Clip.none,
        children: [
          button,
          Positioned(
            top: -2,
            right: -2,
            child: badge!,
          ),
        ],
      );
    }

    return button;
  }
}
