/// Feature badge for spotlight card (e.g. 12L+ Happy Customers, 4.9 Rated Partners, Re-Clean Guarantee)
class SpotlightBadge {
  final String iconType; // smile, star, guarantee
  final String label;

  const SpotlightBadge({
    required this.iconType,
    required this.label,
  });

  factory SpotlightBadge.fromJson(Map<String, dynamic> json) {
    return SpotlightBadge(
      iconType: json['icon_type'] as String? ?? 'guarantee',
      label: json['label'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'icon_type': iconType,
        'label': label,
      };
}

/// Model representing the "In the Spotlight" featured service card
class ServiceSpotlightItem {
  final String id;
  final String title;
  final String subtitle;
  final String discountBadgeText;
  final String promoCode;
  final String imageUrl;
  final List<SpotlightBadge> badges;
  final String ctaText;

  const ServiceSpotlightItem({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.discountBadgeText,
    required this.promoCode,
    required this.imageUrl,
    required this.badges,
    required this.ctaText,
  });

  factory ServiceSpotlightItem.fromJson(Map<String, dynamic> json) {
    return ServiceSpotlightItem(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      subtitle: json['subtitle'] as String? ?? '',
      discountBadgeText: json['discount_badge_text'] as String? ?? '',
      promoCode: json['promo_code'] as String? ?? '',
      imageUrl: json['image_url'] as String? ?? '',
      badges: (json['badges'] as List<dynamic>?)
              ?.map((e) => SpotlightBadge.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      ctaText: json['cta_text'] as String? ?? 'Book Now',
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'subtitle': subtitle,
        'discount_badge_text': discountBadgeText,
        'promo_code': promoCode,
        'image_url': imageUrl,
        'badges': badges.map((b) => b.toJson()).toList(),
        'cta_text': ctaText,
      };
}
