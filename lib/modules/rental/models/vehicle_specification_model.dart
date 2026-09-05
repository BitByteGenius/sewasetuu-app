/// Key automotive specifications for a vehicle in the rental catalog.
class VehicleSpecificationModel {
  final String key;
  final String label;
  final String value;
  final String? iconName;

  const VehicleSpecificationModel({
    required this.key,
    required this.label,
    required this.value,
    this.iconName,
  });

  VehicleSpecificationModel copyWith({
    String? key,
    String? label,
    String? value,
    String? iconName,
  }) {
    return VehicleSpecificationModel(
      key: key ?? this.key,
      label: label ?? this.label,
      value: value ?? this.value,
      iconName: iconName ?? this.iconName,
    );
  }

  factory VehicleSpecificationModel.fromJson(Map<String, dynamic> json) {
    return VehicleSpecificationModel(
      key: json['key'] as String? ?? '',
      label: json['label'] as String? ?? '',
      value: json['value'] as String? ?? '',
      iconName: json['iconName'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'key': key,
      'label': label,
      'value': value,
      'iconName': iconName,
    };
  }
}
