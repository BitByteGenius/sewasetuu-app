import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

/// Centralized typography definitions.
/// Utilizes Plus Jakarta Sans for a refined, modern, luxury feel.
abstract class AppTextStyles {
  // Display / Hero Headings
  static TextStyle displayLarge(bool isDark) => GoogleFonts.plusJakartaSans(
        fontSize: 32,
        fontWeight: FontWeight.w800,
        letterSpacing: -0.8,
        color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
      );

  static TextStyle displayMedium(bool isDark) => GoogleFonts.plusJakartaSans(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.6,
        color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
      );

  static TextStyle displaySmall(bool isDark) => GoogleFonts.plusJakartaSans(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.4,
        color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
      );

  // Headlines
  static TextStyle headlineLarge(bool isDark) => GoogleFonts.plusJakartaSans(
        fontSize: 22,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.3,
        color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
      );

  static TextStyle headlineMedium(bool isDark) => GoogleFonts.plusJakartaSans(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.2,
        color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
      );

  static TextStyle headlineSmall(bool isDark) => GoogleFonts.plusJakartaSans(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
      );

  // Titles
  static TextStyle titleLarge(bool isDark) => GoogleFonts.plusJakartaSans(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.1,
        color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
      );

  static TextStyle titleMedium(bool isDark) => GoogleFonts.plusJakartaSans(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
      );

  static TextStyle titleSmall(bool isDark) => GoogleFonts.plusJakartaSans(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
      );

  // Body
  static TextStyle bodyLarge(bool isDark) => GoogleFonts.plusJakartaSans(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
        height: 1.5,
      );

  static TextStyle bodyMedium(bool isDark) => GoogleFonts.plusJakartaSans(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
        height: 1.4,
      );

  static TextStyle bodySmall(bool isDark) => GoogleFonts.plusJakartaSans(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: isDark ? AppColors.textMutedDark : AppColors.textMutedLight,
        height: 1.4,
      );

  // Label & Button
  static TextStyle labelLarge(bool isDark) => GoogleFonts.plusJakartaSans(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.1,
        color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
      );

  static TextStyle labelMedium(bool isDark) => GoogleFonts.plusJakartaSans(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
      );

  static TextStyle labelSmall(bool isDark) => GoogleFonts.plusJakartaSans(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.2,
        color: isDark ? AppColors.textMutedDark : AppColors.textMutedLight,
      );

  // Price & Numbers
  static TextStyle priceTag(bool isDark, {double fontSize = 18}) => GoogleFonts.plusJakartaSans(
        fontSize: fontSize,
        fontWeight: FontWeight.w800,
        color: AppColors.primary,
        letterSpacing: -0.2,
      );
}
