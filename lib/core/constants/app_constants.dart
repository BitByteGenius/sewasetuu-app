/// Global Application Level Constants
abstract class AppConstants {
  static const String appName = 'SewaSetu';
  static const String appTagline = 'Your All-in-One Stay & Services Marketplace';
  
  // Storage Keys
  static const String tokenKey = 'app_auth_token';
  static const String userKey = 'app_user_data';
  static const String isFirstTimeKey = 'app_is_first_time';
  static const String isDarkModeKey = 'app_is_dark_mode';
  static const String selectedCityKey = 'app_selected_city';
  
  // Animation Durations
  static const Duration animDurationFast = Duration(milliseconds: 200);
  static const Duration animDurationNormal = Duration(milliseconds: 350);
  static const Duration animDurationSlow = Duration(milliseconds: 500);

  // Pagination
  static const int defaultPageSize = 20;
}
