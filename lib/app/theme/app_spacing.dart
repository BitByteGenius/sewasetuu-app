import 'package:flutter/material.dart';

/// Centralized 4px grid spacing system.
abstract class AppSpacing {
  static const double xxs = 2.0;
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 12.0;
  static const double lg = 16.0;
  static const double xl = 20.0;
  static const double xxl = 24.0;
  static const double xxxl = 32.0;
  static const double huge = 48.0;
  static const double massive = 64.0;

  // Pre-configured EdgeInsets for consistency
  static const EdgeInsets edgeInsetsZero = EdgeInsets.zero;
  static const EdgeInsets edgeInsetsXs = EdgeInsets.all(xs);
  static const EdgeInsets edgeInsetsSm = EdgeInsets.all(sm);
  static const EdgeInsets edgeInsetsMd = EdgeInsets.all(md);
  static const EdgeInsets edgeInsetsLg = EdgeInsets.all(lg);
  static const EdgeInsets edgeInsetsXl = EdgeInsets.all(xl);
  static const EdgeInsets edgeInsetsXxl = EdgeInsets.all(xxl);

  // Horizontal Insets
  static const EdgeInsets horizontalSm = EdgeInsets.symmetric(horizontal: sm);
  static const EdgeInsets horizontalMd = EdgeInsets.symmetric(horizontal: md);
  static const EdgeInsets horizontalLg = EdgeInsets.symmetric(horizontal: lg);
  static const EdgeInsets horizontalXl = EdgeInsets.symmetric(horizontal: xl);
  static const EdgeInsets horizontalXxl = EdgeInsets.symmetric(horizontal: xxl);

  // Vertical Insets
  static const EdgeInsets verticalSm = EdgeInsets.symmetric(vertical: sm);
  static const EdgeInsets verticalMd = EdgeInsets.symmetric(vertical: md);
  static const EdgeInsets verticalLg = EdgeInsets.symmetric(vertical: lg);
  static const EdgeInsets verticalXl = EdgeInsets.symmetric(vertical: xl);

  // Screen Padding
  static const EdgeInsets screenPadding = EdgeInsets.symmetric(horizontal: lg, vertical: md);

  // Spacers (SizedBox helpers)
  static const SizedBox gapH4 = SizedBox(width: xs);
  static const SizedBox gapH8 = SizedBox(width: sm);
  static const SizedBox gapH12 = SizedBox(width: md);
  static const SizedBox gapH16 = SizedBox(width: lg);
  static const SizedBox gapH20 = SizedBox(width: xl);
  static const SizedBox gapH24 = SizedBox(width: xxl);
  static const SizedBox gapH32 = SizedBox(width: xxxl);

  static const SizedBox gapV4 = SizedBox(height: xs);
  static const SizedBox gapV8 = SizedBox(height: sm);
  static const SizedBox gapV12 = SizedBox(height: md);
  static const SizedBox gapV16 = SizedBox(height: lg);
  static const SizedBox gapV20 = SizedBox(height: xl);
  static const SizedBox gapV24 = SizedBox(height: xxl);
  static const SizedBox gapV32 = SizedBox(height: xxxl);
  static const SizedBox gapV48 = SizedBox(height: huge);
}
