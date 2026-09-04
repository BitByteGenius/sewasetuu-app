/// Model representing a travel theme or journey category (Adventure, Beach, Mountains, Heritage, etc.)
class TripThemeModel {
  final String id;
  final String name;
  final String slug;
  final String emoji;
  final String imageUrl;
  final String description;
  final int packageCount;

  const TripThemeModel({
    required this.id,
    required this.name,
    required this.slug,
    this.emoji = '🏔️',
    required this.imageUrl,
    this.description = '',
    this.packageCount = 0,
  });

  factory TripThemeModel.fromJson(Map<String, dynamic> json) {
    return TripThemeModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      slug: json['slug'] as String? ?? '',
      emoji: json['emoji'] as String? ?? '🏔️',
      imageUrl: json['image_url'] as String? ?? '',
      description: json['description'] as String? ?? '',
      packageCount: json['package_count'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'slug': slug,
        'emoji': emoji,
        'image_url': imageUrl,
        'description': description,
        'package_count': packageCount,
      };

  TripThemeModel copyWith({
    String? id,
    String? name,
    String? slug,
    String? emoji,
    String? imageUrl,
    String? description,
    int? packageCount,
  }) {
    return TripThemeModel(
      id: id ?? this.id,
      name: name ?? this.name,
      slug: slug ?? this.slug,
      emoji: emoji ?? this.emoji,
      imageUrl: imageUrl ?? this.imageUrl,
      description: description ?? this.description,
      packageCount: packageCount ?? this.packageCount,
    );
  }
}
