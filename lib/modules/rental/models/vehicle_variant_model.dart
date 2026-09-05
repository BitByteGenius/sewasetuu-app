/// Model representing a specific trim/variant of a rental vehicle.
class VehicleVariantModel {
  final String id;
  final String name;
  final String color;
  final String colorCode; // Hex or description
  final String transmission;
  final String fuelType;
  final double pricePerDay;
  final bool isAvailable;
  final String? image;

  const VehicleVariantModel({
    required this.id,
    required this.name,
    required this.color,
    required this.colorCode,
    required this.transmission,
    required this.fuelType,
    required this.pricePerDay,
    this.isAvailable = true,
    this.image,
  });

  VehicleVariantModel copyWith({
    String? id,
    String? name,
    String? color,
    String? colorCode,
    String? transmission,
    String? fuelType,
    double? pricePerDay,
    bool? isAvailable,
    String? image,
  }) {
    return VehicleVariantModel(
      id: id ?? this.id,
      name: name ?? this.name,
      color: color ?? this.color,
      colorCode: colorCode ?? this.colorCode,
      transmission: transmission ?? this.transmission,
      fuelType: fuelType ?? this.fuelType,
      pricePerDay: pricePerDay ?? this.pricePerDay,
      isAvailable: isAvailable ?? this.isAvailable,
      image: image ?? this.image,
    );
  }

  factory VehicleVariantModel.fromJson(Map<String, dynamic> json) {
    return VehicleVariantModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      color: json['color'] as String? ?? '',
      colorCode: json['colorCode'] as String? ?? '#000000',
      transmission: json['transmission'] as String? ?? 'Manual',
      fuelType: json['fuelType'] as String? ?? 'Petrol',
      pricePerDay: (json['pricePerDay'] as num?)?.toDouble() ?? 0.0,
      isAvailable: json['isAvailable'] as bool? ?? true,
      image: json['image'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'color': color,
      'colorCode': colorCode,
      'transmission': transmission,
      'fuelType': fuelType,
      'pricePerDay': pricePerDay,
      'isAvailable': isAvailable,
      'image': image,
    };
  }
}
