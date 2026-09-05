/// Launch status of a city in the rental network.
enum RentalCityLaunchStatus {
  available,
  comingSoon,
  disabled,
}

/// Model representing a city supported or planned in the SewaSetu rental ecosystem.
class RentalCityModel {
  final String id;
  final String name;
  final String state;
  final String country;
  final String image;
  final String description;
  final String shortDescription;
  final bool isAvailable;
  final bool isFeatured;
  final RentalCityLaunchStatus launchStatus;
  final int vehicleCount;
  final double latitude;
  final double longitude;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const RentalCityModel({
    required this.id,
    required this.name,
    required this.state,
    this.country = 'India',
    required this.image,
    required this.description,
    required this.shortDescription,
    this.isAvailable = true,
    this.isFeatured = false,
    this.launchStatus = RentalCityLaunchStatus.available,
    this.vehicleCount = 0,
    required this.latitude,
    required this.longitude,
    this.createdAt,
    this.updatedAt,
  });

  bool get isLive => launchStatus == RentalCityLaunchStatus.available && isAvailable;
  bool get isComingSoon => launchStatus == RentalCityLaunchStatus.comingSoon;

  String get displayName => '$name, $state';

  RentalCityModel copyWith({
    String? id,
    String? name,
    String? state,
    String? country,
    String? image,
    String? description,
    String? shortDescription,
    bool? isAvailable,
    bool? isFeatured,
    RentalCityLaunchStatus? launchStatus,
    int? vehicleCount,
    double? latitude,
    double? longitude,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return RentalCityModel(
      id: id ?? this.id,
      name: name ?? this.name,
      state: state ?? this.state,
      country: country ?? this.country,
      image: image ?? this.image,
      description: description ?? this.description,
      shortDescription: shortDescription ?? this.shortDescription,
      isAvailable: isAvailable ?? this.isAvailable,
      isFeatured: isFeatured ?? this.isFeatured,
      launchStatus: launchStatus ?? this.launchStatus,
      vehicleCount: vehicleCount ?? this.vehicleCount,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory RentalCityModel.fromJson(Map<String, dynamic> json) {
    RentalCityLaunchStatus status = RentalCityLaunchStatus.available;
    final statusStr = json['launchStatus'] as String?;
    if (statusStr != null) {
      status = RentalCityLaunchStatus.values.firstWhere(
        (e) => e.name.toLowerCase() == statusStr.toLowerCase(),
        orElse: () => RentalCityLaunchStatus.available,
      );
    }

    return RentalCityModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      state: json['state'] as String? ?? '',
      country: json['country'] as String? ?? 'India',
      image: json['image'] as String? ?? '',
      description: json['description'] as String? ?? '',
      shortDescription: json['shortDescription'] as String? ?? '',
      isAvailable: json['isAvailable'] as bool? ?? true,
      isFeatured: json['isFeatured'] as bool? ?? false,
      launchStatus: status,
      vehicleCount: json['vehicleCount'] as int? ?? 0,
      latitude: (json['latitude'] as num?)?.toDouble() ?? 0.0,
      longitude: (json['longitude'] as num?)?.toDouble() ?? 0.0,
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
      'name': name,
      'state': state,
      'country': country,
      'image': image,
      'description': description,
      'shortDescription': shortDescription,
      'isAvailable': isAvailable,
      'isFeatured': isFeatured,
      'launchStatus': launchStatus.name,
      'vehicleCount': vehicleCount,
      'latitude': latitude,
      'longitude': longitude,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RentalCityModel && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
