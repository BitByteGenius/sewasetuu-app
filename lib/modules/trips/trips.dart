/// ==============================================================================
/// SEWASETU CURATED TRAVEL & TRIPS MODULE
/// ==============================================================================
/// Public barrel export for the Trips & Travel marketplace module.
/// Provides access to screens, models, controllers, bindings, widgets, and navigation.
///
/// To navigate to Trips from anywhere:
/// ```dart
/// import 'package:sewasetu/modules/trips/trips.dart';
///
/// TripsNavigator.toTrips();
/// ```
/// ==============================================================================
library;

// Models
export 'models/destination_model.dart';
export 'models/itinerary_day_model.dart';
export 'models/traveler_model.dart';
export 'models/trip_activity_model.dart';
export 'models/trip_filter_model.dart';
export 'models/trip_package_model.dart';
export 'models/trip_theme_model.dart';

// Data & Repositories
export 'data/datasources/trips_mock_datasource.dart';
export 'data/repositories/trips_repository.dart';
export 'data/repositories/trips_repository_impl.dart';

// Controllers
export 'controllers/destination_controller.dart';
export 'controllers/trip_details_controller.dart';
export 'controllers/trip_filter_controller.dart';
export 'controllers/trip_search_controller.dart';
export 'controllers/trips_controller.dart';

// Bindings
export 'bindings/destination_binding.dart';
export 'bindings/trip_details_binding.dart';
export 'bindings/trip_search_binding.dart';
export 'bindings/trips_binding.dart';

// Screens
export 'screens/destination_details_screen.dart';
export 'screens/destinations_screen.dart';
export 'screens/trip_checkout_screen.dart';
export 'screens/trip_details_screen.dart';
export 'screens/trip_list_screen.dart';
export 'screens/trip_search_screen.dart';
export 'screens/trips_screen.dart';

// Widgets
export 'widgets/destination_card.dart';
export 'widgets/itinerary_day_card.dart';
export 'widgets/itinerary_timeline.dart';
export 'widgets/traveler_selector.dart';
export 'widgets/trip_booking_bottom_bar.dart';
export 'widgets/trip_date_selector.dart';
export 'widgets/trip_exclusions_widget.dart';
export 'widgets/trip_filter_sheet.dart';
export 'widgets/trip_inclusions_widget.dart';
export 'widgets/trip_loading_card.dart';
export 'widgets/trip_package_card.dart';
export 'widgets/trip_price_summary.dart';
export 'widgets/trip_search_bar.dart';
export 'widgets/trip_sorting_sheet.dart';
export 'widgets/trip_theme_card.dart';
export 'widgets/trips_hero_widget.dart';

// Navigator
export 'trips_navigator.dart';
