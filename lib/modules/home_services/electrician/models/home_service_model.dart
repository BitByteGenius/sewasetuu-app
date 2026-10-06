import 'package:flutter/material.dart';
import '../../home_cleaning/models/kitchen_cleaning_model.dart';

/// Production-ready data model for Service Categories (e.g. Geyser, Fan, Toilet, Door, etc.)
class HomeServiceCategory {
  final String id;
  final String name;
  final String? imageUrl;
  final IconData? icon;
  final bool isPopular;
  final int sortOrder;

  const HomeServiceCategory({
    required this.id,
    required this.name,
    this.imageUrl,
    this.icon,
    this.isPopular = false,
    this.sortOrder = 0,
  });

  factory HomeServiceCategory.fromJson(Map<String, dynamic> json) {
    return HomeServiceCategory(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      imageUrl: json['image_url'] as String?,
      isPopular: json['is_popular'] as bool? ?? false,
      sortOrder: json['sort_order'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'image_url': imageUrl,
        'is_popular': isPopular,
        'sort_order': sortOrder,
      };
}

/// Production-ready data model for Home Services (Electrician, Plumbing, Carpentry)
class HomeServiceItem {
  final String id;
  final String categoryId;
  final String sectionId;
  final String title;
  final String? description;
  final String? imageUrl;
  final double rating;
  final String ratingCount;
  final double price;
  final double? originalPrice;
  final String duration;
  final String? startsAtText;
  final String? badgeText;
  final Color? badgeColor;
  final bool isEcoSafe;
  final List<String> bulletPoints;
  final List<String> tags;
  final bool isPopular;
  final bool isTrending;
  final bool isAvailable;
  final int sortOrder;
  final List<ServiceOptionItem> options;

  const HomeServiceItem({
    required this.id,
    required this.categoryId,
    this.sectionId = 'general',
    required this.title,
    this.description,
    this.imageUrl,
    this.rating = 4.8,
    this.ratingCount = '1K+',
    required this.price,
    this.originalPrice,
    required this.duration,
    this.startsAtText,
    this.badgeText,
    this.badgeColor,
    this.isEcoSafe = false,
    this.bulletPoints = const [],
    this.tags = const [],
    this.isPopular = false,
    this.isTrending = false,
    this.isAvailable = true,
    this.sortOrder = 0,
    this.options = const [],
  });

  bool get hasOptions => options.isNotEmpty;
  int get optionsCount => options.length;

  /// Converts to [KitchenCleaningServiceItem] for seamless integration with existing Cart system.
  KitchenCleaningServiceItem toKitchenCleaningItem() {
    return KitchenCleaningServiceItem(
      id: id,
      sectionId: sectionId,
      title: title,
      badgeText: badgeText,
      badgeColor: badgeColor,
      isEcoSafe: isEcoSafe,
      rating: rating,
      ratingCount: ratingCount,
      duration: duration,
      price: price,
      originalPrice: originalPrice,
      startsAtText: startsAtText,
      imageUrl: imageUrl,
      bulletPoints: bulletPoints,
      description: description,
      options: options,
    );
  }

  factory HomeServiceItem.fromJson(Map<String, dynamic> json) {
    return HomeServiceItem(
      id: json['id'] as String? ?? '',
      categoryId: json['category_id'] as String? ?? '',
      sectionId: json['section_id'] as String? ?? 'general',
      title: json['title'] as String? ?? '',
      description: json['description'] as String?,
      imageUrl: json['image_url'] as String?,
      rating: (json['rating'] as num?)?.toDouble() ?? 4.8,
      ratingCount: json['rating_count'] as String? ?? '1K+',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      originalPrice: (json['original_price'] as num?)?.toDouble(),
      duration: json['duration'] as String? ?? '30 mins',
      startsAtText: json['starts_at_text'] as String?,
      badgeText: json['badge_text'] as String?,
      isEcoSafe: json['is_eco_safe'] as bool? ?? false,
      bulletPoints: (json['bullet_points'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          const [],
      tags: (json['tags'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          const [],
      isPopular: json['is_popular'] as bool? ?? false,
      isTrending: json['is_trending'] as bool? ?? false,
      isAvailable: json['is_available'] as bool? ?? true,
      sortOrder: json['sort_order'] as int? ?? 0,
      options: (json['options'] as List<dynamic>?)
              ?.map((e) => ServiceOptionItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'category_id': categoryId,
        'section_id': sectionId,
        'title': title,
        'description': description,
        'image_url': imageUrl,
        'rating': rating,
        'rating_count': ratingCount,
        'price': price,
        'original_price': originalPrice,
        'duration': duration,
        'starts_at_text': startsAtText,
        'badge_text': badgeText,
        'is_eco_safe': isEcoSafe,
        'bullet_points': bulletPoints,
        'tags': tags,
        'is_popular': isPopular,
        'is_trending': isTrending,
        'is_available': isAvailable,
        'sort_order': sortOrder,
        'options': options.map((o) => o.toJson()).toList(),
      };
}

/// Promotional Banner Model for Home Services
class HomeServiceOfferBanner {
  final String id;
  final String tagText;
  final String headline;
  final String promoCode;
  final String? imageUrl;

  const HomeServiceOfferBanner({
    required this.id,
    required this.tagText,
    required this.headline,
    required this.promoCode,
    this.imageUrl,
  });
}
