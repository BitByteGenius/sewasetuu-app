/// Model representing a guest review for an accommodation
class ReviewModel {
  final String id;
  final String userName;
  final String userAvatar;
  final double rating;
  final String dateText;
  final String comment;

  const ReviewModel({
    required this.id,
    required this.userName,
    required this.userAvatar,
    required this.rating,
    required this.dateText,
    required this.comment,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      id: json['id'] as String? ?? '',
      userName: json['user_name'] as String? ?? '',
      userAvatar: json['user_avatar'] as String? ?? '',
      rating: (json['rating'] as num?)?.toDouble() ?? 5.0,
      dateText: json['date_text'] as String? ?? '',
      comment: json['comment'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'user_name': userName,
        'user_avatar': userAvatar,
        'rating': rating,
        'date_text': dateText,
        'comment': comment,
      };

  ReviewModel copyWith({
    String? id,
    String? userName,
    String? userAvatar,
    double? rating,
    String? dateText,
    String? comment,
  }) {
    return ReviewModel(
      id: id ?? this.id,
      userName: userName ?? this.userName,
      userAvatar: userAvatar ?? this.userAvatar,
      rating: rating ?? this.rating,
      dateText: dateText ?? this.dateText,
      comment: comment ?? this.comment,
    );
  }
}

typedef StayReviewEntity = ReviewModel;
