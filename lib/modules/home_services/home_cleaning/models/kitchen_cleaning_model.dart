import 'package:flutter/material.dart';

/// Variant option for a service (e.g., "Up to 2 BHK", "3 BHK", "Single Door Fridge")
class ServiceOptionItem {
  final String id;
  final String name;
  final double price;
  final String? description;

  const ServiceOptionItem({
    required this.id,
    required this.name,
    required this.price,
    this.description,
  });

  factory ServiceOptionItem.fromJson(Map<String, dynamic> json) {
    return ServiceOptionItem(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      description: json['description'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'price': price,
        'description': description,
      };
}

/// Model representing a Kitchen Cleaning Service item
class KitchenCleaningServiceItem {
  final String id;
  final String sectionId; // 'occupied', 'empty', 'mini', 'appliances'
  final String title;
  final String? badgeText; // 'Essential', 'Power Steam', 'Eco-Smart'
  final Color? badgeColor;
  final bool isEcoSafe;
  final double rating;
  final String ratingCount;
  final String duration;
  final double price;
  final String? startsAtText;
  final String? imageUrl;
  final List<String> bulletPoints;
  final String? description;
  final List<ServiceOptionItem> options;

  const KitchenCleaningServiceItem({
    required this.id,
    required this.sectionId,
    required this.title,
    this.badgeText,
    this.badgeColor,
    this.isEcoSafe = false,
    required this.rating,
    required this.ratingCount,
    required this.duration,
    required this.price,
    this.startsAtText,
    this.imageUrl,
    this.bulletPoints = const [],
    this.description,
    this.options = const [],
  });

  bool get hasOptions => options.isNotEmpty;

  factory KitchenCleaningServiceItem.fromJson(Map<String, dynamic> json) {
    return KitchenCleaningServiceItem(
      id: json['id'] as String? ?? '',
      sectionId: json['section_id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      badgeText: json['badge_text'] as String?,
      isEcoSafe: json['is_eco_safe'] as bool? ?? false,
      rating: (json['rating'] as num?)?.toDouble() ?? 4.5,
      ratingCount: json['rating_count'] as String? ?? '1K+',
      duration: json['duration'] as String? ?? '30 mins',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      startsAtText: json['starts_at_text'] as String?,
      imageUrl: json['image_url'] as String?,
      bulletPoints: (json['bullet_points'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          const [],
      description: json['description'] as String?,
      options: (json['options'] as List<dynamic>?)
              ?.map((e) => ServiceOptionItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'section_id': sectionId,
        'title': title,
        'badge_text': badgeText,
        'is_eco_safe': isEcoSafe,
        'rating': rating,
        'rating_count': ratingCount,
        'duration': duration,
        'price': price,
        'starts_at_text': startsAtText,
        'image_url': imageUrl,
        'bullet_points': bulletPoints,
        'description': description,
        'options': options.map((o) => o.toJson()).toList(),
      };
}

/// Model for Section Nav Header Item ('Occupied Kitchen Cleaning', 'Empty Kitchen Cleaning', 'Mini Services')
class KitchenCleaningNavCategory {
  final String id;
  final String title;
  final String imageUrl;
  final IconData? fallbackIcon;

  const KitchenCleaningNavCategory({
    required this.id,
    required this.title,
    required this.imageUrl,
    this.fallbackIcon,
  });
}

/// Model for Promotional Offer Banners
class KitchenCleaningOfferBanner {
  final String id;
  final String tagText;
  final String headline;
  final String promoCode;
  final String? imageUrl;

  const KitchenCleaningOfferBanner({
    required this.id,
    required this.tagText,
    required this.headline,
    required this.promoCode,
    this.imageUrl,
  });
}

/// Rating distribution breakdown model
class RatingBreakdownModel {
  final double avgRating;
  final int totalCount;
  final Map<int, int> starCounts; // {5: 176097, 4: 5224, 3: 2729, 2: 2046, 1: 6112}

  const RatingBreakdownModel({
    required this.avgRating,
    required this.totalCount,
    required this.starCounts,
  });
}

/// FAQ Item Model
class KitchenFaqItem {
  final String id;
  final String question;
  final String answer;

  const KitchenFaqItem({
    required this.id,
    required this.question,
    required this.answer,
  });
}

/// Cart Line Item model
class KitchenCartItem {
  final KitchenCleaningServiceItem service;
  final ServiceOptionItem? selectedOption;
  int quantity;

  KitchenCartItem({
    required this.service,
    this.selectedOption,
    this.quantity = 1,
  });

  double get unitPrice => selectedOption?.price ?? service.price;
  double get totalPrice => unitPrice * quantity;
}
