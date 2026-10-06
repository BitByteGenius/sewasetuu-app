// Central barrel export for Services Module
export 'home_screen/screens/services_screen.dart';
export 'home_screen/screens/instant_services_screen.dart';
export 'home_screen/screens/instant_services_navigation_shell.dart';
export 'home_screen/controllers/instant_services_navigation_controller.dart';
export 'home_screen/controllers/services_controller.dart';
export 'home_screen/bindings/services_binding.dart';
export 'home_screen/widgets/instant_services_navigation_bar.dart';

// Data & Repositories
export 'home_screen/data/services_mock_data.dart';
export 'home_screen/data/services_repository.dart';

// Models
export 'home_screen/models/service_category_item.dart';
export 'home_screen/models/service_faq_item.dart';
export 'home_screen/models/service_offer_item.dart';
export 'home_screen/models/service_popular_item.dart';
export 'home_screen/models/service_relocation_item.dart';
export 'home_screen/models/service_review_item.dart';
export 'home_screen/models/service_spotlight_item.dart';
export 'home_screen/models/service_subcategory_item.dart';

// Home Cleaning Sub-Module
export 'home_cleaning/home_cleaning.dart';
export 'home_cleaning/bindings/home_cleaning_binding.dart';

// Electrician, Plumbing, Carpentry Sub-Modules
export 'electrician/models/home_service_model.dart';
export 'electrician/data/home_services_data.dart';
export 'electrician/bindings/electrician_binding.dart';
export 'electrician/controller/electrician_controller.dart';
export 'electrician/controller/plumbing_controller.dart';
export 'electrician/controller/carpenter_controller.dart';
export 'electrician/screen/electrician_screen.dart';
export 'electrician/screen/plumbing_screen.dart';
export 'electrician/screen/cartpenter_screen.dart';

// Shared Common Widgets
export 'common_widgets/home_service_category_grid.dart';
export 'common_widgets/home_service_listing_card.dart';
export 'common_widgets/home_service_states.dart';
export 'common_widgets/my_cart_widgets.dart';
