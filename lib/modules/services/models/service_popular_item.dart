/// Model for "Popular Services" 2x2 grid image cards with rating overlay
class ServicePopularItem {
  final String id;
  final String title;
  final String imageUrl;
  final double rating;
  final String? startingPrice;

  const ServicePopularItem({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.rating,
    this.startingPrice,
  });

  factory ServicePopularItem.fromJson(Map<String, dynamic> json) {
    return ServicePopularItem(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      imageUrl: json['image_url'] as String? ?? '',
      rating: (json['rating'] as num?)?.toDouble() ?? 4.8,
      startingPrice: json['starting_price'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'image_url': imageUrl,
        'rating': rating,
        'starting_price': startingPrice,
      };
}
