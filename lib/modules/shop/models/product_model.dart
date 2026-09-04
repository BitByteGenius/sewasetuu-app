import 'product_variant_model.dart';

/// Core product model for authentic state-wise cultural goods and crafts
class ProductModel {
  final String id;
  final String name;
  final String slug;
  final String description;
  final String shortDescription;
  final String stateId;
  final String stateName;
  final String categoryId;
  final String categoryName;
  final List<String> images;
  final double price;
  final double? originalPrice;
  final int discountPercentage;
  final String currency;
  final double rating;
  final int reviewCount;
  final int stock;
  final bool isAvailable;
  final List<ProductVariantModel> variants;
  final List<String> tags;
  final bool isFeatured;
  final bool isPopular;
  final String? culturalSignificance;
  final String? material;
  final String? origin;
  final String? sellerId;
  final String? sellerName;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const ProductModel({
    required this.id,
    required this.name,
    required this.slug,
    required this.description,
    required this.shortDescription,
    required this.stateId,
    required this.stateName,
    required this.categoryId,
    required this.categoryName,
    required this.images,
    required this.price,
    this.originalPrice,
    this.discountPercentage = 0,
    this.currency = '₹',
    this.rating = 4.8,
    this.reviewCount = 0,
    this.stock = 15,
    this.isAvailable = true,
    this.variants = const [],
    this.tags = const [],
    this.isFeatured = false,
    this.isPopular = false,
    this.culturalSignificance,
    this.material,
    this.origin,
    this.sellerId,
    this.sellerName,
    this.createdAt,
    this.updatedAt,
  });

  bool get hasDiscount => originalPrice != null && originalPrice! > price;

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      slug: json['slug'] as String? ?? '',
      description: json['description'] as String? ?? '',
      shortDescription: json['short_description'] as String? ?? '',
      stateId: json['state_id'] as String? ?? '',
      stateName: json['state_name'] as String? ?? '',
      categoryId: json['category_id'] as String? ?? '',
      categoryName: json['category_name'] as String? ?? '',
      images: (json['images'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          const [],
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      originalPrice: (json['original_price'] as num?)?.toDouble(),
      discountPercentage: json['discount_percentage'] as int? ?? 0,
      currency: json['currency'] as String? ?? '₹',
      rating: (json['rating'] as num?)?.toDouble() ?? 4.8,
      reviewCount: json['review_count'] as int? ?? 0,
      stock: json['stock'] as int? ?? 15,
      isAvailable: json['is_available'] as bool? ?? true,
      variants: (json['variants'] as List<dynamic>?)
              ?.map((e) =>
                  ProductVariantModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      tags: (json['tags'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          const [],
      isFeatured: json['is_featured'] as bool? ?? false,
      isPopular: json['is_popular'] as bool? ?? false,
      culturalSignificance: json['cultural_significance'] as String?,
      material: json['material'] as String?,
      origin: json['origin'] as String?,
      sellerId: json['seller_id'] as String?,
      sellerName: json['seller_name'] as String?,
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'] as String)
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'slug': slug,
        'description': description,
        'short_description': shortDescription,
        'state_id': stateId,
        'state_name': stateName,
        'category_id': categoryId,
        'category_name': categoryName,
        'images': images,
        'price': price,
        'original_price': originalPrice,
        'discount_percentage': discountPercentage,
        'currency': currency,
        'rating': rating,
        'review_count': reviewCount,
        'stock': stock,
        'is_available': isAvailable,
        'variants': variants.map((v) => v.toJson()).toList(),
        'tags': tags,
        'is_featured': isFeatured,
        'is_popular': isPopular,
        'cultural_significance': culturalSignificance,
        'material': material,
        'origin': origin,
        'seller_id': sellerId,
        'seller_name': sellerName,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
      };

  ProductModel copyWith({
    String? id,
    String? name,
    String? slug,
    String? description,
    String? shortDescription,
    String? stateId,
    String? stateName,
    String? categoryId,
    String? categoryName,
    List<String>? images,
    double? price,
    double? originalPrice,
    int? discountPercentage,
    String? currency,
    double? rating,
    int? reviewCount,
    int? stock,
    bool? isAvailable,
    List<ProductVariantModel>? variants,
    List<String>? tags,
    bool? isFeatured,
    bool? isPopular,
    String? culturalSignificance,
    String? material,
    String? origin,
    String? sellerId,
    String? sellerName,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      slug: slug ?? this.slug,
      description: description ?? this.description,
      shortDescription: shortDescription ?? this.shortDescription,
      stateId: stateId ?? this.stateId,
      stateName: stateName ?? this.stateName,
      categoryId: categoryId ?? this.categoryId,
      categoryName: categoryName ?? this.categoryName,
      images: images ?? this.images,
      price: price ?? this.price,
      originalPrice: originalPrice ?? this.originalPrice,
      discountPercentage: discountPercentage ?? this.discountPercentage,
      currency: currency ?? this.currency,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      stock: stock ?? this.stock,
      isAvailable: isAvailable ?? this.isAvailable,
      variants: variants ?? this.variants,
      tags: tags ?? this.tags,
      isFeatured: isFeatured ?? this.isFeatured,
      isPopular: isPopular ?? this.isPopular,
      culturalSignificance: culturalSignificance ?? this.culturalSignificance,
      material: material ?? this.material,
      origin: origin ?? this.origin,
      sellerId: sellerId ?? this.sellerId,
      sellerName: sellerName ?? this.sellerName,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
