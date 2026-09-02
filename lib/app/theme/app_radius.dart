import 'package:flutter/material.dart';

/// Centralized border radii tokens.
abstract class AppRadius {
  static const double none = 0.0;
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 12.0;
  static const double lg = 16.0;
  static const double xl = 20.0;
  static const double xxl = 24.0;
  static const double pill = 999.0;

  // BorderRadius helpers
  static const BorderRadius radiusXs = BorderRadius.all(Radius.circular(xs));
  static const BorderRadius radiusSm = BorderRadius.all(Radius.circular(sm));
  static const BorderRadius radiusMd = BorderRadius.all(Radius.circular(md));
  static const BorderRadius radiusLg = BorderRadius.all(Radius.circular(lg));
  static const BorderRadius radiusXl = BorderRadius.all(Radius.circular(xl));
  static const BorderRadius radiusXxl = BorderRadius.all(Radius.circular(xxl));
  static const BorderRadius radiusPill = BorderRadius.all(Radius.circular(pill));

  // Top Rounded Corners (Sheets, Modal, Bottom Sheets)
  static const BorderRadius topLg = BorderRadius.vertical(top: Radius.circular(lg));
  static const BorderRadius topXl = BorderRadius.vertical(top: Radius.circular(xl));
  static const BorderRadius topXxl = BorderRadius.vertical(top: Radius.circular(xxl));
}
