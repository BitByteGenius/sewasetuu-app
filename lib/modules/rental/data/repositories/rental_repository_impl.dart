import '../../models/rental_addon_model.dart';
import '../../models/rental_booking_model.dart';
import '../../models/rental_city_model.dart';
import '../../models/rental_review_model.dart';
import '../../models/rental_search_model.dart';
import '../../models/vehicle_model.dart';
import '../datasources/rental_mock_datasource.dart';
import 'rental_repository.dart';

/// Concrete implementation of RentalRepository powered by RentalMockDatasource.
/// Includes simulated async delay to reflect real network behavior.
class RentalRepositoryImpl implements RentalRepository {
  final List<RentalBookingModel> _bookings = List.from(RentalMockDatasource.initialBookings);

  // Simulated delay for realistic UI micro-interactions
  Future<void> _simulateNetwork([int millis = 250]) async {
    await Future.delayed(Duration(milliseconds: millis));
  }

  @override
  Future<List<RentalCityModel>> getCities({bool? availableOnly}) async {
    await _simulateNetwork();
    final allVehicles = RentalMockDatasource.vehicles;

    final updatedCities = RentalMockDatasource.cities.map((city) {
      if (!city.isLive) {
        return city.copyWith(vehicleCount: 0);
      }
      final count = allVehicles.where((v) => v.cityIds.contains(city.id)).length;
      return city.copyWith(vehicleCount: count);
    }).toList();

    if (availableOnly == true) {
      return updatedCities.where((c) => c.isLive).toList();
    }
    return updatedCities;
  }

  @override
  Future<RentalCityModel?> getCityById(String cityId) async {
    await _simulateNetwork(150);
    final cities = await getCities();
    try {
      return cities.firstWhere((c) => c.id.toLowerCase() == cityId.toLowerCase());
    } catch (_) {
      return null;
    }
  }

  @override
  Future<List<VehicleModel>> getVehicles({
    String? cityId,
    RentalVehicleType? vehicleType,
    String? category,
  }) async {
    await _simulateNetwork();
    var list = RentalMockDatasource.vehicles;

    if (cityId != null && cityId.isNotEmpty) {
      list = list.where((v) => v.cityIds.contains(cityId.toLowerCase())).toList();
    }

    if (vehicleType != null && vehicleType != RentalVehicleType.all) {
      list = list.where((v) => v.vehicleType == vehicleType).toList();
    }

    if (category != null && category.isNotEmpty && category != 'All') {
      list = list.where((v) => v.category.toLowerCase() == category.toLowerCase()).toList();
    }

    return list;
  }

  @override
  Future<List<VehicleModel>> searchVehicles(
    RentalSearchModel search, {
    RentalFilterCriteria? filters,
    RentalSortOption? sort,
  }) async {
    await _simulateNetwork(350);
    var results = RentalMockDatasource.vehicles;

    // 1. City constraint
    if (search.cityId.isNotEmpty) {
      results = results.where((v) => v.cityIds.contains(search.cityId.toLowerCase())).toList();
    }

    // 2. Search Vehicle Type
    if (search.vehicleType != RentalVehicleType.all) {
      results = results.where((v) => v.vehicleType == search.vehicleType).toList();
    }

    // 3. Apply advanced filters if provided
    if (filters != null) {
      if (filters.vehicleType != RentalVehicleType.all) {
        results = results.where((v) => v.vehicleType == filters.vehicleType).toList();
      }
      if (filters.category != null && filters.category!.isNotEmpty && filters.category != 'All') {
        results = results.where((v) => v.category.toLowerCase() == filters.category!.toLowerCase()).toList();
      }
      if (filters.minPrice != null) {
        results = results.where((v) => v.pricePerDay >= filters.minPrice!).toList();
      }
      if (filters.maxPrice != null) {
        results = results.where((v) => v.pricePerDay <= filters.maxPrice!).toList();
      }
      if (filters.transmission != null && filters.transmission != 'All') {
        results = results.where((v) => v.transmission.toLowerCase() == filters.transmission!.toLowerCase()).toList();
      }
      if (filters.fuelType != null && filters.fuelType != 'All') {
        results = results.where((v) => v.fuelType.toLowerCase() == filters.fuelType!.toLowerCase()).toList();
      }
      if (filters.minSeats != null && filters.minSeats! > 0) {
        results = results.where((v) => v.seats >= filters.minSeats!).toList();
      }
      if (filters.minRating != null) {
        results = results.where((v) => v.rating >= filters.minRating!).toList();
      }
      if (filters.premiumOnly == true) {
        results = results.where((v) => v.isPremium).toList();
      }
    }

    // 4. Sorting logic
    final sortOption = sort ?? RentalSortOption.recommended;
    switch (sortOption) {
      case RentalSortOption.recommended:
        // Featured and top rated first
        results.sort((a, b) {
          if (a.isFeatured && !b.isFeatured) return -1;
          if (!a.isFeatured && b.isFeatured) return 1;
          return b.rating.compareTo(a.rating);
        });
        break;
      case RentalSortOption.priceLowToHigh:
        results.sort((a, b) => a.pricePerDay.compareTo(b.pricePerDay));
        break;
      case RentalSortOption.priceHighToLow:
        results.sort((a, b) => b.pricePerDay.compareTo(a.pricePerDay));
        break;
      case RentalSortOption.highestRated:
        results.sort((a, b) => b.rating.compareTo(a.rating));
        break;
      case RentalSortOption.mostPopular:
        results.sort((a, b) => b.reviewCount.compareTo(a.reviewCount));
        break;
    }

    return results;
  }

  @override
  Future<VehicleModel?> getVehicleById(String vehicleId) async {
    await _simulateNetwork(150);
    try {
      return RentalMockDatasource.vehicles.firstWhere((v) => v.id == vehicleId);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<List<VehicleModel>> getFeaturedVehicles(String cityId) async {
    final list = await getVehicles(cityId: cityId);
    return list.where((v) => v.isFeatured).toList();
  }

  @override
  Future<List<VehicleModel>> getPopularVehicles(String cityId) async {
    final list = await getVehicles(cityId: cityId);
    return list.where((v) => v.isPopular).toList();
  }

  @override
  Future<List<VehicleModel>> getPremiumVehicles(String cityId) async {
    final list = await getVehicles(cityId: cityId);
    return list.where((v) => v.isPremium || v.vehicleType == RentalVehicleType.luxury).toList();
  }

  @override
  Future<List<RentalBannerCampaign>> getCampaigns() async {
    await _simulateNetwork(100);
    return RentalMockDatasource.campaigns;
  }

  @override
  Future<List<RentalAddonModel>> getAddonsForVehicle(VehicleModel vehicle) async {
    await _simulateNetwork(100);
    return RentalMockDatasource.addons.where((a) => a.isApplicableFor(vehicle.vehicleType)).toList();
  }

  @override
  Future<List<RentalReviewModel>> getVehicleReviews(String vehicleId) async {
    await _simulateNetwork(150);
    return RentalMockDatasource.reviews;
  }

  @override
  Future<RentalBookingModel> createBooking(RentalBookingModel booking) async {
    await _simulateNetwork(400);
    _bookings.insert(0, booking);
    return booking;
  }

  @override
  Future<List<RentalBookingModel>> getUserBookings() async {
    await _simulateNetwork(200);
    return List.unmodifiable(_bookings);
  }

  @override
  Future<RentalBookingModel?> getBookingById(String bookingId) async {
    await _simulateNetwork(150);
    try {
      return _bookings.firstWhere((b) => b.id == bookingId);
    } catch (_) {
      return null;
    }
  }
}
