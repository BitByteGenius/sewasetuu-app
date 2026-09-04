import '../../models/destination_model.dart';
import '../../models/trip_filter_model.dart';
import '../../models/trip_package_model.dart';
import '../../models/trip_theme_model.dart';

/// Abstract contract for Trips data retrieval (mock or API)
abstract class TripsRepository {
  Future<List<DestinationModel>> getFeaturedDestinations();
  Future<List<DestinationModel>> getPopularDestinations();
  Future<List<DestinationModel>> getAllDestinations();
  Future<DestinationModel?> getDestinationById(String id);

  Future<List<TripThemeModel>> getThemes();

  Future<List<TripPackageModel>> getFeaturedPackages();
  Future<List<TripPackageModel>> getPopularPackages();
  Future<List<TripPackageModel>> getAllPackages();
  Future<TripPackageModel?> getPackageById(String id);

  Future<List<TripPackageModel>> getPackagesByDestination(String destinationId);
  Future<List<TripPackageModel>> getPackagesByTheme(String themeId);

  Future<List<TripPackageModel>> searchTrips(String query);
  Future<List<TripPackageModel>> filterTrips(TripFilterModel filter);
}
