/// Centralized constants for Home Services module UI, layout thresholds,
/// animation durations, and default fallback values.
abstract class HomeServicesConstants {
  // Animation Durations
  static const Duration defaultAnimationDuration = Duration(milliseconds: 250);
  static const Duration pageTransitionDuration = Duration(milliseconds: 300);
  static const Duration scrollAnimationDuration = Duration(milliseconds: 500);

  // Default Ratings & Badges
  static const double defaultRating = 4.8;
  static const String defaultRatingCount = '1K+';
  static const String defaultCurrencySymbol = '₹';

  // Category Expansion Limits
  static const int electricianInitialVisibleCount = 8;
  static const int plumbingInitialVisibleCount = 6;
  static const int carpentryInitialVisibleCount = 6;

  // Snackbar Durations
  static const Duration snackbarShortDuration = Duration(seconds: 1);
  static const Duration snackbarMediumDuration = Duration(seconds: 2);
  static const Duration snackbarLongDuration = Duration(seconds: 3);

  // Mock Asset & Image URLs
  static const String fallbackImageUrl =
      'https://images.unsplash.com/photo-1581578731548-c64695cc6952?auto=format&fit=crop&w=500&q=80';
  static const String kitchenCleaningHeroUrl =
      'https://images.unsplash.com/photo-1556911220-e15b29be8c8f?auto=format&fit=crop&w=800&q=80';
  static const String electricianHeroUrl =
      'https://images.unsplash.com/photo-1621905251189-08b45d6a269e?auto=format&fit=crop&w=800&q=80';
  static const String plumbingHeroUrl =
      'https://images.unsplash.com/photo-1584622650111-993a426fbf0a?auto=format&fit=crop&w=800&q=80';
  static const String carpentryHeroUrl =
      'https://images.unsplash.com/photo-1538688525198-9b88f6f53126?auto=format&fit=crop&w=800&q=80';
}
