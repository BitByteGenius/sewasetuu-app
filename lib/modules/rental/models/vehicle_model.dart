import 'vehicle_feature_model.dart';
import 'vehicle_specification_model.dart';
import 'vehicle_variant_model.dart';

/// Supported vehicle classifications in the rental platform.
enum RentalVehicleType {
  all,
  car,
  bike,
  scooter,
  suv,
  luxury,
  electric,
}

extension RentalVehicleTypeExtension on RentalVehicleType {
  String get label {
    switch (this) {
      case RentalVehicleType.all:
        return 'All Rides';
      case RentalVehicleType.car:
        return 'Cars';
      case RentalVehicleType.bike:
        return 'Bikes';
      case RentalVehicleType.scooter:
        return 'Scooters';
      case RentalVehicleType.suv:
        return 'SUVs';
      case RentalVehicleType.luxury:
        return 'Luxury';
      case RentalVehicleType.electric:
        return 'Electric';
    }
  }

  String get iconKey {
    switch (this) {
      case RentalVehicleType.all:
        return 'grid_view';
      case RentalVehicleType.car:
        return 'directions_car';
      case RentalVehicleType.bike:
        return 'two_wheeler';
      case RentalVehicleType.scooter:
        return 'electric_moped';
      case RentalVehicleType.suv:
        return 'airport_shuttle';
      case RentalVehicleType.luxury:
        return 'stars';
      case RentalVehicleType.electric:
        return 'bolt';
    }
  }
}

/// Core vehicle entity model representing any rentable two-wheeler or four-wheeler.
class VehicleModel {
  final String id;
  final String brand;
  final String name;
  final String model;
  final RentalVehicleType vehicleType;
  final String category; // e.g. 'SUV', 'Sedan', 'Cruiser', 'Sports', 'Electric'
  final List<String> images;
  final String description;
  final List<String> cityIds;
  final double rating;
  final int reviewCount;
  final double pricePerHour;
  final double pricePerDay;
  final double securityDeposit;
  final String transmission; // 'Automatic', 'Manual'
  final String fuelType; // 'Petrol', 'Diesel', 'Electric', 'Hybrid'
  final int seats;
  final String mileage; // e.g. '18 km/l' or '450 km range'
  final String enginePower; // e.g. '1500 cc' or '150 kW'
  final int topSpeedKmH;
  final int year;
  final int freeCancellationHours;
  final List<VehicleFeatureModel> features;
  final List<VehicleSpecificationModel> specifications;
  final List<VehicleVariantModel> variants;
  final bool isAvailable;
  final bool isFeatured;
  final bool isPopular;
  final bool isPremium;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const VehicleModel({
    required this.id,
    required this.brand,
    required this.name,
    required this.model,
    required this.vehicleType,
    required this.category,
    required this.images,
    required this.description,
    required this.cityIds,
    this.rating = 4.8,
    this.reviewCount = 0,
    required this.pricePerHour,
    required this.pricePerDay,
    this.securityDeposit = 0.0,
    required this.transmission,
    required this.fuelType,
    this.seats = 4,
    required this.mileage,
    this.enginePower = '',
    this.topSpeedKmH = 140,
    this.year = 2024,
    this.freeCancellationHours = 6,
    this.features = const [],
    this.specifications = const [],
    this.variants = const [],
    this.isAvailable = true,
    this.isFeatured = false,
    this.isPopular = false,
    this.isPremium = false,
    this.createdAt,
    this.updatedAt,
  });

  String get fullName => '$brand $name';

  String get primaryImage => images.isNotEmpty ? images.first : '';

  bool isAvailableInCity(String cityId) => cityIds.contains(cityId);

  bool get isTwoWheeler =>
      vehicleType == RentalVehicleType.bike || vehicleType == RentalVehicleType.scooter;

