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

  factory KitchenFaqItem.fromJson(Map<String, dynamic> json) {
    return KitchenFaqItem(
      id: json['id'] as String? ?? '',
      question: json['question'] as String? ?? '',
      answer: json['answer'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'question': question,
        'answer': answer,
      };
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

/// Represents individual feature row value in package comparison matrix (bool or text value)
class KitchenFeatureValue {
  final bool? isSupported; // true = ✓, false = ✕, null = text mode
  final String? textValue; // e.g., "LOW", "ZERO"

  const KitchenFeatureValue.bool(bool value)
      : isSupported = value,
        textValue = null;

  const KitchenFeatureValue.text(String text)
      : isSupported = null,
        textValue = text;

  factory KitchenFeatureValue.fromJson(dynamic json) {
    if (json is bool) {
      return KitchenFeatureValue.bool(json);
    } else if (json is String) {
      return KitchenFeatureValue.text(json);
    }
    return const KitchenFeatureValue.bool(false);
  }

  dynamic toJson() => isSupported ?? textValue;
}

/// Package Column header model (e.g. Essential, Power Steam, Eco-Smart)
class KitchenPackageColumn {
  final String id;
  final String title;
  final String? badgeTag; // e.g. 'Popular'
  final IconData? icon;
  final double price;
  final double? originalPrice;
  final bool isPopular;

  const KitchenPackageColumn({
    required this.id,
    required this.title,
    this.badgeTag,
    this.icon,
    required this.price,
    this.originalPrice,
    this.isPopular = false,
  });

  factory KitchenPackageColumn.fromJson(Map<String, dynamic> json) {
    return KitchenPackageColumn(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      badgeTag: json['badge_tag'] as String?,
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      originalPrice: (json['original_price'] as num?)?.toDouble(),
      isPopular: json['is_popular'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'badge_tag': badgeTag,
        'price': price,
        'original_price': originalPrice,
        'is_popular': isPopular,
      };
}

/// Feature Comparison Row inside matrix table
class KitchenFeatureRow {
  final String id;
  final String featureName;
  final Map<String, KitchenFeatureValue> columnValues;

  const KitchenFeatureRow({
    required this.id,
    required this.featureName,
    required this.columnValues,
  });

  factory KitchenFeatureRow.fromJson(Map<String, dynamic> json) {
    final values = <String, KitchenFeatureValue>{};
    if (json['column_values'] is Map) {
      (json['column_values'] as Map<String, dynamic>).forEach((k, v) {
        values[k] = KitchenFeatureValue.fromJson(v);
      });
    }
    return KitchenFeatureRow(
      id: json['id'] as String? ?? '',
      featureName: json['feature_name'] as String? ?? '',
      columnValues: values,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'feature_name': featureName,
        'column_values': columnValues.map((k, v) => MapEntry(k, v.toJson())),
      };
}

/// Category Accordion Group inside matrix table (e.g. "Kitchen Cleaning")
class KitchenComparisonGroup {
  final String groupTitle;
  final String? iconName;
  final List<KitchenFeatureRow> features;

  const KitchenComparisonGroup({
    required this.groupTitle,
    this.iconName,
    required this.features,
  });

  factory KitchenComparisonGroup.fromJson(Map<String, dynamic> json) {
    return KitchenComparisonGroup(
      groupTitle: json['group_title'] as String? ?? '',
      iconName: json['icon_name'] as String?,
      features: (json['features'] as List<dynamic>?)
              ?.map((e) => KitchenFeatureRow.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() => {
        'group_title': groupTitle,
        'icon_name': iconName,
        'features': features.map((f) => f.toJson()).toList(),
      };
}

/// Comprehensive Detail View Data model for Occupied & Empty Kitchen detail screens
class KitchenServiceDetailData {
  final String serviceId;
  final String title;
  final String? badgeText;
  final String bannerImageUrl;
  final String bookingStatsText;
  final List<KitchenPackageColumn> packages;
  final List<KitchenComparisonGroup> comparisonGroups;
  final List<KitchenFaqItem> faqItems;

  const KitchenServiceDetailData({
    required this.serviceId,
    required this.title,
    this.badgeText,
    required this.bannerImageUrl,
    required this.bookingStatsText,
    required this.packages,
    required this.comparisonGroups,
    required this.faqItems,
  });

  factory KitchenServiceDetailData.fromJson(Map<String, dynamic> json) {
    return KitchenServiceDetailData(
      serviceId: json['service_id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      badgeText: json['badge_text'] as String?,
      bannerImageUrl: json['banner_image_url'] as String? ?? '',
      bookingStatsText: json['booking_stats_text'] as String? ?? '',
      packages: (json['packages'] as List<dynamic>?)
              ?.map((p) => KitchenPackageColumn.fromJson(p as Map<String, dynamic>))
              .toList() ??
          [],
      comparisonGroups: (json['comparison_groups'] as List<dynamic>?)
              ?.map((g) => KitchenComparisonGroup.fromJson(g as Map<String, dynamic>))
              .toList() ??
          [],
      faqItems: (json['faq_items'] as List<dynamic>?)
              ?.map((f) => KitchenFaqItem.fromJson(f as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() => {
        'service_id': serviceId,
        'title': title,
        'badge_text': badgeText,
        'banner_image_url': bannerImageUrl,
        'booking_stats_text': bookingStatsText,
        'packages': packages.map((p) => p.toJson()).toList(),
        'comparison_groups': comparisonGroups.map((g) => g.toJson()).toList(),
        'faq_items': faqItems.map((f) => f.toJson()).toList(),
      };
}

/// Model for Variant Options inside a single service (e.g. Single door, Double door, Side by side)
class KitchenServiceVariant {
  final String id;
  final String name;
  final String duration;
  final double price;
  final double? originalPrice;
  final String? description;

  const KitchenServiceVariant({
    required this.id,
    required this.name,
    required this.duration,
    required this.price,
    this.originalPrice,
    this.description,
  });

  factory KitchenServiceVariant.fromJson(Map<String, dynamic> json) {
    return KitchenServiceVariant(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      duration: json['duration'] as String? ?? '30 mins',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      originalPrice: (json['original_price'] as num?)?.toDouble(),
      description: json['description'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'duration': duration,
        'price': price,
        'original_price': originalPrice,
        'description': description,
      };
}

/// Comprehensive Detail Data model for Appliance & Mini services detail views (Fridge, Chimney, Fan, etc.)
class KitchenSingleServiceDetailData {
  final String serviceId;
  final String title;
  final double rating;
  final String ratingCount;
  final List<KitchenServiceVariant> variants;
  final List<String> includes;
  final List<String> excludes;
  final RatingBreakdownModel? ratingBreakdown;

  const KitchenSingleServiceDetailData({
    required this.serviceId,
    required this.title,
    required this.rating,
    required this.ratingCount,
    required this.variants,
    required this.includes,
    required this.excludes,
    this.ratingBreakdown,
  });

  factory KitchenSingleServiceDetailData.fromJson(Map<String, dynamic> json) {
    return KitchenSingleServiceDetailData(
      serviceId: json['service_id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      rating: (json['rating'] as num?)?.toDouble() ?? 4.75,
      ratingCount: json['rating_count'] as String? ?? '1K+',
      variants: (json['variants'] as List<dynamic>?)
              ?.map((v) => KitchenServiceVariant.fromJson(v as Map<String, dynamic>))
              .toList() ??
          [],
      includes: (json['includes'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      excludes: (json['excludes'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() => {
        'service_id': serviceId,
        'title': title,
        'rating': rating,
        'rating_count': ratingCount,
        'variants': variants.map((v) => v.toJson()).toList(),
        'includes': includes,
        'excludes': excludes,
      };
}

