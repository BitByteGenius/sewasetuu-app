/// Centralized route definitions for navigation
abstract class AppRoutes {
  static const String splash = '/splash';
  static const String onboarding = '/onboarding';

  // Auth
  static const String login = '/auth/login';
  static const String signUp = '/auth/signup';
  static const String otpVerification = '/auth/otp-verification';
  static const String forgotPassword = '/auth/forgot-password';

  // Main App Shell (Hosts Bottom Navigation)
  static const String main = '/main';
  static const String home = '/home';

  // Stay / Accommodation (Core Module)
  static const String stayList = '/stay/list';
  static const String stayDetails = '/stay/details';
  static const String fullScreenGallery = '/stay/gallery';
  static const String staySearch = '/stay/search';
  static const String stayFilter = '/stay/filter';

  // Booking & Checkout Flow
  static const String bookingCheckout = '/booking/checkout';
  static const String bookingConfirmation = '/booking/confirmation';
  static const String bookingDetails = '/booking/details';
  static const String booking = '/booking';

  // Secondary Modules
  static const String services = '/services';
  static const String rentals = '/rentals';
  static const String trips = '/trips';

  // User & Auxiliary
  static const String wishlist = '/wishlist';
  static const String profile = '/profile';
  static const String editProfile = '/profile/edit';
  static const String coupons = '/profile/coupons';
  static const String notifications = '/notifications';
  static const String payment = '/payment';
}
