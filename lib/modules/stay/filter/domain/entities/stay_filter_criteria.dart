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
