import 'package:flutter/material.dart';

/// ThemeExtension to provide custom luxury marketplace styling tokens
/// through BuildContext (e.g., `Theme.of(context).extension<AppThemeExtension>()`).
@immutable
class AppThemeExtension extends ThemeExtension<AppThemeExtension> {
  final Color cardBorder;
  final Color shimmerBase;
  final Color shimmerHighlight;
  final Color chipBackground;
  final Color iconContainerBg;
  final Color verifiedBadge;
  final List<BoxShadow> cardShadow;

  const AppThemeExtension({
    required this.cardBorder,
    required this.shimmerBase,
    required this.shimmerHighlight,
    required this.chipBackground,
    required this.iconContainerBg,
    required this.verifiedBadge,
    required this.cardShadow,
  });

  @override
  AppThemeExtension copyWith({
    Color? cardBorder,
    Color? shimmerBase,
    Color? shimmerHighlight,
    Color? chipBackground,
    Color? iconContainerBg,
    Color? verifiedBadge,
    List<BoxShadow>? cardShadow,
  }) {
    return AppThemeExtension(
      cardBorder: cardBorder ?? this.cardBorder,
      shimmerBase: shimmerBase ?? this.shimmerBase,
      shimmerHighlight: shimmerHighlight ?? this.shimmerHighlight,
      chipBackground: chipBackground ?? this.chipBackground,
      iconContainerBg: iconContainerBg ?? this.iconContainerBg,
      verifiedBadge: verifiedBadge ?? this.verifiedBadge,
      cardShadow: cardShadow ?? this.cardShadow,
    );
  }

  @override
  AppThemeExtension lerp(ThemeExtension<AppThemeExtension>? other, double t) {
    if (other is! AppThemeExtension) return this;
    return AppThemeExtension(
      cardBorder: Color.lerp(cardBorder, other.cardBorder, t)!,
      shimmerBase: Color.lerp(shimmerBase, other.shimmerBase, t)!,
      shimmerHighlight: Color.lerp(shimmerHighlight, other.shimmerHighlight, t)!,
      chipBackground: Color.lerp(chipBackground, other.chipBackground, t)!,
      iconContainerBg: Color.lerp(iconContainerBg, other.iconContainerBg, t)!,
      verifiedBadge: Color.lerp(verifiedBadge, other.verifiedBadge, t)!,
      cardShadow: cardShadow,
    );
  }
}
