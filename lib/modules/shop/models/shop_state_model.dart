/// Model representing an Indian State or Union Territory in the Shop module
class ShopStateModel {
  final String id;
  final String name;
  final String slug;
  final String region; // 'North East', 'East', 'North', 'West', 'South', 'Central'
  final String description;
  final String shortDescription;
  final String image;
  final bool isFeatured;
  final int productCount;
  final List<String> culturalHighlights;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const ShopStateModel({
    required this.id,
    required this.name,
    required this.slug,
    required this.region,
    required this.description,
    required this.shortDescription,
    required this.image,
    this.isFeatured = false,
    this.productCount = 0,
    this.culturalHighlights = const [],
    this.createdAt,
    this.updatedAt,
  });

  factory ShopStateModel.fromJson(Map<String, dynamic> json) {
    return ShopStateModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      slug: json['slug'] as String? ?? '',
      region: json['region'] as String? ?? 'General',
      description: json['description'] as String? ?? '',
      shortDescription: json['short_description'] as String? ?? '',
      image: json['image'] as String? ?? '',
      isFeatured: json['is_featured'] as bool? ?? false,
      productCount: json['product_count'] as int? ?? 0,
      culturalHighlights: (json['cultural_highlights'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          const [],
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
        'region': region,
        'description': description,
        'short_description': shortDescription,
        'image': image,
        'is_featured': isFeatured,
        'product_count': productCount,
        'cultural_highlights': culturalHighlights,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
      };

  ShopStateModel copyWith({
    String? id,
    String? name,
    String? slug,
    String? region,
    String? description,
    String? shortDescription,
    String? image,
    bool? isFeatured,
    int? productCount,
    List<String>? culturalHighlights,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ShopStateModel(
      id: id ?? this.id,
      name: name ?? this.name,
      slug: slug ?? this.slug,
      region: region ?? this.region,
      description: description ?? this.description,
      shortDescription: shortDescription ?? this.shortDescription,
      image: image ?? this.image,
      isFeatured: isFeatured ?? this.isFeatured,
      productCount: productCount ?? this.productCount,
      culturalHighlights: culturalHighlights ?? this.culturalHighlights,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
