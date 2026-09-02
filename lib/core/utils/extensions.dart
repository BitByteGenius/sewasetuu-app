import 'package:flutter/material.dart';
import '../../app/theme/app_theme_extensions.dart';

/// Context extensions for easy access to theme tokens, media queries, and extensions.
extension BuildContextExtensions on BuildContext {
  ThemeData get theme => Theme.of(this);
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
  TextTheme get textTheme => Theme.of(this).textTheme;
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;
  
  AppThemeExtension get customTheme =>
      Theme.of(this).extension<AppThemeExtension>() ??
      const AppThemeExtension(
        cardBorder: Colors.transparent,
        shimmerBase: Colors.grey,
        shimmerHighlight: Colors.white,
        chipBackground: Colors.grey,
        iconContainerBg: Colors.teal,
        verifiedBadge: Colors.green,
        cardShadow: [],
      );

  // Screen Dimensions
  double get screenWidth => MediaQuery.of(this).size.width;
  double get screenHeight => MediaQuery.of(this).size.height;
  EdgeInsets get padding => MediaQuery.of(this).padding;
  EdgeInsets get viewInsets => MediaQuery.of(this).viewInsets;

  // Responsive breakpoints
  bool get isSmallPhone => screenWidth < 360;
  bool get isTablet => screenWidth >= 600;
  bool get isDesktop => screenWidth >= 1024;
}

/// String utility extensions
extension StringExtensions on String {
  String get capitalizeFirstLetter {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }

  String get initials {
    if (trim().isEmpty) return '';
    final parts = trim().split(RegExp(r'\s+'));
    if (parts.length == 1) return parts[0].substring(0, 1).toUpperCase();
    return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
  }
}
