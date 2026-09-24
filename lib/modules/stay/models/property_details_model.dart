/// Model for Room configuration options inside property details
class RoomOptionItem {
  final String id;
  final String title;
  final String bedType;
  final String maxGuests;
  final double pricePerNight;
  final double? pricePerMonth;
  final List<String> highlights;

  const RoomOptionItem({
    required this.id,
    required this.title,
    required this.bedType,
    required this.maxGuests,
    required this.pricePerNight,
    this.pricePerMonth,
    required this.highlights,
  });

  /// Computes effective monthly price with dynamic fallback (~15% long-stay discount)
  double get displayPricePerMonth {
    if (pricePerMonth != null && pricePerMonth! > 0) {
      return pricePerMonth!;
    }
    if (pricePerNight > 0) {
      return (pricePerNight * 30 * 0.85).roundToDouble();
    }
    return 0.0;
  }

  factory RoomOptionItem.fromJson(Map<String, dynamic> json) {
    return RoomOptionItem(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      bedType: json['bed_type'] as String? ?? '',
      maxGuests: json['max_guests'] as String? ?? '',
      pricePerNight: (json['price_per_night'] as num?)?.toDouble() ?? 0.0,
      pricePerMonth: (json['price_per_month'] as num?)?.toDouble(),
      highlights: (json['highlights'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'bed_type': bedType,
        'max_guests': maxGuests,
        'price_per_night': pricePerNight,
        'price_per_month': pricePerMonth,
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
