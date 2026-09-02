import 'package:sewasetu/shared/enums/stay_type.dart';

/// Host information for property
class StayHostEntity {
  final String id;
  final String name;
  final String avatarUrl;
  final bool isSuperHost;
  final String responseRate;
  final String joinedDate;

  const StayHostEntity({
    required this.id,
    required this.name,
    required this.avatarUrl,
    this.isSuperHost = false,
    this.responseRate = '99%',
    this.joinedDate = '2022',
  });
}

/// Core domain entity representing a Stay / Accommodation
class StayEntity {
  final String id;
  final String title;
  final String description;
  final StayType stayType;
  final String address;
  final String city;
  final double latitude;
  final double longitude;
  final double pricePerNight;
  final double? pricePerMonth;
  final double rating;
  final int reviewsCount;
  final List<String> images;
  final List<String> amenities;
  final bool isFeatured;
  final bool isVerified;
  final bool isFavorite;
  final StayHostEntity host;
  final int availableRooms;
  final String roomConfiguration; // e.g., "1 BHK Private Room", "Double Sharing"
  final String distanceText; // e.g., "1.2 km from City Center"

  const StayEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.stayType,
    required this.address,
    required this.city,
    required this.latitude,
    required this.longitude,
    required this.pricePerNight,
    this.pricePerMonth,
    required this.rating,
    required this.reviewsCount,
    required this.images,
    required this.amenities,
    this.isFeatured = false,
    this.isVerified = false,
    this.isFavorite = false,
    required this.host,
    this.availableRooms = 1,
    required this.roomConfiguration,
    required this.distanceText,
  });

  StayEntity copyWith({
    bool? isFavorite,
  }) {
    return StayEntity(
      id: id,
      title: title,
      description: description,
      stayType: stayType,
      address: address,
      city: city,
      latitude: latitude,
      longitude: longitude,
      pricePerNight: pricePerNight,
      pricePerMonth: pricePerMonth,
      rating: rating,
      reviewsCount: reviewsCount,
      images: images,
      amenities: amenities,
      isFeatured: isFeatured,
      isVerified: isVerified,
      isFavorite: isFavorite ?? this.isFavorite,
      host: host,
      availableRooms: availableRooms,
      roomConfiguration: roomConfiguration,
      distanceText: distanceText,
    );
  }
}
