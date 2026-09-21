/// Circular subcategory item with image and label (e.g. Bathroom Cleaning, Tap Repair)
class ServiceSubcategoryItem {
  final String id;
  final String name;
  final String imageUrl;
  final String? rating;

  const ServiceSubcategoryItem({
    required this.id,
    required this.name,
    required this.imageUrl,
    this.rating,
  });

  factory ServiceSubcategoryItem.fromJson(Map<String, dynamic> json) {
    return ServiceSubcategoryItem(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      imageUrl: json['image_url'] as String? ?? '',
      rating: json['rating'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'image_url': imageUrl,
        'rating': rating,
      };
}
