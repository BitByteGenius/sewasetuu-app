/// API Endpoints and Network Constants
abstract class ApiConstants {
  static const String baseUrl = 'https://api.sewasetu.com/v1';
  
  // Auth endpoints
  static const String loginWithPhone = '/auth/login-phone';
  static const String verifyOtp = '/auth/verify-otp';
  static const String refreshToken = '/auth/refresh';
  static const String logout = '/auth/logout';
  static const String userProfile = '/user/profile';
  
  // Stay / Accommodation Endpoints
  static const String stays = '/stays';
  static const String stayDetails = '/stays/{id}';
  static const String stayCategories = '/stays/categories';
  static const String staySearch = '/stays/search';
  static const String stayReviews = '/stays/{id}/reviews';
  static const String checkAvailability = '/stays/{id}/availability';
  
  // Secondary Modules Endpoints
  static const String services = '/services';
  static const String rentals = '/rentals';
  static const String trips = '/trips';
  
  // Booking & Payment
  static const String bookings = '/bookings';
  static const String payments = '/payments';
}
