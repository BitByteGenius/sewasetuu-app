/// ==============================================================================
/// SEWASETU API CONSTANTS & ENDPOINT BLUEPRINT
/// ==============================================================================
/// Centralized API routing constants for the SewaSetu marketplace application.
/// 
/// Every constant is documented with:
/// - [HTTP Method]
/// - [Authentication Requirement] (Public vs Bearer Token)
/// - [Purpose & Expected Payload / Params]
///
/// Use dynamic path helper methods (e.g. [stayDetailsPath]) to build parameterized
/// URLs without manual string concatenation.
/// ==============================================================================
abstract class ApiConstants {
  // ============================================================================
  // 1. BASE URL & SERVER CONFIGURATION
  // ============================================================================
  
  /// Production API Gateway Base URL
  static const String baseUrl = 'https://api.sewasetu.com/v1';

  /// Local Development Base URL (Android Emulator: 10.0.2.2, iOS: 127.0.0.1 or LAN IP)
  static const String devBaseUrl = 'http://10.0.2.2:5000/v1';

  /// Staging / QA Environment Base URL
  static const String stagingBaseUrl = 'https://staging-api.sewasetu.com/v1';

  // ============================================================================
  // 2. AUTHENTICATION & SESSION MANAGEMENT
  // ============================================================================

  /// [POST] Request 6-digit SMS OTP for login or registration.
  /// - Auth: Public
  /// - Body: `{ "phone": "9876543210" }`
  static const String sendOtp = '/auth/send-otp';

  /// [POST] Verify 6-digit SMS OTP and establish user session.
  /// - Auth: Public
  /// - Body: `{ "phone": "9876543210", "otp": "123456" }`
  /// - Response: `{ "user": {...}, "access_token": "...", "refresh_token": "..." }`
  static const String verifyOtp = '/auth/verify-otp';

  /// [POST] Resend OTP code with 30-second cooldown throttle.
  /// - Auth: Public
  /// - Body: `{ "phone": "9876543210" }`
  static const String resendOtp = '/auth/resend-otp';

  /// [POST] Phone + Password traditional login.
  /// - Auth: Public
  /// - Body: `{ "phone": "9876543210", "password": "..." }`
  static const String loginWithPhone = '/auth/login-phone';

  /// [POST] Email/Username + Password login.
  /// - Auth: Public
  /// - Body: `{ "email": "user@example.com", "password": "..." }`
  static const String loginWithPassword = '/auth/login-password';

  /// [POST] New user registration.
  /// - Auth: Public
  /// - Body: `{ "name": "...", "phone": "...", "email": "...", "password": "..." }`
  static const String register = '/auth/register';

  /// [POST] Initiate forgot password recovery via SMS/Email.
  /// - Auth: Public
  /// - Body: `{ "email_or_phone": "..." }`
  static const String forgotPassword = '/auth/forgot-password';

  /// [POST] Submit new password using reset token / OTP.
  /// - Auth: Public
  /// - Body: `{ "token": "...", "new_password": "..." }`
  static const String resetPassword = '/auth/reset-password';

  /// [POST] Refresh expired access token using long-lived refresh token.
  /// - Auth: Bearer Refresh Token or Body
  /// - Body: `{ "refresh_token": "..." }`
  /// - Response: `{ "access_token": "...", "refresh_token": "..." }`
  static const String refreshToken = '/auth/refresh';

  /// [POST] Invalidate current session and revoke tokens.
  /// - Auth: Bearer Access Token
  static const String logout = '/auth/logout';

  // ============================================================================
  // 3. USER PROFILE & SETTINGS
  // ============================================================================

  /// [GET] Fetch current authenticated user's profile and stats.
  /// [PUT] Update user profile (name, email, city).
  /// - Auth: Bearer Token
  static const String userProfile = '/user/profile';

  /// [POST] Upload user profile avatar photo (multipart/form-data).
  /// - Auth: Bearer Token
  static const String uploadAvatar = '/user/avatar';

  /// [GET] Fetch user's active promo coupons and vouchers.
  /// - Auth: Bearer Token
  static const String userCoupons = '/user/coupons';

  // ============================================================================
  // 4. HOME & GEOLOCATION DISCOVERY
  // ============================================================================

  /// [GET] Aggregated home feed containing featured, nearby, recommended stays and services.
  /// - Auth: Optional
  /// - Query Params: `?city=Guwahati, Assam`
  static const String homeFeed = '/home/feed';

  /// [GET] Supported marketplace operating cities list (Guwahati, Shillong, Goa, Manali, etc.).
  /// - Auth: Public
  static const String cities = '/locations/cities';

  /// [GET] Reverse geocode GPS coordinates to nearest supported city.
  /// - Auth: Public
  /// - Query Params: `?lat=26.1812&lng=91.7512`
  static const String reverseGeocode = '/locations/reverse-geocode';

