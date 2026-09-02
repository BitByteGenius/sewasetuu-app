/// Centralized route definitions for navigation.
abstract class AppRoutes {
  static const String splash = '/splash';
  static const String onboarding = '/onboarding';
  
  // Auth
  static const String login = '/auth/login';
  static const String otp = '/auth/otp';
  
  // Main App Shell (Hosts Bottom Navigation)
  static const String main = '/main';
  static const String home = '/home';
  
  // Stay / Accommodation (Core Module)
  static const String stayList = '/stay/list';
  static const String stayDetails = '/stay/details';
  static const String staySearch = '/stay/search';
  static const String stayFilter = '/stay/filter';
  static const String stayBooking = '/stay/booking';
  
  // Secondary Modules
  static const String services = '/services';
  static const String rentals = '/rentals';
  static const String trips = '/trips';
  
  // User & Auxiliary
  static const String booking = '/booking';
  static const String wishlist = '/wishlist';
  static const String profile = '/profile';
  static const String notifications = '/notifications';
  static const String payment = '/payment';
}
