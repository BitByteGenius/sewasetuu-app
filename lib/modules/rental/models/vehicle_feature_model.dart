/// Model representing a standard or optional feature of a rental vehicle.
class VehicleFeatureModel {
  final String id;
  final String name;
  final String? description;
  final String icon;
  final String category; // 'safety', 'comfort', 'tech', 'convenience'
  final bool isStandard;

  const VehicleFeatureModel({
    required this.id,
    required this.name,
    this.description,
    required this.icon,
    this.category = 'comfort',
    this.isStandard = true,
  });

  VehicleFeatureModel copyWith({
    String? id,
    String? name,
    String? description,
    String? icon,
    String? category,
    bool? isStandard,
  }) {
    return VehicleFeatureModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      icon: icon ?? this.icon,
      category: category ?? this.category,
      isStandard: isStandard ?? this.isStandard,
    );
  }

  factory VehicleFeatureModel.fromJson(Map<String, dynamic> json) {
    return VehicleFeatureModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      description: json['description'] as String?,
      icon: json['icon'] as String? ?? 'check_circle',
      category: json['category'] as String? ?? 'comfort',
      isStandard: json['isStandard'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'icon': icon,
      'category': category,
      'isStandard': isStandard,
    };
  }
}
