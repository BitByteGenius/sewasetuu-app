import 'vehicle_model.dart';

/// Search query criteria for discovering rental vehicles.
class RentalSearchModel {
  final String cityId;
  final String cityName;
  final DateTime pickupDateTime;
  final DateTime returnDateTime;
  final String pickupLocation;
  final String dropoffLocation;
  final bool isSameDropoff;
  final RentalVehicleType vehicleType;
  final String? category;

  RentalSearchModel({
    this.cityId = '',
    this.cityName = '',
    DateTime? pickupDateTime,
    DateTime? returnDateTime,
    this.pickupLocation = 'City Center Hub',
    this.dropoffLocation = 'City Center Hub',
    this.isSameDropoff = true,
    this.vehicleType = RentalVehicleType.all,
    this.category,
  })  : pickupDateTime = pickupDateTime ?? _defaultPickupTime(),
        returnDateTime = returnDateTime ?? _defaultReturnTime();

  static DateTime _defaultPickupTime() {
    final now = DateTime.now();
    // Default to tomorrow 10:00 AM
    return DateTime(now.year, now.month, now.day + 1, 10, 0);
  }

  static DateTime _defaultReturnTime() {
    final now = DateTime.now();
    // Default to day after tomorrow 10:00 AM (24 hours minimum)
    return DateTime(now.year, now.month, now.day + 2, 10, 0);
  }

  /// Total duration in hours between pickup and return.
  int get durationHours {
    final diff = returnDateTime.difference(pickupDateTime).inHours;
    return diff > 0 ? diff : 0;
  }

  /// Total duration in rental billing days (rounded up to nearest full day).
  int get durationDays {
    final hours = returnDateTime.difference(pickupDateTime).inHours;
    if (hours <= 0) return 1;
    return (hours / 24).ceil();
  }

  /// Checks if search input parameters are valid.
  bool get isValid {
    return cityId.isNotEmpty &&
        returnDateTime.isAfter(pickupDateTime) &&
        durationHours >= 2;
  }

  /// Returns user-friendly validation error if criteria are invalid.
  String? get validationError {
    if (cityId.isEmpty) {
      return 'Please select a city to continue';
    }
    if (pickupDateTime.isBefore(DateTime.now().subtract(const Duration(minutes: 5)))) {
      return 'Pickup time cannot be in the past';
    }
    if (!returnDateTime.isAfter(pickupDateTime)) {
      return 'Return time must be after pickup time';
    }
    if (durationHours < 2) {
      return 'Minimum rental duration is 2 hours';
    }
    return null;
  }

  RentalSearchModel copyWith({
    String? cityId,
    String? cityName,
    DateTime? pickupDateTime,
    DateTime? returnDateTime,
    String? pickupLocation,
    String? dropoffLocation,
    bool? isSameDropoff,
    RentalVehicleType? vehicleType,
    String? category,
  }) {
    return RentalSearchModel(
      cityId: cityId ?? this.cityId,
      cityName: cityName ?? this.cityName,
      pickupDateTime: pickupDateTime ?? this.pickupDateTime,
      returnDateTime: returnDateTime ?? this.returnDateTime,
      pickupLocation: pickupLocation ?? this.pickupLocation,
      dropoffLocation: dropoffLocation ?? this.dropoffLocation,
      isSameDropoff: isSameDropoff ?? this.isSameDropoff,
      vehicleType: vehicleType ?? this.vehicleType,
      category: category ?? this.category,
    );
  }

  factory RentalSearchModel.fromJson(Map<String, dynamic> json) {
    RentalVehicleType type = RentalVehicleType.all;
    final typeStr = json['vehicleType'] as String?;
    if (typeStr != null) {
      type = RentalVehicleType.values.firstWhere(
        (e) => e.name.toLowerCase() == typeStr.toLowerCase(),
        orElse: () => RentalVehicleType.all,
      );
    }

    return RentalSearchModel(
      cityId: json['cityId'] as String? ?? '',
      cityName: json['cityName'] as String? ?? '',
      pickupDateTime: json['pickupDateTime'] != null
          ? DateTime.tryParse(json['pickupDateTime'] as String)
          : null,
      returnDateTime: json['returnDateTime'] != null
          ? DateTime.tryParse(json['returnDateTime'] as String)
          : null,
      pickupLocation: json['pickupLocation'] as String? ?? 'City Center Hub',
      dropoffLocation: json['dropoffLocation'] as String? ?? 'City Center Hub',
      isSameDropoff: json['isSameDropoff'] as bool? ?? true,
      vehicleType: type,
      category: json['category'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cityId': cityId,
      'cityName': cityName,
      'pickupDateTime': pickupDateTime.toIso8601String(),
      'returnDateTime': returnDateTime.toIso8601String(),
      'pickupLocation': pickupLocation,
      'dropoffLocation': dropoffLocation,
      'isSameDropoff': isSameDropoff,
      'vehicleType': vehicleType.name,
      'category': category,
    };
  }
}
