/// ==============================================================================
/// SEWASETU STATE-WISE REGIONAL SHOP MODULE
/// ==============================================================================
/// Public barrel export for the Shop e-commerce module.
/// Provides access to screens, models, controllers, bindings, and repository abstractions.
///
/// To navigate to the shop from anywhere:
/// ```dart
/// import 'package:sewasetu/modules/shop/shop.dart';
///
/// ShopNavigator.toShop();
/// ```
/// ==============================================================================
library;

// Models
export 'models/address_model.dart';
export 'models/cart_item_model.dart';
export 'models/product_model.dart';
export 'models/product_review_model.dart';
export 'models/product_variant_model.dart';
export 'models/shop_category_model.dart';
export 'models/shop_order_model.dart';
export 'models/shop_state_model.dart';

// Repositories & Data
export 'data/datasources/shop_mock_datasource.dart';
export 'data/repositories/shop_repository.dart';
export 'data/repositories/shop_repository_impl.dart';

// Controllers
export 'controllers/cart_controller.dart';
export 'controllers/checkout_controller.dart';
export 'controllers/product_details_controller.dart';
export 'controllers/shop_controller.dart';
export 'controllers/shop_search_controller.dart';
export 'controllers/state_products_controller.dart';
export 'controllers/shop_navigation_controller.dart';

// Bindings
export 'bindings/cart_binding.dart';
export 'bindings/product_details_binding.dart';
export 'bindings/shop_binding.dart';

// Screens
export 'screens/add_address_screen.dart';
export 'screens/cart_screen.dart';
export 'screens/checkout_screen.dart';
export 'screens/order_success_screen.dart';
export 'screens/product_details_screen.dart';
export 'screens/search_products_screen.dart';
export 'screens/select_address_screen.dart';
export 'screens/shop_navigation_shell.dart';
export 'screens/shop_screen.dart';
export 'screens/state_products_screen.dart';
export 'screens/states_screen.dart';

// Widgets
export 'widgets/shop_navigation_bar.dart';
export 'widgets/shop_navigation_item.dart';

// Internal Navigator
export 'shop_navigator.dart';
