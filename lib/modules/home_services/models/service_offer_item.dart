/// Model representing a promotional carousel offer card
class ServiceOfferItem {
  final String id;
  final String categoryTag;
  final String discountHeadline;
  final String discountHighlight;
  final String couponCode;
  final String imageUrl;
  final String? infoTooltip;
  final String? backgroundColorHex;

  const ServiceOfferItem({
    required this.id,
    required this.categoryTag,
    required this.discountHeadline,
    required this.discountHighlight,
    required this.couponCode,
    required this.imageUrl,
    this.infoTooltip,
    this.backgroundColorHex,
  });

  factory ServiceOfferItem.fromJson(Map<String, dynamic> json) {
    return ServiceOfferItem(
      id: json['id'] as String? ?? '',
      categoryTag: json['category_tag'] as String? ?? '',
      discountHeadline: json['discount_headline'] as String? ?? '',
      discountHighlight: json['discount_highlight'] as String? ?? '',
      couponCode: json['coupon_code'] as String? ?? '',
      imageUrl: json['image_url'] as String? ?? '',
      infoTooltip: json['info_tooltip'] as String?,
      backgroundColorHex: json['background_color_hex'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'category_tag': categoryTag,
        'discount_headline': discountHeadline,
        'discount_highlight': discountHighlight,
        'coupon_code': couponCode,
        'image_url': imageUrl,
        'info_tooltip': infoTooltip,
        'background_color_hex': backgroundColorHex,
      };
}