  // ============================================================================
  // 5. STAY / ACCOMMODATION (PRIMARY MODULE)
  // ============================================================================

  /// [GET] Paginated list of stays with dynamic filtering and sorting.
  /// - Auth: Optional
  /// - Query Params: `?stay_type=homestay&city=Shillong&min_price=1000&max_price=5000&min_rating=4.5&verified_only=true&amenities=WiFi,Breakfast&sort_by=recommended&page=1&limit=20`
  static const String stays = '/stays';

  /// [GET] Full stay details template path (`/stays/{id}`).
  /// Use [stayDetailsPath] helper below.
  static const String stayDetails = '/stays/{id}';

  /// [GET] Highlighted featured stays for home carousel.
  /// - Auth: Public
  static const String featuredStays = '/stays/featured';

  /// [GET] Stays nearby current user or selected city center.
  /// - Auth: Public
  /// - Query Params: `?city=Guwahati&lat=26.14&lng=91.73`
  static const String nearbyStays = '/stays/nearby';

  /// [GET] Supported stay categories metadata (Room, PG, Mess, Homestay, Hotel).
  /// - Auth: Public
  static const String stayCategories = '/stays/categories';

  /// [GET] Full catalog of available filter amenities (High-speed WiFi, 3 Meals, AC, etc.).
  /// - Auth: Public
  static const String stayAmenities = '/stays/amenities';

  /// [POST] Search stays using multi-step criteria (City, Dates, Guests count, StayType).
  /// - Auth: Optional
  /// - Body: `{ "city": "...", "check_in": "...", "check_out": "...", "adults": 2, "children": 0, "stay_type": "..." }`
  static const String staySearch = '/stays/search';

  /// [GET] Stay reviews template path (`/stays/{id}/reviews`).
  /// [POST] Submit verified stay review (`/stays/{id}/reviews`).
  /// Use [stayReviewsPath] helper below.
  static const String stayReviews = '/stays/{id}/reviews';

  /// [GET] Date availability and inventory check template path (`/stays/{id}/availability`).
  /// Use [checkAvailabilityPath] helper below.
  static const String checkAvailability = '/stays/{id}/availability';

  /// [GET] Room options for stay template path (`/stays/{id}/rooms`).
  /// Use [stayRoomsPath] helper below.
  static const String stayRooms = '/stays/{id}/rooms';

  /// [GET] Similar properties in same locality template path (`/stays/{id}/similar`).
  /// Use [similarStaysPath] helper below.
  static const String similarStays = '/stays/{id}/similar';

  // ============================================================================
  // 6. BOOKINGS & CHECKOUT FLOW
  // ============================================================================

  /// [POST] Calculate real-time price quotation (nights, cleaning fee, platform fee, 12% GST, promo discount).
  /// - Auth: Bearer Token
  /// - Body: `{ "stay_id": "...", "room_id": "...", "check_in": "...", "check_out": "...", "coupon_code": "WELCOME500" }`
  static const String calculateBookingPrice = '/bookings/calculate';

  /// [POST] Lock inventory and create reservation record (Status: pending / confirmed).
  /// - Auth: Bearer Token
  /// - Body: `{ "stay_id": "...", "room_id": "...", "check_in_date": "...", "check_out_date": "...", "guests_count": 2, "payment_method": "upi" }`
  static const String createBooking = '/bookings/create';

  /// [GET] User's booking history list (Upcoming, Completed, Cancelled).
  /// - Auth: Bearer Token
  /// - Query Params: `?status=upcoming`
  static const String bookings = '/bookings';

  /// [GET] Single booking details & voucher template path (`/bookings/{id}`).
  /// Use [bookingDetailsPath] helper below.
  static const String bookingDetails = '/bookings/{id}';

  /// [POST] Cancel reservation and trigger refund calculation template path (`/bookings/{id}/cancel`).
  /// Use [cancelBookingPath] helper below.
  static const String cancelBooking = '/bookings/{id}/cancel';

  /// [GET] Download PDF booking confirmation invoice template path (`/bookings/{id}/invoice`).
  /// Use [bookingInvoicePath] helper below.
  static const String bookingInvoice = '/bookings/{id}/invoice';

  /// [POST] Validate and test a promotional coupon code.
  /// - Auth: Bearer Token
  /// - Body: `{ "code": "WELCOME500", "booking_amount": 9600 }`
  static const String validateCoupon = '/coupons/validate';

  // ============================================================================
  // 7. WISHLIST / FAVORITES
  // ============================================================================

  /// [GET] Get all saved properties for authenticated user.
  /// - Auth: Bearer Token
  /// - Query Params: `?collection=Weekend Getaways`
  static const String wishlist = '/wishlist';

