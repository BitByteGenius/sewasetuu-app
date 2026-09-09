import 'package:flutter/material.dart';
import 'package:sewasetu/app/theme/app_colors.dart';
import 'package:sewasetu/app/theme/app_radius.dart';

/// Automotive styled navigation item for the Vehicle Rental navigation bar
class RentalNavigationItem extends StatelessWidget {
  final IconData outlineIcon;
  final IconData activeIcon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final Color? activeColor;

  const RentalNavigationItem({
    super.key,
    required this.outlineIcon,
    required this.activeIcon,
    required this.label,
    required this.isSelected,
    required this.onTap,
    this.activeColor,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final effectiveActiveColor =
        activeColor ?? (isDark ? AppColors.primaryLight : AppColors.primary);
    final inactiveColor = isDark
        ? AppColors.textMutedDark
        : AppColors.textSecondaryLight;

    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 2),
          decoration: BoxDecoration(
            color: isSelected
                ? effectiveActiveColor.withValues(alpha: isDark ? 0.16 : 0.08)
                : Colors.transparent,
            borderRadius: AppRadius.radiusPill,
          ),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedScale(
                  scale: isSelected ? 1.08 : 1.0,
                  duration: const Duration(milliseconds: 220),
                  curve: Curves.easeOutBack,
                  child: Icon(
                    isSelected ? activeIcon : outlineIcon,
                    size: 22,
                    color: isSelected ? effectiveActiveColor : inactiveColor,
                  ),
                ),
                const SizedBox(height: 2),
                AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 200),
                  style: TextStyle(
                    fontSize: isSelected ? 11.0 : 10.5,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                    color: isSelected ? effectiveActiveColor : inactiveColor,
                    letterSpacing: -0.1,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  child: Text(label),
                ),
                const SizedBox(height: 2),
                // Subtle cockpit neon bar indicator
                AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  width: isSelected ? 14 : 0,
                  height: 2,
                  decoration: BoxDecoration(
                    color: isSelected ? effectiveActiveColor : Colors.transparent,
                    borderRadius: BorderRadius.circular(2),
                    boxShadow: isSelected
                        ? [
                            BoxShadow(
                              color: effectiveActiveColor.withValues(alpha: 0.6),
                              blurRadius: 4,
                              spreadRadius: 0.5,
                            ),
                          ]
                        : null,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
