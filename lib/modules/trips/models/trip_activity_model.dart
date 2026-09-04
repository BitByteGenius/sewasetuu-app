/// Model representing an outdoor activity, experience, or adventure item included in or add-on to trips
class TripActivityModel {
  final String id;
  final String title;
  final String description;
  final String category;
  final double durationHours;
  final String imageUrl;
  final double? price;

  const TripActivityModel({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    this.durationHours = 2.0,
    required this.imageUrl,
    this.price,
  });

  factory TripActivityModel.fromJson(Map<String, dynamic> json) {
    return TripActivityModel(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      category: json['category'] as String? ?? 'Sightseeing',
      durationHours: (json['duration_hours'] as num?)?.toDouble() ?? 2.0,
      imageUrl: json['image_url'] as String? ?? '',
      price: (json['price'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'category': category,
        'duration_hours': durationHours,
        'image_url': imageUrl,
        'price': price,
      };

  TripActivityModel copyWith({
    String? id,
    String? title,
    String? description,
    String? category,
    double? durationHours,
    String? imageUrl,
    double? price,
  }) {
    return TripActivityModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      durationHours: durationHours ?? this.durationHours,
      imageUrl: imageUrl ?? this.imageUrl,
      price: price ?? this.price,
    );
  }
}
