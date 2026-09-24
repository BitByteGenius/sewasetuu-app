/// Model representing customer review card in services
class ServiceReviewItem {
  final String id;
  final String userName;
  final String userAvatar;
  final String serviceName;
  final double rating;
  final String comment;

  const ServiceReviewItem({
    required this.id,
    required this.userName,
    required this.userAvatar,
    required this.serviceName,
    required this.rating,
    required this.comment,
  });

  factory ServiceReviewItem.fromJson(Map<String, dynamic> json) {
    return ServiceReviewItem(
      id: json['id'] as String? ?? '',
      userName: json['user_name'] as String? ?? '',
      userAvatar: json['user_avatar'] as String? ?? '',
      serviceName: json['service_name'] as String? ?? '',
      rating: (json['rating'] as num?)?.toDouble() ?? 5.0,
      comment: json['comment'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'user_name': userName,
        'user_avatar': userAvatar,
        'service_name': serviceName,
        'rating': rating,
        'comment': comment,
      };
}
