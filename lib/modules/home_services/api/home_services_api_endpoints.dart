/// Centralized REST API endpoints for the Home Services module.
/// Cleanly decouples network request URLs, query parameters, and endpoints
/// from UI components and controllers for 1-click backend readiness.
abstract class HomeServicesApiEndpoints {
  /// Base API URL prefix
  static const String baseUrl = 'https://api.sewasetu.com/api/v1/home-services';

  // ---------------------------------------------------------------------------
  // CATEGORIES & SUBCATEGORIES
  // ---------------------------------------------------------------------------

  /// GET /categories
  /// Fetch all top-level service categories (Home Cleaning, Electrician, Plumbing, Carpentry, etc.)
  /// Query Params: `?is_active=true&sort_by=sort_order`
  static const String getCategories = '$baseUrl/categories';

  /// GET /subcategories
  /// Fetch subcategories for a given category ID
  /// Query Params: `?category_id={id}`
  static const String getSubcategories = '$baseUrl/subcategories';

  // ---------------------------------------------------------------------------
  // SERVICES & LISTINGS
  // ---------------------------------------------------------------------------

  /// GET /services
  /// Fetch list of available services with optional category filtering and search query
  /// Query Params: `?category_id={id}&search={query}&page={page}&limit={limit}`
  static const String getServices = '$baseUrl/services';

  /// GET /services/{id}
  /// Fetch detailed information for a single service by ID (including options, packages, FAQs)
  static String getServiceDetail(String id) => '$baseUrl/services/$id';

  /// GET /spotlight
  /// Fetch featured spotlight service for the main Services home screen
  static const String getSpotlightService = '$baseUrl/spotlight';

  /// GET /popular
  /// Fetch popular/trending services list
  static const String getPopularServices = '$baseUrl/popular';

  // ---------------------------------------------------------------------------
  // PROMOTIONS & BANNERS
  // ---------------------------------------------------------------------------

  /// GET /banners
  /// Fetch active promotional offer banners for a specific module or category
  /// Query Params: `?module={module}` (e.g., electrician, plumbing, carpentry, cleaning)
  static const String getPromotionalBanners = '$baseUrl/banners';

  // ---------------------------------------------------------------------------
  // REVIEWS & FAQS
  // ---------------------------------------------------------------------------

  /// GET /reviews
  /// Fetch customer reviews and rating breakdown for a service or category
  /// Query Params: `?service_id={id}`
  static const String getReviews = '$baseUrl/reviews';

  /// GET /faqs
  /// Fetch frequently asked questions for a service or module
  /// Query Params: `?module={module}`
  static const String getFaqs = '$baseUrl/faqs';

  // ---------------------------------------------------------------------------
  // CART OPERATIONS
  // ---------------------------------------------------------------------------

  /// GET /cart
  /// Retrieve current active user cart
  static const String getCart = '$baseUrl/cart';

  /// POST /cart
  /// Add a service item or option to cart
  /// Body: `{ "service_id": "...", "option_id": "...", "quantity": 1 }`
  static const String addToCart = '$baseUrl/cart';

  /// PATCH /cart/{item_id}
  /// Update quantity or option of an existing item in cart
  /// Body: `{ "quantity": 2 }`
  static String updateCartItem(String itemId) => '$baseUrl/cart/$itemId';

  /// DELETE /cart/{item_id}
  /// Remove an item completely from cart
  static String removeCartItem(String itemId) => '$baseUrl/cart/$itemId';

  /// POST /cart/clear
  /// Clear all items from the user's active cart
  static const String clearCart = '$baseUrl/cart/clear';
}
