/// Model for Room configuration options inside property details
class RoomOptionItem {
  final String id;
  final String title;
  final String bedType;
  final String maxGuests;
  final double pricePerNight;
  final List<String> highlights;

  const RoomOptionItem({
    required this.id,
    required this.title,
    required this.bedType,
    required this.maxGuests,
    required this.pricePerNight,
    required this.highlights,
  });

  factory RoomOptionItem.fromJson(Map<String, dynamic> json) {
    return RoomOptionItem(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      bedType: json['bed_type'] as String? ?? '',
      maxGuests: json['max_guests'] as String? ?? '',
      pricePerNight: (json['price_per_night'] as num?)?.toDouble() ?? 0.0,
      highlights: (json['highlights'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'bed_type': bedType,
        'max_guests': maxGuests,
        'price_per_night': pricePerNight,
        'highlights': highlights,
      };
}

/// Model for property amenities
class AmenityModel {
  final String category;
  final String name;
  final String? icon;

  const AmenityModel({
    required this.category,
    required this.name,
    this.icon,
  });

  factory AmenityModel.fromJson(Map<String, dynamic> json) {
    return AmenityModel(
      category: json['category'] as String? ?? '',
      name: json['name'] as String? ?? '',
      icon: json['icon'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'category': category,
        'name': name,
        'icon': icon,
      };
}
