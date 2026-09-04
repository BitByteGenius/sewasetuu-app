import 'package:get/get.dart';
import 'bindings/destination_binding.dart';
import 'bindings/trip_details_binding.dart';
import 'bindings/trip_search_binding.dart';
import 'bindings/trips_binding.dart';
import 'controllers/destination_controller.dart';
import 'controllers/trip_details_controller.dart';
import 'models/destination_model.dart';
import 'models/trip_package_model.dart';
import 'screens/destination_details_screen.dart';
import 'screens/destinations_screen.dart';
import 'screens/trip_checkout_screen.dart';
import 'screens/trip_details_screen.dart';
import 'screens/trip_list_screen.dart';
import 'screens/trip_search_screen.dart';
import 'screens/trips_screen.dart';

/// Clean internal navigator for the Trips & Travel module
class TripsNavigator {
  /// Opens the main Trips travel discovery home screen
  static Future<T?>? toTrips<T>() {
    TripsBinding().dependencies();
    return Get.to<T>(
      () => const TripsScreen(),
      transition: Transition.rightToLeftWithFade,
      duration: const Duration(milliseconds: 300),
    );
  }

  /// Opens the All Destinations explorer screen
  static Future<T?>? toDestinations<T>() {
    TripsBinding().dependencies();
    return Get.to<T>(
      () => const DestinationsScreen(),
      transition: Transition.rightToLeftWithFade,
      duration: const Duration(milliseconds: 300),
    );
  }

  /// Opens the Destination Guide screen with packages for this location
  static Future<T?>? toDestinationDetails<T>(DestinationModel destination) {
    DestinationBinding().dependencies();
    Get.put<DestinationController>(
      DestinationController(
        destinationId: destination.id,
        initialDestination: destination,
      ),
      tag: destination.id,
    );

    return Get.to<T>(
      () => DestinationDetailsScreen(destination: destination),
      transition: Transition.rightToLeftWithFade,
      duration: const Duration(milliseconds: 300),
    );
  }

  /// Opens the package listing screen with optional destination/theme filters
  static Future<T?>? toTripList<T>({
    String? destinationId,
    String? themeId,
    String? title,
  }) {
    TripsBinding().dependencies();
    return Get.to<T>(
      () => TripListScreen(
        destinationId: destinationId,
        themeId: themeId,
        title: title,
      ),
      transition: Transition.rightToLeftWithFade,
      duration: const Duration(milliseconds: 300),
    );
  }

  /// Opens the Trip Details screen
  static Future<T?>? toTripDetails<T>(TripPackageModel package) {
    TripDetailsBinding().dependencies();
    Get.put<TripDetailsController>(
      TripDetailsController(package: package),
      tag: package.id,
    );

    return Get.to<T>(
      () => TripDetailsScreen(package: package),
      transition: Transition.rightToLeftWithFade,
      duration: const Duration(milliseconds: 300),
    );
  }

  /// Opens the dedicated Trip Search screen
  static Future<T?>? toTripSearch<T>({String? initialQuery}) {
    TripSearchBinding().dependencies();
    return Get.to<T>(
      () => TripSearchScreen(initialQuery: initialQuery),
      transition: Transition.fadeIn,
      duration: const Duration(milliseconds: 250),
    );
  }

  /// Opens the Trip Checkout and booking review screen
  static Future<T?>? toTripCheckout<T>(TripDetailsController detailsController) {
    return Get.to<T>(
      () => TripCheckoutScreen(detailsController: detailsController),
      transition: Transition.rightToLeftWithFade,
      duration: const Duration(milliseconds: 300),
    );
  }
}