  /// [POST] Toggle property in/out of wishlist.
  /// - Auth: Bearer Token
  /// - Body: `{ "stay_id": "stay-1", "collection_name": "All Saved" }`
  /// - Response: `{ "is_favorite": true }`
  static const String toggleWishlist = '/wishlist/toggle';

  /// [GET] Predefined or user-created wishlist collection categories.
  /// - Auth: Bearer Token
  static const String wishlistCollections = '/wishlist/collections';

  // ============================================================================
  // 8. NOTIFICATIONS
  // ============================================================================

  /// [GET] Chronological notification feed.
  /// - Auth: Bearer Token
  static const String notifications = '/notifications';

  /// [PATCH] Mark single notification as read template path (`/notifications/{id}/read`).
  /// Use [markNotificationReadPath] helper below.
  static const String markNotificationRead = '/notifications/{id}/read';

  /// [PATCH] Mark all user notifications as read.
  /// - Auth: Bearer Token
  static const String markAllNotificationsRead = '/notifications/read-all';

  /// [POST] Register Firebase Cloud Messaging (FCM) device token for push alerts.
  /// - Auth: Bearer Token
  /// - Body: `{ "fcm_token": "...", "platform": "android" }`
  static const String registerDeviceToken = '/notifications/register-device';

  // ============================================================================
  // 9. PAYMENTS & TRANSACTIONS
  // ============================================================================

  /// [GET] Payment transaction history.
  /// - Auth: Bearer Token
  static const String payments = '/payments';

  /// [GET] Saved payment methods (UPI, Cards).
  /// [POST] Add new saved payment instrument.
  /// - Auth: Bearer Token
  static const String paymentMethods = '/payments/methods';

  /// [POST] Create payment order with payment gateway (Razorpay / Cashfree / Stripe).
  /// - Auth: Bearer Token
  /// - Body: `{ "booking_id": "...", "amount": 10733.60, "currency": "INR" }`
  static const String createPaymentOrder = '/payments/create-order';

  /// [POST] Verify client-side payment signature callback.
  /// - Auth: Bearer Token
  /// - Body: `{ "order_id": "...", "payment_id": "...", "signature": "..." }`
  static const String verifyPayment = '/payments/verify';

  // ============================================================================
  // 10. SECONDARY MARKETPLACE MODULES (FUTURE / EXPANSION)
  // ============================================================================

  /// [GET] Local Home Services catalog (Electrician, Plumber, Driver, Cleaning).
  /// - Auth: Public
  static const String services = '/services';

  /// [POST] Book an on-demand local expert service.
  /// - Auth: Bearer Token
  static const String serviceRequest = '/services/request';

  /// [GET] Vehicle Rentals catalog (Self-drive cars, Touring bikes).
  /// - Auth: Public
  static const String rentals = '/rentals';

  /// [POST] Reserve a rental vehicle.
  /// - Auth: Bearer Token
  static const String rentalBook = '/rentals/book';

  /// [GET] Curated Tour Packages & Destinations (Meghalaya, Manali, Goa).
  /// - Auth: Public
  static const String trips = '/trips';

  /// [POST] Book a travel package itinerary.
  /// - Auth: Bearer Token
  static const String tripBook = '/trips/book';

  // ============================================================================
  // 11. DYNAMIC PATH BUILDER HELPERS
  // ============================================================================
  // Use these helper functions to prevent typo-prone string interpolation.
  // Example: final url = ApiConstants.stayDetailsPath(stayId);

  /// Builds URL for specific stay details: `/stays/{id}`
  static String stayDetailsPath(String id) => '/stays/$id';

  /// Builds URL for stay room options: `/stays/{id}/rooms`
  static String stayRoomsPath(String id) => '/stays/$id/rooms';

  /// Builds URL for stay reviews: `/stays/{id}/reviews`
  static String stayReviewsPath(String id) => '/stays/$id/reviews';

  /// Builds URL for checking date availability: `/stays/{id}/availability`
  static String checkAvailabilityPath(String id) => '/stays/$id/availability';

  /// Builds URL for similar properties: `/stays/{id}/similar`
  static String similarStaysPath(String id) => '/stays/$id/similar';

  /// Builds URL for booking details voucher: `/bookings/{id}`
  static String bookingDetailsPath(String id) => '/bookings/$id';

  /// Builds URL to cancel a booking: `/bookings/{id}/cancel`
  static String cancelBookingPath(String id) => '/bookings/$id/cancel';

  /// Builds URL to download booking PDF invoice: `/bookings/{id}/invoice`
  static String bookingInvoicePath(String id) => '/bookings/$id/invoice';

  /// Builds URL to mark a notification read: `/notifications/{id}/read`
  static String markNotificationReadPath(String id) => '/notifications/$id/read';
}
