import '../../models/destination_model.dart';
import '../../models/trip_filter_model.dart';
import '../../models/trip_package_model.dart';
import '../../models/trip_theme_model.dart';
import '../datasources/trips_mock_datasource.dart';
import 'trips_repository.dart';

/// Concrete repository retrieving trip and destination data from mock data source
class TripsRepositoryImpl implements TripsRepository {
  @override
  Future<List<DestinationModel>> getFeaturedDestinations() async {
    await Future.delayed(const Duration(milliseconds: 150));
    return TripsMockDatasource.destinations
        .where((d) => d.isFeatured)
        .toList();
  }

  @override
  Future<List<DestinationModel>> getPopularDestinations() async {
    await Future.delayed(const Duration(milliseconds: 150));
    return TripsMockDatasource.destinations
        .where((d) => d.isPopular)
        .toList();
  }

  @override
  Future<List<DestinationModel>> getAllDestinations() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return List.from(TripsMockDatasource.destinations);
  }

  @override
  Future<DestinationModel?> getDestinationById(String id) async {
    await Future.delayed(const Duration(milliseconds: 100));
    try {
      return TripsMockDatasource.destinations.firstWhere((d) => d.id == id);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<List<TripThemeModel>> getThemes() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return List.from(TripsMockDatasource.themes);
  }

  @override
  Future<List<TripPackageModel>> getFeaturedPackages() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return TripsMockDatasource.packages
        .where((p) => p.isFeatured)
        .toList();
  }

  @override
  Future<List<TripPackageModel>> getPopularPackages() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return TripsMockDatasource.packages
        .where((p) => p.isPopular)
        .toList();
  }

  @override
  Future<List<TripPackageModel>> getAllPackages() async {
    await Future.delayed(const Duration(milliseconds: 250));
    return List.from(TripsMockDatasource.packages);
  }

  @override
  Future<TripPackageModel?> getPackageById(String id) async {
    await Future.delayed(const Duration(milliseconds: 100));
    try {
      return TripsMockDatasource.packages.firstWhere((p) => p.id == id);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<List<TripPackageModel>> getPackagesByDestination(
      String destinationId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return TripsMockDatasource.packages
        .where((p) => p.destinationId == destinationId)
        .toList();
  }

  @override
  Future<List<TripPackageModel>> getPackagesByTheme(String themeId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return TripsMockDatasource.packages
        .where((p) => p.themeIds.contains(themeId))
        .toList();
  }

  @override
  Future<List<TripPackageModel>> searchTrips(String query) async {
    await Future.delayed(const Duration(milliseconds: 200));
    final q = query.toLowerCase().trim();
    if (q.isEmpty) return List.from(TripsMockDatasource.packages);

    return TripsMockDatasource.packages.where((pkg) {
      final matchesTitle = pkg.title.toLowerCase().contains(q);
      final matchesDest = pkg.destinationName.toLowerCase().contains(q);
      final matchesState = pkg.destinationState.toLowerCase().contains(q);
      final matchesThemes =
          pkg.themeNames.any((theme) => theme.toLowerCase().contains(q));
      final matchesHighlights =
          pkg.highlights.any((hl) => hl.toLowerCase().contains(q));
      return matchesTitle ||
          matchesDest ||
          matchesState ||
          matchesThemes ||
          matchesHighlights;
    }).toList();
  }

  @override
  Future<List<TripPackageModel>> filterTrips(TripFilterModel filter) async {
    await Future.delayed(const Duration(milliseconds: 250));
    var results = List<TripPackageModel>.from(TripsMockDatasource.packages);

    if (filter.destinationId != null && filter.destinationId!.isNotEmpty) {
      results = results
          .where((p) => p.destinationId == filter.destinationId)
          .toList();
    }

    if (filter.themeId != null && filter.themeId!.isNotEmpty) {
      results = results
          .where((p) => p.themeIds.contains(filter.themeId))
          .toList();
    }

    if (filter.minDurationDays != null) {
      results = results
          .where((p) => p.durationDays >= filter.minDurationDays!)
          .toList();
    }

    if (filter.maxDurationDays != null) {
      results = results
          .where((p) => p.durationDays <= filter.maxDurationDays!)
          .toList();
    }

    if (filter.minBudget != null) {
      results =
          results.where((p) => p.basePrice >= filter.minBudget!).toList();
    }

    if (filter.maxBudget != null) {
      results =
          results.where((p) => p.basePrice <= filter.maxBudget!).toList();
    }

    if (filter.minRating != null) {
      results = results.where((p) => p.rating >= filter.minRating!).toList();
    }

    // Apply Sorting
    switch (filter.sortOption) {
      case TripSortOption.priceLowToHigh:
        results.sort((a, b) => a.basePrice.compareTo(b.basePrice));
        break;
      case TripSortOption.priceHighToLow:
        results.sort((a, b) => b.basePrice.compareTo(a.basePrice));
        break;
      case TripSortOption.highestRated:
        results.sort((a, b) => b.rating.compareTo(a.rating));
        break;
      case TripSortOption.durationShort:
        results.sort((a, b) => a.durationDays.compareTo(b.durationDays));
        break;
      case TripSortOption.durationLong:
        results.sort((a, b) => b.durationDays.compareTo(a.durationDays));
        break;
      case TripSortOption.popularity:
        results.sort((a, b) => b.reviewCount.compareTo(a.reviewCount));
        break;
    }

    return results;
  }
}
