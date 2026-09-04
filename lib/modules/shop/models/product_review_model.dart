/// Customer feedback and rating review for a shop product
class ProductReviewModel {
  final String id;
  final String userName;
  final String userAvatar;
  final double rating;
  final String dateText;
  final String comment;
  final bool verifiedPurchase;

  const ProductReviewModel({
    required this.id,
    required this.userName,
    required this.userAvatar,
    required this.rating,
    required this.dateText,
    required this.comment,
    this.verifiedPurchase = true,
  });

  factory ProductReviewModel.fromJson(Map<String, dynamic> json) {
    return ProductReviewModel(
      id: json['id'] as String? ?? '',
      userName: json['user_name'] as String? ?? '',
      userAvatar: json['user_avatar'] as String? ?? '',
      rating: (json['rating'] as num?)?.toDouble() ?? 5.0,
      dateText: json['date_text'] as String? ?? '',
      comment: json['comment'] as String? ?? '',
      verifiedPurchase: json['verified_purchase'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'user_name': userName,
        'user_avatar': userAvatar,
        'rating': rating,
        'date_text': dateText,
        'comment': comment,
        'verified_purchase': verifiedPurchase,
      };

  ProductReviewModel copyWith({
    String? id,
    String? userName,
    String? userAvatar,
    double? rating,
    String? dateText,
    String? comment,
    bool? verifiedPurchase,
  }) {
    return ProductReviewModel(
      id: id ?? this.id,
      userName: userName ?? this.userName,
      userAvatar: userAvatar ?? this.userAvatar,
      rating: rating ?? this.rating,
      dateText: dateText ?? this.dateText,
      comment: comment ?? this.comment,
      verifiedPurchase: verifiedPurchase ?? this.verifiedPurchase,
    );
  }
}
