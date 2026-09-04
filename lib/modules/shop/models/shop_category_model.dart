/// Category model for categorizing traditional and regional products
class ShopCategoryModel {
  final String id;
  final String name;
  final String slug;
  final String image;
  final String iconEmoji;
  final String description;
  final bool isActive;

  const ShopCategoryModel({
    required this.id,
    required this.name,
    required this.slug,
    required this.image,
    required this.iconEmoji,
    this.description = '',
    this.isActive = true,
  });

  factory ShopCategoryModel.fromJson(Map<String, dynamic> json) {
    return ShopCategoryModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      slug: json['slug'] as String? ?? '',
      image: json['image'] as String? ?? '',
      iconEmoji: json['icon_emoji'] as String? ?? '🛍️',
      description: json['description'] as String? ?? '',
      isActive: json['is_active'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'slug': slug,
        'image': image,
        'icon_emoji': iconEmoji,
        'description': description,
        'is_active': isActive,
      };

  ShopCategoryModel copyWith({
    String? id,
    String? name,
    String? slug,
    String? image,
    String? iconEmoji,
    String? description,
    bool? isActive,
  }) {
    return ShopCategoryModel(
      id: id ?? this.id,
      name: name ?? this.name,
      slug: slug ?? this.slug,
      image: image ?? this.image,
      iconEmoji: iconEmoji ?? this.iconEmoji,
      description: description ?? this.description,
      isActive: isActive ?? this.isActive,
    );
  }
}
