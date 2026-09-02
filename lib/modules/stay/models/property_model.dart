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

  factory StayHostEntity.fromJson(Map<String, dynamic> json) {
    return StayHostEntity(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      avatarUrl: json['avatar_url'] as String? ?? '',
      isSuperHost: json['is_super_host'] as bool? ?? false,
      responseRate: json['response_rate'] as String? ?? '99%',
      joinedDate: json['joined_date'] as String? ?? '2022',
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'avatar_url': avatarUrl,
        'is_super_host': isSuperHost,
        'response_rate': responseRate,
        'joined_date': joinedDate,
      };
}

/// Core model representing a Stay / Accommodation Property
class PropertyModel {
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
  final String roomConfiguration;
  final String distanceText;

  const PropertyModel({
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

  factory PropertyModel.fromJson(Map<String, dynamic> json) {
    return PropertyModel(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      stayType: StayType.values.firstWhere(
        (e) => e.name == json['stay_type'],
        orElse: () => StayType.room,
      ),
      address: json['address'] as String? ?? '',
      city: json['city'] as String? ?? '',
      latitude: (json['latitude'] as num?)?.toDouble() ?? 0.0,
      longitude: (json['longitude'] as num?)?.toDouble() ?? 0.0,
      pricePerNight: (json['price_per_night'] as num?)?.toDouble() ?? 0.0,
      pricePerMonth: (json['price_per_month'] as num?)?.toDouble(),
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      reviewsCount: json['reviews_count'] as int? ?? 0,
      images: (json['images'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [],
      amenities: (json['amenities'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [],
      isFeatured: json['is_featured'] as bool? ?? false,
      isVerified: json['is_verified'] as bool? ?? false,
      isFavorite: json['is_favorite'] as bool? ?? false,
      host: StayHostEntity.fromJson(json['host'] as Map<String, dynamic>? ?? {}),
      availableRooms: json['available_rooms'] as int? ?? 1,
      roomConfiguration: json['room_configuration'] as String? ?? '',
      distanceText: json['distance_text'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'stay_type': stayType.name,
        'address': address,
        'city': city,
        'latitude': latitude,
        'longitude': longitude,
        'price_per_night': pricePerNight,
        'price_per_month': pricePerMonth,
        'rating': rating,
        'reviews_count': reviewsCount,
        'images': images,
        'amenities': amenities,
        'is_featured': isFeatured,
        'is_verified': isVerified,
        'is_favorite': isFavorite,
        'host': host.toJson(),
        'available_rooms': availableRooms,
        'room_configuration': roomConfiguration,
        'distance_text': distanceText,
      };

  PropertyModel copyWith({
    String? id,
    String? title,
    String? description,
    StayType? stayType,
    String? address,
    String? city,
    double? latitude,
    double? longitude,
    double? pricePerNight,
    double? pricePerMonth,
    double? rating,
    int? reviewsCount,
    List<String>? images,
    List<String>? amenities,
    bool? isFeatured,
    bool? isVerified,
    bool? isFavorite,
    StayHostEntity? host,
    int? availableRooms,
    String? roomConfiguration,
    String? distanceText,
  }) {
    return PropertyModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      stayType: stayType ?? this.stayType,
      address: address ?? this.address,
      city: city ?? this.city,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      pricePerNight: pricePerNight ?? this.pricePerNight,
      pricePerMonth: pricePerMonth ?? this.pricePerMonth,
      rating: rating ?? this.rating,
      reviewsCount: reviewsCount ?? this.reviewsCount,
      images: images ?? this.images,
      amenities: amenities ?? this.amenities,
      isFeatured: isFeatured ?? this.isFeatured,
      isVerified: isVerified ?? this.isVerified,
      isFavorite: isFavorite ?? this.isFavorite,
      host: host ?? this.host,
      availableRooms: availableRooms ?? this.availableRooms,
      roomConfiguration: roomConfiguration ?? this.roomConfiguration,
      distanceText: distanceText ?? this.distanceText,
    );
  }
}

typedef StayEntity = PropertyModel;
