import 'package:sewasetu/shared/enums/stay_type.dart';

/// Filter criteria parameters for filtering stays
class StayFilterCriteria {
  final StayType? stayType;
  final String? roomCategory;
  final double? minPrice;
  final double? maxPrice;
  final double? minRating;
  final List<String> amenities;
  final String? city;
  final bool? verifiedOnly;
  final double? userLatitude;
  final double? userLongitude;
  final double? maxRadiusMeters;

  const StayFilterCriteria({
    this.stayType,
    this.roomCategory,
    this.minPrice,
    this.maxPrice,
    this.minRating,
    this.amenities = const [],
    this.city,
    this.verifiedOnly,
    this.userLatitude,
    this.userLongitude,
    this.maxRadiusMeters,
  });

  factory StayFilterCriteria.fromJson(Map<String, dynamic> json) {
    return StayFilterCriteria(
      stayType: json['stay_type'] != null
          ? StayType.values.firstWhere(
              (e) => e.name == json['stay_type'],
              orElse: () => StayType.room,
            )
          : null,
      roomCategory: json['room_category'] as String?,
      minPrice: (json['min_price'] as num?)?.toDouble(),
      maxPrice: (json['max_price'] as num?)?.toDouble(),
      minRating: (json['min_rating'] as num?)?.toDouble(),
      amenities: (json['amenities'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      city: json['city'] as String?,
      verifiedOnly: json['verified_only'] as bool?,
      userLatitude: (json['user_latitude'] as num?)?.toDouble(),
      userLongitude: (json['user_longitude'] as num?)?.toDouble(),
      maxRadiusMeters: (json['max_radius_meters'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
        'stay_type': stayType?.name,
        'room_category': roomCategory,
        'min_price': minPrice,
        'max_price': maxPrice,
        'min_rating': minRating,
        'amenities': amenities,
        'city': city,
        'verified_only': verifiedOnly,
        'user_latitude': userLatitude,
        'user_longitude': userLongitude,
        'max_radius_meters': maxRadiusMeters,
      };

  StayFilterCriteria copyWith({
    StayType? stayType,
    String? roomCategory,
    double? minPrice,
    double? maxPrice,
    double? minRating,
    List<String>? amenities,
    String? city,
    bool? verifiedOnly,
    double? userLatitude,
    double? userLongitude,
    double? maxRadiusMeters,
  }) {
    return StayFilterCriteria(
      stayType: stayType ?? this.stayType,
      roomCategory: roomCategory ?? this.roomCategory,
      minPrice: minPrice ?? this.minPrice,
      maxPrice: maxPrice ?? this.maxPrice,
      minRating: minRating ?? this.minRating,
      amenities: amenities ?? this.amenities,
      city: city ?? this.city,
      verifiedOnly: verifiedOnly ?? this.verifiedOnly,
      userLatitude: userLatitude ?? this.userLatitude,
      userLongitude: userLongitude ?? this.userLongitude,
      maxRadiusMeters: maxRadiusMeters ?? this.maxRadiusMeters,
    );
  }

  bool get hasActiveFilters =>
      stayType != null ||
      (roomCategory != null && roomCategory!.isNotEmpty && roomCategory != 'All') ||
      minPrice != null ||
      maxPrice != null ||
      minRating != null ||
      amenities.isNotEmpty ||
      verifiedOnly == true ||
      maxRadiusMeters != null;
}
