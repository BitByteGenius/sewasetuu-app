import 'package:sewasetu/modules/stay/property/domain/entities/stay_entity.dart';
import 'package:sewasetu/shared/enums/stay_type.dart';

class StayHostModel extends StayHostEntity {
  const StayHostModel({
    required super.id,
    required super.name,
    required super.avatarUrl,
    super.isSuperHost,
    super.responseRate,
    super.joinedDate,
  });

  factory StayHostModel.fromJson(Map<String, dynamic> json) {
    return StayHostModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      avatarUrl: json['avatar_url'] as String? ?? '',
      isSuperHost: json['is_super_host'] as bool? ?? false,
      responseRate: json['response_rate'] as String? ?? '98%',
      joinedDate: json['joined_date'] as String? ?? '2023',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'avatar_url': avatarUrl,
      'is_super_host': isSuperHost,
      'response_rate': responseRate,
      'joined_date': joinedDate,
    };
  }
}

class StayModel extends StayEntity {
  const StayModel({
    required super.id,
    required super.title,
    required super.description,
    required super.stayType,
    required super.address,
    required super.city,
    required super.latitude,
    required super.longitude,
    required super.pricePerNight,
    super.pricePerMonth,
    required super.rating,
    required super.reviewsCount,
    required super.images,
    required super.amenities,
    super.isFeatured,
    super.isVerified,
    super.isFavorite,
    required super.host,
    super.availableRooms,
    required super.roomConfiguration,
    required super.distanceText,
  });

  factory StayModel.fromJson(Map<String, dynamic> json) {
    StayType type = StayType.room;
    final typeStr = json['stay_type'] as String? ?? '';
    for (final t in StayType.values) {
      if (t.name.toLowerCase() == typeStr.toLowerCase()) {
        type = t;
        break;
      }
    }

    return StayModel(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      stayType: type,
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
      host: json['host'] != null
          ? StayHostModel.fromJson(json['host'] as Map<String, dynamic>)
          : const StayHostModel(
              id: 'h1',
              name: 'Verified Host',
              avatarUrl: '',
            ),
      availableRooms: json['available_rooms'] as int? ?? 1,
      roomConfiguration: json['room_configuration'] as String? ?? 'Standard Room',
      distanceText: json['distance_text'] as String? ?? 'Nearby',
    );
  }

  Map<String, dynamic> toJson() {
    return {
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
      'available_rooms': availableRooms,
      'room_configuration': roomConfiguration,
      'distance_text': distanceText,
    };
  }
}
