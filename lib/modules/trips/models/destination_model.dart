/// Model representing a travel destination (city, valley, hill station, region)
class DestinationModel {
  final String id;
  final String name;
  final String slug;
  final String state;
  final String country;
  final String shortDescription;
  final String description;
  final String heroImage;
  final List<String> images;
  final double rating;
  final int reviewCount;
  final List<String> popularMonths;
  final String bestTimeToVisit;
  final List<String> tags;
  final bool isFeatured;
  final bool isPopular;
  final int totalPackages;
  final double startingPrice;

  const DestinationModel({
    required this.id,
    required this.name,
    required this.slug,
    required this.state,
    this.country = 'India',
    required this.shortDescription,
    required this.description,
    required this.heroImage,
    required this.images,
    this.rating = 4.8,
    this.reviewCount = 0,
    this.popularMonths = const [],
    required this.bestTimeToVisit,
    this.tags = const [],
    this.isFeatured = false,
    this.isPopular = false,
    this.totalPackages = 0,
    this.startingPrice = 0.0,
  });

  String get locationSubtitle => '$state, $country';

  factory DestinationModel.fromJson(Map<String, dynamic> json) {
    return DestinationModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      slug: json['slug'] as String? ?? '',
      state: json['state'] as String? ?? '',
      country: json['country'] as String? ?? 'India',
      shortDescription: json['short_description'] as String? ?? '',
      description: json['description'] as String? ?? '',
      heroImage: json['hero_image'] as String? ?? '',
      images: (json['images'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          const [],
      rating: (json['rating'] as num?)?.toDouble() ?? 4.8,
      reviewCount: json['review_count'] as int? ?? 0,
      popularMonths: (json['popular_months'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          const [],
      bestTimeToVisit: json['best_time_to_visit'] as String? ?? '',
      tags: (json['tags'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          const [],
      isFeatured: json['is_featured'] as bool? ?? false,
      isPopular: json['is_popular'] as bool? ?? false,
      totalPackages: json['total_packages'] as int? ?? 0,
      startingPrice: (json['starting_price'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'slug': slug,
        'state': state,
        'country': country,
        'short_description': shortDescription,
        'description': description,
        'hero_image': heroImage,
        'images': images,
        'rating': rating,
        'review_count': reviewCount,
        'popular_months': popularMonths,
        'best_time_to_visit': bestTimeToVisit,
        'tags': tags,
        'is_featured': isFeatured,
        'is_popular': isPopular,
        'total_packages': totalPackages,
        'starting_price': startingPrice,
      };

  DestinationModel copyWith({
    String? id,
    String? name,
    String? slug,
    String? state,
    String? country,
    String? shortDescription,
    String? description,
    String? heroImage,
    List<String>? images,
    double? rating,
    int? reviewCount,
    List<String>? popularMonths,
    String? bestTimeToVisit,
    List<String>? tags,
    bool? isFeatured,
    bool? isPopular,
    int? totalPackages,
    double? startingPrice,
  }) {
    return DestinationModel(
      id: id ?? this.id,
      name: name ?? this.name,
      slug: slug ?? this.slug,
      state: state ?? this.state,
      country: country ?? this.country,
      shortDescription: shortDescription ?? this.shortDescription,
      description: description ?? this.description,
      heroImage: heroImage ?? this.heroImage,
      images: images ?? this.images,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      popularMonths: popularMonths ?? this.popularMonths,
      bestTimeToVisit: bestTimeToVisit ?? this.bestTimeToVisit,
      tags: tags ?? this.tags,
      isFeatured: isFeatured ?? this.isFeatured,
      isPopular: isPopular ?? this.isPopular,
      totalPackages: totalPackages ?? this.totalPackages,
      startingPrice: startingPrice ?? this.startingPrice,
    );
  }
}
