import 'package:sewasetu/shared/enums/stay_type.dart';

/// Filter criteria parameters for filtering stays
class StayFilterCriteria {
  final StayType? stayType;
  final double? minPrice;
  final double? maxPrice;
  final double? minRating;
  final List<String> amenities;
  final String? city;
  final bool? verifiedOnly;

  const StayFilterCriteria({
    this.stayType,
    this.minPrice,
    this.maxPrice,
    this.minRating,
    this.amenities = const [],
    this.city,
    this.verifiedOnly,
  });

  factory StayFilterCriteria.fromJson(Map<String, dynamic> json) {
    return StayFilterCriteria(
      stayType: json['stay_type'] != null
          ? StayType.values.firstWhere(
              (e) => e.name == json['stay_type'],
              orElse: () => StayType.room,
            )
          : null,
      minPrice: (json['min_price'] as num?)?.toDouble(),
      maxPrice: (json['max_price'] as num?)?.toDouble(),
      minRating: (json['min_rating'] as num?)?.toDouble(),
      amenities: (json['amenities'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [],
      city: json['city'] as String?,
      verifiedOnly: json['verified_only'] as bool?,
    );
  }

  Map<String, dynamic> toJson() => {
        'stay_type': stayType?.name,
        'min_price': minPrice,
        'max_price': maxPrice,
        'min_rating': minRating,
        'amenities': amenities,
        'city': city,
        'verified_only': verifiedOnly,
      };

  StayFilterCriteria copyWith({
    StayType? stayType,
    double? minPrice,
    double? maxPrice,
    double? minRating,
    List<String>? amenities,
    String? city,
    bool? verifiedOnly,
  }) {
    return StayFilterCriteria(
      stayType: stayType ?? this.stayType,
      minPrice: minPrice ?? this.minPrice,
      maxPrice: maxPrice ?? this.maxPrice,
      minRating: minRating ?? this.minRating,
      amenities: amenities ?? this.amenities,
      city: city ?? this.city,
      verifiedOnly: verifiedOnly ?? this.verifiedOnly,
    );
  }

  bool get hasActiveFilters =>
      stayType != null ||
      minPrice != null ||
      maxPrice != null ||
      minRating != null ||
      amenities.isNotEmpty ||
      verifiedOnly == true;
}
