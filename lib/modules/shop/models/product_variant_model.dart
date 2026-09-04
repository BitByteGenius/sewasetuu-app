/// Model for product options (e.g. Weight: 250g/500g, Size: M/L/XL, Color, Pack)
class ProductVariantModel {
  final String id;
  final String name; // e.g. "500g Pack", "Size Large", "Pure Golden Muga"
  final String type; // e.g. "Weight", "Size", "Material", "Color"
  final String value; // e.g. "500g", "L", "Muga Silk"
  final double priceDelta; // Additional or deducted price difference
  final int stock;
  final bool isAvailable;

  const ProductVariantModel({
    required this.id,
    required this.name,
    required this.type,
    required this.value,
    this.priceDelta = 0.0,
    this.stock = 10,
    this.isAvailable = true,
  });

  factory ProductVariantModel.fromJson(Map<String, dynamic> json) {
    return ProductVariantModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      type: json['type'] as String? ?? 'General',
      value: json['value'] as String? ?? '',
      priceDelta: (json['price_delta'] as num?)?.toDouble() ?? 0.0,
      stock: json['stock'] as int? ?? 10,
      isAvailable: json['is_available'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'type': type,
        'value': value,
        'price_delta': priceDelta,
        'stock': stock,
        'is_available': isAvailable,
      };

  ProductVariantModel copyWith({
    String? id,
    String? name,
    String? type,
    String? value,
    double? priceDelta,
    int? stock,
    bool? isAvailable,
  }) {
    return ProductVariantModel(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      value: value ?? this.value,
      priceDelta: priceDelta ?? this.priceDelta,
      stock: stock ?? this.stock,
      isAvailable: isAvailable ?? this.isAvailable,
    );
  }
}
