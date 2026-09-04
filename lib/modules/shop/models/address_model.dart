/// Model representing a customer delivery address for shop orders
class ShopAddressModel {
  final String id;
  final String fullName;
  final String phone;
  final String streetAddress;
  final String landmark;
  final String city;
  final String state;
  final String pincode;
  final bool isDefault;

  const ShopAddressModel({
    required this.id,
    required this.fullName,
    required this.phone,
    required this.streetAddress,
    this.landmark = '',
    required this.city,
    required this.state,
    required this.pincode,
    this.isDefault = false,
  });

  String get formattedAddress =>
      '$streetAddress${landmark.isNotEmpty ? ', Near $landmark' : ''}, $city, $state - $pincode';

  factory ShopAddressModel.fromJson(Map<String, dynamic> json) {
    return ShopAddressModel(
      id: json['id'] as String? ?? '',
      fullName: json['full_name'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
      streetAddress: json['street_address'] as String? ?? '',
      landmark: json['landmark'] as String? ?? '',
      city: json['city'] as String? ?? '',
      state: json['state'] as String? ?? '',
      pincode: json['pincode'] as String? ?? '',
      isDefault: json['is_default'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'full_name': fullName,
        'phone': phone,
        'street_address': streetAddress,
        'landmark': landmark,
        'city': city,
        'state': state,
        'pincode': pincode,
        'is_default': isDefault,
      };

  ShopAddressModel copyWith({
    String? id,
    String? fullName,
    String? phone,
    String? streetAddress,
    String? landmark,
    String? city,
    String? state,
    String? pincode,
    bool? isDefault,
  }) {
    return ShopAddressModel(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      phone: phone ?? this.phone,
      streetAddress: streetAddress ?? this.streetAddress,
      landmark: landmark ?? this.landmark,
      city: city ?? this.city,
      state: state ?? this.state,
      pincode: pincode ?? this.pincode,
      isDefault: isDefault ?? this.isDefault,
    );
  }
}
