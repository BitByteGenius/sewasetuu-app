import 'product_model.dart';
import 'product_variant_model.dart';

/// Represents an item in the shopping cart
class CartItemModel {
  final ProductModel product;
  final ProductVariantModel? selectedVariant;
  final int quantity;

  const CartItemModel({
    required this.product,
    this.selectedVariant,
    this.quantity = 1,
  });

  /// Unique composite identifier based on product ID and optional variant ID
  String get cartItemId => selectedVariant != null
      ? '${product.id}_${selectedVariant!.id}'
      : product.id;

  /// Effective price considering any variant price delta
  double get unitPrice =>
      product.price + (selectedVariant?.priceDelta ?? 0.0);

  /// Total price for this cart line item
  double get totalPrice => unitPrice * quantity;

  CartItemModel copyWith({
    ProductModel? product,
    ProductVariantModel? selectedVariant,
    int? quantity,
  }) {
    return CartItemModel(
      product: product ?? this.product,
      selectedVariant: selectedVariant ?? this.selectedVariant,
      quantity: quantity ?? this.quantity,
    );
  }

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      product: ProductModel.fromJson(json['product'] as Map<String, dynamic>),
      selectedVariant: json['selected_variant'] != null
          ? ProductVariantModel.fromJson(
              json['selected_variant'] as Map<String, dynamic>)
          : null,
      quantity: json['quantity'] as int? ?? 1,
    );
  }

  Map<String, dynamic> toJson() => {
        'product': product.toJson(),
        'selected_variant': selectedVariant?.toJson(),
        'quantity': quantity,
      };
}
