/// Primary quick-access service category item for the 4x2 top header grid
class ServiceCategoryItem {
  final String id;
  final String title;
  final String imageUrl;
  final String? badgeText;
  final String? durationText;
  final bool isInstant;

  const ServiceCategoryItem({
    required this.id,
    required this.title,
    required this.imageUrl,
    this.badgeText,
    this.durationText,
    this.isInstant = false,
  });

  factory ServiceCategoryItem.fromJson(Map<String, dynamic> json) {
    return ServiceCategoryItem(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      imageUrl: json['image_url'] as String? ?? '',
      badgeText: json['badge_text'] as String?,
      durationText: json['duration_text'] as String?,
      isInstant: json['is_instant'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'image_url': imageUrl,
        'badge_text': badgeText,
        'duration_text': durationText,
        'is_instant': isInstant,
      };
}
