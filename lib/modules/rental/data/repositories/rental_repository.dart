import '../../models/rental_addon_model.dart';
import '../../models/rental_booking_model.dart';
import '../../models/rental_city_model.dart';
import '../../models/rental_review_model.dart';
import '../../models/rental_search_model.dart';
import '../../models/vehicle_model.dart';
import '../datasources/rental_mock_datasource.dart';

/// Available sorting criteria for vehicle listings
enum RentalSortOption {
  recommended,
  priceLowToHigh,
  priceHighToLow,
  highestRated,
  mostPopular,
}

extension RentalSortOptionExtension on RentalSortOption {
  String get label {
    switch (this) {
      case RentalSortOption.recommended:
        return 'Recommended';
      case RentalSortOption.priceLowToHigh:
        return 'Price: Low to High';
      case RentalSortOption.priceHighToLow:
        return 'Price: High to Low';
      case RentalSortOption.highestRated:
        return 'Highest Rated';
      case RentalSortOption.mostPopular:
        return 'Most Popular';
    }
  }
}

/// Filter criteria container for advanced vehicle search
class RentalFilterCriteria {
  final RentalVehicleType vehicleType;
  final String? category;
  final double? minPrice;
  final double? maxPrice;
  final String? transmission; // 'All', 'Automatic', 'Manual'
  final String? fuelType; // 'All', 'Petrol', 'Diesel', 'Electric', 'Hybrid'
  final int? minSeats;
  final double? minRating;
  final bool? premiumOnly;

  const RentalFilterCriteria({
    this.vehicleType = RentalVehicleType.all,
    this.category,
    this.minPrice,
    this.maxPrice,
    this.transmission,
    this.fuelType,
    this.minSeats,
    this.minRating,
    this.premiumOnly,
  });

  bool get hasActiveFilters =>
      vehicleType != RentalVehicleType.all ||
      category != null ||
      minPrice != null ||
      maxPrice != null ||
      (transmission != null && transmission != 'All') ||
      (fuelType != null && fuelType != 'All') ||
      minSeats != null ||
      minRating != null ||
      premiumOnly == true;

  int get activeFilterCount {
    int count = 0;
    if (vehicleType != RentalVehicleType.all) count++;
    if (category != null) count++;
    if (minPrice != null || maxPrice != null) count++;
    if (transmission != null && transmission != 'All') count++;
    if (fuelType != null && fuelType != 'All') count++;
    if (minSeats != null) count++;
    if (minRating != null) count++;
    if (premiumOnly == true) count++;
    return count;
  }

  RentalFilterCriteria copyWith({
    RentalVehicleType? vehicleType,
    String? category,
    double? minPrice,
    double? maxPrice,
    String? transmission,
    String? fuelType,
    int? minSeats,
    double? minRating,
    bool? premiumOnly,
  }) {
    return RentalFilterCriteria(
      vehicleType: vehicleType ?? this.vehicleType,
      category: category ?? this.category,
      minPrice: minPrice ?? this.minPrice,
      maxPrice: maxPrice ?? this.maxPrice,
      transmission: transmission ?? this.transmission,
      fuelType: fuelType ?? this.fuelType,
      minSeats: minSeats ?? this.minSeats,
      minRating: minRating ?? this.minRating,
      premiumOnly: premiumOnly ?? this.premiumOnly,
    );
  }
}

/// Abstract contract for rental data access, easily swappable with HTTP API later.
abstract class RentalRepository {
  Future<List<RentalCityModel>> getCities({bool? availableOnly});

  Future<RentalCityModel?> getCityById(String cityId);

  Future<List<VehicleModel>> getVehicles({
    String? cityId,
    RentalVehicleType? vehicleType,
    String? category,
  });

  Future<List<VehicleModel>> searchVehicles(
    RentalSearchModel search, {
    RentalFilterCriteria? filters,
    RentalSortOption? sort,
  });

  Future<VehicleModel?> getVehicleById(String vehicleId);

  Future<List<VehicleModel>> getFeaturedVehicles(String cityId);

  Future<List<VehicleModel>> getPopularVehicles(String cityId);

  Future<List<VehicleModel>> getPremiumVehicles(String cityId);

  Future<List<RentalBannerCampaign>> getCampaigns();

  Future<List<RentalAddonModel>> getAddonsForVehicle(VehicleModel vehicle);

  Future<List<RentalReviewModel>> getVehicleReviews(String vehicleId);

  Future<RentalBookingModel> createBooking(RentalBookingModel booking);

  Future<List<RentalBookingModel>> getUserBookings();

  Future<RentalBookingModel?> getBookingById(String bookingId);
}
