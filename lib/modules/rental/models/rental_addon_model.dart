import 'vehicle_model.dart';

/// Add-on accessory, service, or protection package available during rental checkout.
class RentalAddonModel {
  final String id;
  final String name;
  final String description;
  final double pricePerDay;
  final double oneTimeFee;
  final String iconName;
  final List<RentalVehicleType> applicableVehicleTypes;
  final bool isRequired;
  final bool isSelected;

  const RentalAddonModel({
    required this.id,
    required this.name,
    required this.description,
    this.pricePerDay = 0.0,
    this.oneTimeFee = 0.0,
    required this.iconName,
    this.applicableVehicleTypes = const [],
    this.isRequired = false,
    this.isSelected = false,
  });

  /// Total cost of this add-on for a given duration in days.
  double calculateCost(int durationDays) {
    final effectiveDays = durationDays > 0 ? durationDays : 1;
    return (pricePerDay * effectiveDays) + oneTimeFee;
  }

  bool isApplicableFor(RentalVehicleType type) {
    if (applicableVehicleTypes.isEmpty) return true;
    return applicableVehicleTypes.contains(type) ||
        applicableVehicleTypes.contains(RentalVehicleType.all);
  }

  RentalAddonModel copyWith({
    String? id,
    String? name,
    String? description,
    double? pricePerDay,
    double? oneTimeFee,
    String? iconName,
    List<RentalVehicleType>? applicableVehicleTypes,
    bool? isRequired,
    bool? isSelected,
  }) {
    return RentalAddonModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      pricePerDay: pricePerDay ?? this.pricePerDay,
      oneTimeFee: oneTimeFee ?? this.oneTimeFee,
      iconName: iconName ?? this.iconName,
      applicableVehicleTypes: applicableVehicleTypes ?? this.applicableVehicleTypes,
      isRequired: isRequired ?? this.isRequired,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  factory RentalAddonModel.fromJson(Map<String, dynamic> json) {
    final typesList = (json['applicableVehicleTypes'] as List<dynamic>?)
            ?.map((e) => RentalVehicleType.values.firstWhere(
                  (t) => t.name.toLowerCase() == e.toString().toLowerCase(),
                  orElse: () => RentalVehicleType.all,
                ))
            .toList() ??
        [];

    return RentalAddonModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      pricePerDay: (json['pricePerDay'] as num?)?.toDouble() ?? 0.0,
      oneTimeFee: (json['oneTimeFee'] as num?)?.toDouble() ?? 0.0,
      iconName: json['iconName'] as String? ?? 'verified',
      applicableVehicleTypes: typesList,
      isRequired: json['isRequired'] as bool? ?? false,
      isSelected: json['isSelected'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'pricePerDay': pricePerDay,
      'oneTimeFee': oneTimeFee,
      'iconName': iconName,
      'applicableVehicleTypes': applicableVehicleTypes.map((e) => e.name).toList(),
      'isRequired': isRequired,
      'isSelected': isSelected,
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RentalAddonModel && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
