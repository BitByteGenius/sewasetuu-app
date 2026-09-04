import 'itinerary_day_model.dart';

/// Core model representing a curated travel package
class TripPackageModel {
  final String id;
  final String title;
  final String slug;
  final String destinationId;
  final String destinationName;
  final String destinationState;
  final String shortDescription;
  final String description;
  final String coverImage;
  final List<String> images;
  final int durationDays;
  final int durationNights;
  final double basePrice;
  final double? originalPrice;
  final int discountPercentage;
  final double rating;
  final int reviewCount;
  final int minTravelers;
  final int maxTravelers;
  final List<String> themeIds;
  final List<String> themeNames;
  final List<String> highlights;
  final List<String> includedItems;
  final List<String> excludedItems;
  final List<ItineraryDayModel> itinerary;
  final List<DateTime> availableDates;
  final bool isFeatured;
  final bool isPopular;

  // Cross-module integration points (backend-ready)
  final String? associatedStayId;
  final String? associatedRentalType;
  final String? associatedServiceType;

  final DateTime? createdAt;
  final DateTime? updatedAt;

  const TripPackageModel({
    required this.id,
    required this.title,
    required this.slug,
    required this.destinationId,
    required this.destinationName,
    required this.destinationState,
    required this.shortDescription,
    required this.description,
    required this.coverImage,
    required this.images,
    required this.durationDays,
    required this.durationNights,
    required this.basePrice,
    this.originalPrice,
    this.discountPercentage = 0,
    this.rating = 4.8,
    this.reviewCount = 0,
    this.minTravelers = 1,
    this.maxTravelers = 15,
    this.themeIds = const [],
    this.themeNames = const [],
    this.highlights = const [],
    this.includedItems = const [],
    this.excludedItems = const [],
    this.itinerary = const [],
    this.availableDates = const [],
    this.isFeatured = false,
    this.isPopular = false,
    this.associatedStayId,
    this.associatedRentalType,
    this.associatedServiceType,
    this.createdAt,
    this.updatedAt,
  });

  String get durationText => '$durationDays Days / $durationNights Nights';
  String get locationText => '$destinationName, $destinationState';
  bool get hasDiscount => originalPrice != null && originalPrice! > basePrice;

  factory TripPackageModel.fromJson(Map<String, dynamic> json) {
    return TripPackageModel(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      slug: json['slug'] as String? ?? '',
      destinationId: json['destination_id'] as String? ?? '',
      destinationName: json['destination_name'] as String? ?? '',
      destinationState: json['destination_state'] as String? ?? '',
      shortDescription: json['short_description'] as String? ?? '',
      description: json['description'] as String? ?? '',
      coverImage: json['cover_image'] as String? ?? '',
      images: (json['images'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          const [],
      durationDays: json['duration_days'] as int? ?? 1,
      durationNights: json['duration_nights'] as int? ?? 0,
      basePrice: (json['base_price'] as num?)?.toDouble() ?? 0.0,
      originalPrice: (json['original_price'] as num?)?.toDouble(),
      discountPercentage: json['discount_percentage'] as int? ?? 0,
      rating: (json['rating'] as num?)?.toDouble() ?? 4.8,
      reviewCount: json['review_count'] as int? ?? 0,
      minTravelers: json['min_travelers'] as int? ?? 1,
      maxTravelers: json['max_travelers'] as int? ?? 15,
      themeIds: (json['theme_ids'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          const [],
      themeNames: (json['theme_names'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          const [],
      highlights: (json['highlights'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          const [],
      includedItems: (json['included_items'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          const [],
      excludedItems: (json['excluded_items'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          const [],
      itinerary: (json['itinerary'] as List<dynamic>?)
              ?.map((e) =>
                  ItineraryDayModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      availableDates: (json['available_dates'] as List<dynamic>?)
              ?.map((e) => DateTime.parse(e.toString()))
              .toList() ??
          const [],
      isFeatured: json['is_featured'] as bool? ?? false,
      isPopular: json['is_popular'] as bool? ?? false,
      associatedStayId: json['associated_stay_id'] as String?,
      associatedRentalType: json['associated_rental_type'] as String?,
      associatedServiceType: json['associated_service_type'] as String?,
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'].toString())
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'].toString())
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'slug': slug,
        'destination_id': destinationId,
        'destination_name': destinationName,
        'destination_state': destinationState,
        'short_description': shortDescription,
        'description': description,
        'cover_image': coverImage,
        'images': images,
        'duration_days': durationDays,
        'duration_nights': durationNights,
        'base_price': basePrice,
        'original_price': originalPrice,
        'discount_percentage': discountPercentage,
        'rating': rating,
        'review_count': reviewCount,
        'min_travelers': minTravelers,
        'max_travelers': maxTravelers,
        'theme_ids': themeIds,
        'theme_names': themeNames,
        'highlights': highlights,
        'included_items': includedItems,
        'excluded_items': excludedItems,
        'itinerary': itinerary.map((e) => e.toJson()).toList(),
        'available_dates':
            availableDates.map((e) => e.toIso8601String()).toList(),
        'is_featured': isFeatured,
        'is_popular': isPopular,
        'associated_stay_id': associatedStayId,
        'associated_rental_type': associatedRentalType,
        'associated_service_type': associatedServiceType,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
      };

  TripPackageModel copyWith({
    String? id,
    String? title,
    String? slug,
    String? destinationId,
    String? destinationName,
    String? destinationState,
    String? shortDescription,
    String? description,
    String? coverImage,
    List<String>? images,
    int? durationDays,
    int? durationNights,
    double? basePrice,
    double? originalPrice,
    int? discountPercentage,
    double? rating,
    int? reviewCount,
    int? minTravelers,
    int? maxTravelers,
    List<String>? themeIds,
    List<String>? themeNames,
    List<String>? highlights,
    List<String>? includedItems,
    List<String>? excludedItems,
    List<ItineraryDayModel>? itinerary,
    List<DateTime>? availableDates,
    bool? isFeatured,
    bool? isPopular,
    String? associatedStayId,
    String? associatedRentalType,
    String? associatedServiceType,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return TripPackageModel(
      id: id ?? this.id,
      title: title ?? this.title,
      slug: slug ?? this.slug,
      destinationId: destinationId ?? this.destinationId,
      destinationName: destinationName ?? this.destinationName,
      destinationState: destinationState ?? this.destinationState,
      shortDescription: shortDescription ?? this.shortDescription,
      description: description ?? this.description,
      coverImage: coverImage ?? this.coverImage,
      images: images ?? this.images,
      durationDays: durationDays ?? this.durationDays,
      durationNights: durationNights ?? this.durationNights,
      basePrice: basePrice ?? this.basePrice,
      originalPrice: originalPrice ?? this.originalPrice,
      discountPercentage: discountPercentage ?? this.discountPercentage,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      minTravelers: minTravelers ?? this.minTravelers,
      maxTravelers: maxTravelers ?? this.maxTravelers,
      themeIds: themeIds ?? this.themeIds,
      themeNames: themeNames ?? this.themeNames,
      highlights: highlights ?? this.highlights,
      includedItems: includedItems ?? this.includedItems,
      excludedItems: excludedItems ?? this.excludedItems,
      itinerary: itinerary ?? this.itinerary,
      availableDates: availableDates ?? this.availableDates,
      isFeatured: isFeatured ?? this.isFeatured,
      isPopular: isPopular ?? this.isPopular,
      associatedStayId: associatedStayId ?? this.associatedStayId,
      associatedRentalType: associatedRentalType ?? this.associatedRentalType,
      associatedServiceType: associatedServiceType ?? this.associatedServiceType,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
