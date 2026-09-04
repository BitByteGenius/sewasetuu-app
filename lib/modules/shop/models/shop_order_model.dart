import 'address_model.dart';
import 'cart_item_model.dart';

enum ShopOrderStatus {
  pending('Order Placed', 'Your order has been recorded'),
  confirmed('Confirmed', 'Artisan / Seller is preparing your order'),
  shipped('Shipped', 'Handed over to delivery courier partner'),
  delivered('Delivered', 'Order handed over successfully'),
  cancelled('Cancelled', 'Order has been cancelled');

  final String label;
  final String description;

  const ShopOrderStatus(this.label, this.description);
}

/// Model representing a placed e-commerce order
class ShopOrderModel {
  final String id;
  final String orderNumber;
  final List<CartItemModel> items;
  final double subtotal;
  final double deliveryFee;
  final double discount;
  final double total;
  final ShopOrderStatus status;
  final ShopAddressModel deliveryAddress;
  final String paymentMethod;
  final DateTime createdAt;
  final String estimatedDelivery;

  const ShopOrderModel({
    required this.id,
    required this.orderNumber,
    required this.items,
    required this.subtotal,
    required this.deliveryFee,
    required this.discount,
    required this.total,
    this.status = ShopOrderStatus.confirmed,
    required this.deliveryAddress,
    required this.paymentMethod,
    required this.createdAt,
    this.estimatedDelivery = '4-6 business days',
  });

  factory ShopOrderModel.fromJson(Map<String, dynamic> json) {
    return ShopOrderModel(
      id: json['id'] as String? ?? '',
      orderNumber: json['order_number'] as String? ?? '',
      items: (json['items'] as List<dynamic>?)
              ?.map((e) => CartItemModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      subtotal: (json['subtotal'] as num?)?.toDouble() ?? 0.0,
      deliveryFee: (json['delivery_fee'] as num?)?.toDouble() ?? 0.0,
      discount: (json['discount'] as num?)?.toDouble() ?? 0.0,
      total: (json['total'] as num?)?.toDouble() ?? 0.0,
      status: ShopOrderStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => ShopOrderStatus.confirmed,
      ),
      deliveryAddress: ShopAddressModel.fromJson(
          json['delivery_address'] as Map<String, dynamic>),
      paymentMethod: json['payment_method'] as String? ?? 'UPI',
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'] as String) ?? DateTime.now()
          : DateTime.now(),
      estimatedDelivery:
          json['estimated_delivery'] as String? ?? '4-6 business days',
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'order_number': orderNumber,
        'items': items.map((e) => e.toJson()).toList(),
        'subtotal': subtotal,
        'delivery_fee': deliveryFee,
        'discount': discount,
        'total': total,
        'status': status.name,
        'delivery_address': deliveryAddress.toJson(),
        'payment_method': paymentMethod,
        'created_at': createdAt.toIso8601String(),
        'estimated_delivery': estimatedDelivery,
      };

  ShopOrderModel copyWith({
    String? id,
    String? orderNumber,
    List<CartItemModel>? items,
    double? subtotal,
    double? deliveryFee,
    double? discount,
    double? total,
    ShopOrderStatus? status,
    ShopAddressModel? deliveryAddress,
    String? paymentMethod,
    DateTime? createdAt,
    String? estimatedDelivery,
  }) {
    return ShopOrderModel(
      id: id ?? this.id,
      orderNumber: orderNumber ?? this.orderNumber,
      items: items ?? this.items,
      subtotal: subtotal ?? this.subtotal,
      deliveryFee: deliveryFee ?? this.deliveryFee,
      discount: discount ?? this.discount,
      total: total ?? this.total,
      status: status ?? this.status,
      deliveryAddress: deliveryAddress ?? this.deliveryAddress,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      createdAt: createdAt ?? this.createdAt,
      estimatedDelivery: estimatedDelivery ?? this.estimatedDelivery,
    );
  }
}
