import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sewasetu/app/theme/app_colors.dart';
import 'package:sewasetu/app/theme/app_radius.dart';

/// Single navigation destination item for the Shop module navigation bar
class ShopNavigationItem extends StatelessWidget {
  final IconData outlineIcon;
  final IconData activeIcon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final int? badgeCount;

  const ShopNavigationItem({
    super.key,
    required this.outlineIcon,
    required this.activeIcon,
    required this.label,
    required this.isSelected,
    required this.onTap,
    this.badgeCount,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final effectiveActiveColor = isDark ? AppColors.primaryLight : AppColors.primary;
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
                ? effectiveActiveColor.withValues(alpha: isDark ? 0.18 : 0.10)
                : Colors.transparent,
            borderRadius: AppRadius.radiusPill,
          ),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Icon with optional live badge
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    AnimatedScale(
                      scale: isSelected ? 1.08 : 1.0,
                      duration: const Duration(milliseconds: 220),
                      curve: Curves.easeOutBack,
                      child: Icon(
                        isSelected ? activeIcon : outlineIcon,
                        size: 21,
                        color: isSelected ? effectiveActiveColor : inactiveColor,
                      ),
                    ),

                    // Reactive badge for Cart or notices
                    if (badgeCount != null && badgeCount! > 0)
                      Positioned(
                        top: -5,
                        right: -8,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 4.5,
                            vertical: 1.0,
                          ),
                          constraints: const BoxConstraints(
                            minWidth: 15,
                            minHeight: 15,
                          ),
                          decoration: BoxDecoration(
                            color: effectiveActiveColor,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: effectiveActiveColor.withValues(alpha: 0.4),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              badgeCount! > 9 ? '9+' : '$badgeCount',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 9.0,
                                fontWeight: FontWeight.w800,
                                height: 1.1,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),

                const SizedBox(height: 2),

                // Text Label
                AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 200),
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: isSelected ? 11.0 : 10.5,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                    color: isSelected ? effectiveActiveColor : inactiveColor,
                    letterSpacing: -0.2,
                    height: 1.15,
                  ),
                  child: Text(
                    label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
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
