/// Global Application Level Constants
abstract class AppConstants {
  static const String appName = 'SewaSetu';
  static const String appTagline = 'Your All-in-One Stay & Services Marketplace';
  
  // Storage Keys
  static const String tokenKey = 'app_auth_token';
  static const String userKey = 'app_user_data';
  static const String isFirstTimeKey = 'app_is_first_time';
  static const String hasSeenOnboardingKey = 'has_seen_onboarding';
  static const String isDarkModeKey = 'app_is_dark_mode';
  static const String selectedCityKey = 'app_selected_city';
  static const String selectedAreaKey = 'app_selected_area';
  static const String recentLocationsKey = 'app_recent_locations';
  static const String selectedLatKey = 'app_selected_lat';
  static const String selectedLngKey = 'app_selected_lng';
  
  // Animation Durations
  static const Duration animDurationFast = Duration(milliseconds: 200);
  static const Duration animDurationNormal = Duration(milliseconds: 350);
  static const Duration animDurationSlow = Duration(milliseconds: 500);

  // Pagination
  static const int defaultPageSize = 20;
}
