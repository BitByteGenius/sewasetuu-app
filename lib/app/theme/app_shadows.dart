import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Sophisticated modern shadows for cards, buttons, and floating panels.
abstract class AppShadows {
  static List<BoxShadow> soft = [
    BoxShadow(
      color: Colors.black.withAlpha((255 * 0.04).round()),
      blurRadius: 10,
      offset: const Offset(0, 2),
    ),
  ];

  static List<BoxShadow> sm = soft;

  static List<BoxShadow> card = [
    BoxShadow(
      color: Colors.black.withAlpha((255 * 0.06).round()),
      blurRadius: 16,
      offset: const Offset(0, 4),
      spreadRadius: -2,
    ),
  ];

  static List<BoxShadow> md = card;

  static List<BoxShadow> floating = [
    BoxShadow(
      color: Colors.black.withAlpha((255 * 0.10).round()),
      blurRadius: 24,
      offset: const Offset(0, 8),
      spreadRadius: -4,
    ),
  ];

  static List<BoxShadow> bottomNav = [
    BoxShadow(
      color: Colors.black.withAlpha((255 * 0.08).round()),
      blurRadius: 20,
      offset: const Offset(0, -4),
    ),
  ];

  static List<BoxShadow> topNav = bottomNav;

  static List<BoxShadow> primaryGlow = [
    BoxShadow(
      color: AppColors.primary.withAlpha((255 * 0.35).round()),
      blurRadius: 16,
      offset: const Offset(0, 6),
    ),
  ];

  // Dark Mode Shadows
  static List<BoxShadow> darkCard = [
    BoxShadow(
      color: Colors.black.withAlpha((255 * 0.35).round()),
      blurRadius: 16,
      offset: const Offset(0, 4),
    ),
  ];
}
