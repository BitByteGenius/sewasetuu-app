import 'package:flutter/material.dart';

/// Centralized color palette for light and dark modes.
/// Designed for a premium, trustworthy accommodation & multi-service marketplace.
abstract class AppColors {
  // Brand Colors - Deep Emerald / Luxury Teal & Warm Amber
  static const Color primary = Color(0xFF0F766E); // Deep Teal
  static const Color primaryDark = Color(0xFF0D5F58);
  static const Color primaryLight = Color(0xFF14B8A6);
  static const Color primaryContainer = Color(0xFFCCFBF1);
  static const Color primaryContainerDark = Color(0xFF134E4A);

  static const Color secondary = Color(0xFFF59E0B); // Amber / Gold Accent
  static const Color secondaryDark = Color(0xFFD97706);
  static const Color secondaryLight = Color(0xFFFCD34D);

  static const Color tertiary = Color(0xFF6366F1); // Indigo Accent for Trips/Rentals
  static const Color tertiaryLight = Color(0xFFA5B4FC);

  // Status & Feedback Colors
  static const Color success = Color(0xFF10B981);
  static const Color successLight = Color(0xFFD1FAE5);
  static const Color error = Color(0xFFEF4444);
  static const Color errorLight = Color(0xFFFEE2E2);
  static const Color warning = Color(0xFFF59E0B);
  static const Color warningLight = Color(0xFFFEF3C7);
  static const Color info = Color(0xFF3B82F6);
  static const Color infoLight = Color(0xFFDBEAFE);

  // Neutral Colors (Light Palette)
  static const Color backgroundLight = Color(0xFFF8FAFC); // Slate 50
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color surfaceVariantLight = Color(0xFFF1F5F9); // Slate 100
  static const Color cardLight = Color(0xFFFFFFFF);
  static const Color borderLight = Color(0xFFE2E8F0); // Slate 200
  static const Color dividerLight = Color(0xFFF1F5F9);

  // Text Colors (Light)
  static const Color textPrimaryLight = Color(0xFF0F172A); // Slate 900
  static const Color textSecondaryLight = Color(0xFF475569); // Slate 600
  static const Color textMutedLight = Color(0xFF94A3B8); // Slate 400
  static const Color textWhite = Color(0xFFFFFFFF);

  // Neutral Colors (Dark Palette)
  static const Color backgroundDark = Color(0xFF0F172A); // Slate 900
  static const Color surfaceDark = Color(0xFF1E293B); // Slate 800
  static const Color surfaceVariantDark = Color(0xFF334155); // Slate 700
  static const Color cardDark = Color(0xFF1E293B);
  static const Color borderDark = Color(0xFF334155);
  static const Color dividerDark = Color(0xFF1E293B);

  // Text Colors (Dark)
  static const Color textPrimaryDark = Color(0xFFF8FAFC); // Slate 50
  static const Color textSecondaryDark = Color(0xFFCBD5E1); // Slate 300
  static const Color textMutedDark = Color(0xFF64748B); // Slate 500

  // Overlay & Shimmer
  static const Color overlayDark = Color(0x66000000);
  static const Color shimmerBase = Color(0xFFE2E8F0);
  static const Color shimmerHighlight = Color(0xFFF8FAFC);
  static const Color shimmerBaseDark = Color(0xFF334155);
  static const Color shimmerHighlightDark = Color(0xFF475569);

  // Rating & Badge
  static const Color starGold = Color(0xFFFBBF24);
  static const Color badgeGreen = Color(0xFF059669);
}
