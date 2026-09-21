/// Model for "Relocation Simplified" options (Between Cities, Within the City)
class ServiceRelocationItem {
  final String id;
  final String title;
  final String subtitle;
  final String imageUrl;
  final String badgeText;

  const ServiceRelocationItem({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    this.badgeText = '',
  });

  factory ServiceRelocationItem.fromJson(Map<String, dynamic> json) {
    return ServiceRelocationItem(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      subtitle: json['subtitle'] as String? ?? '',
      imageUrl: json['image_url'] as String? ?? '',
      badgeText: json['badge_text'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'subtitle': subtitle,
        'image_url': imageUrl,
        'badge_text': badgeText,
      };
}