  VehicleModel copyWith({
    String? id,
    String? brand,
    String? name,
    String? model,
    RentalVehicleType? vehicleType,
    String? category,
    List<String>? images,
    String? description,
    List<String>? cityIds,
    double? rating,
    int? reviewCount,
    double? pricePerHour,
    double? pricePerDay,
    double? securityDeposit,
    String? transmission,
    String? fuelType,
    int? seats,
    String? mileage,
    String? enginePower,
    int? topSpeedKmH,
    int? year,
    int? freeCancellationHours,
    List<VehicleFeatureModel>? features,
    List<VehicleSpecificationModel>? specifications,
    List<VehicleVariantModel>? variants,
    bool? isAvailable,
    bool? isFeatured,
    bool? isPopular,
    bool? isPremium,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return VehicleModel(
      id: id ?? this.id,
      brand: brand ?? this.brand,
      name: name ?? this.name,
      model: model ?? this.model,
      vehicleType: vehicleType ?? this.vehicleType,
      category: category ?? this.category,
      images: images ?? this.images,
      description: description ?? this.description,
      cityIds: cityIds ?? this.cityIds,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      pricePerHour: pricePerHour ?? this.pricePerHour,
      pricePerDay: pricePerDay ?? this.pricePerDay,
      securityDeposit: securityDeposit ?? this.securityDeposit,
      transmission: transmission ?? this.transmission,
      fuelType: fuelType ?? this.fuelType,
      seats: seats ?? this.seats,
      mileage: mileage ?? this.mileage,
      enginePower: enginePower ?? this.enginePower,
      topSpeedKmH: topSpeedKmH ?? this.topSpeedKmH,
      year: year ?? this.year,
      freeCancellationHours: freeCancellationHours ?? this.freeCancellationHours,
      features: features ?? this.features,
      specifications: specifications ?? this.specifications,
      variants: variants ?? this.variants,
      isAvailable: isAvailable ?? this.isAvailable,
      isFeatured: isFeatured ?? this.isFeatured,
      isPopular: isPopular ?? this.isPopular,
      isPremium: isPremium ?? this.isPremium,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory VehicleModel.fromJson(Map<String, dynamic> json) {
    RentalVehicleType type = RentalVehicleType.car;
    final typeStr = json['vehicleType'] as String?;
    if (typeStr != null) {
      type = RentalVehicleType.values.firstWhere(
        (e) => e.name.toLowerCase() == typeStr.toLowerCase(),
        orElse: () => RentalVehicleType.car,
      );
    }

    return VehicleModel(
      id: json['id'] as String? ?? '',
      brand: json['brand'] as String? ?? '',
      name: json['name'] as String? ?? '',
      model: json['model'] as String? ?? '',
      vehicleType: type,
      category: json['category'] as String? ?? 'General',
      images: (json['images'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      description: json['description'] as String? ?? '',
      cityIds: (json['cityIds'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      rating: (json['rating'] as num?)?.toDouble() ?? 4.8,
      reviewCount: json['reviewCount'] as int? ?? 0,
      pricePerHour: (json['pricePerHour'] as num?)?.toDouble() ?? 0.0,
      pricePerDay: (json['pricePerDay'] as num?)?.toDouble() ?? 0.0,
      securityDeposit: (json['securityDeposit'] as num?)?.toDouble() ?? 0.0,
      transmission: json['transmission'] as String? ?? 'Manual',
      fuelType: json['fuelType'] as String? ?? 'Petrol',
      seats: json['seats'] as int? ?? 4,
      mileage: json['mileage'] as String? ?? '',
      enginePower: json['enginePower'] as String? ?? '',
      topSpeedKmH: json['topSpeedKmH'] as int? ?? 140,
      year: json['year'] as int? ?? 2024,
      freeCancellationHours: json['freeCancellationHours'] as int? ?? 6,
      features: (json['features'] as List<dynamic>?)
              ?.map((e) =>
                  VehicleFeatureModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      specifications: (json['specifications'] as List<dynamic>?)
              ?.map((e) =>
                  VehicleSpecificationModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      variants: (json['variants'] as List<dynamic>?)
              ?.map((e) =>
                  VehicleVariantModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      isAvailable: json['isAvailable'] as bool? ?? true,
      isFeatured: json['isFeatured'] as bool? ?? false,
      isPopular: json['isPopular'] as bool? ?? false,
      isPremium: json['isPremium'] as bool? ?? false,
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'] as String)
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.tryParse(json['updatedAt'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'brand': brand,
      'name': name,
      'model': model,
      'vehicleType': vehicleType.name,
      'category': category,
      'images': images,
      'description': description,
      'cityIds': cityIds,
      'rating': rating,
      'reviewCount': reviewCount,
      'pricePerHour': pricePerHour,
      'pricePerDay': pricePerDay,
      'securityDeposit': securityDeposit,
      'transmission': transmission,
      'fuelType': fuelType,
      'seats': seats,
      'mileage': mileage,
      'enginePower': enginePower,
      'topSpeedKmH': topSpeedKmH,
      'year': year,
      'freeCancellationHours': freeCancellationHours,
      'features': features.map((e) => e.toJson()).toList(),
      'specifications': specifications.map((e) => e.toJson()).toList(),
      'variants': variants.map((e) => e.toJson()).toList(),
      'isAvailable': isAvailable,
      'isFeatured': isFeatured,
      'isPopular': isPopular,
      'isPremium': isPremium,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VehicleModel && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
