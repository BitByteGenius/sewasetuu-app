/// Customer review model for rented vehicles.
class RentalReviewModel {
  final String id;
  final String userName;
  final String? userAvatar;
  final double rating;
  final DateTime date;
  final String comment;
  final bool verifiedRental;
  final String? vehicleModelName;

  const RentalReviewModel({
    required this.id,
    required this.userName,
    this.userAvatar,
    required this.rating,
    required this.date,
    required this.comment,
    this.verifiedRental = true,
    this.vehicleModelName,
  });

  RentalReviewModel copyWith({
    String? id,
    String? userName,
    String? userAvatar,
    double? rating,
    DateTime? date,
    String? comment,
    bool? verifiedRental,
    String? vehicleModelName,
  }) {
    return RentalReviewModel(
      id: id ?? this.id,
      userName: userName ?? this.userName,
      userAvatar: userAvatar ?? this.userAvatar,
      rating: rating ?? this.rating,
      date: date ?? this.date,
      comment: comment ?? this.comment,
      verifiedRental: verifiedRental ?? this.verifiedRental,
      vehicleModelName: vehicleModelName ?? this.vehicleModelName,
    );
  }

  factory RentalReviewModel.fromJson(Map<String, dynamic> json) {
    return RentalReviewModel(
      id: json['id'] as String? ?? '',
      userName: json['userName'] as String? ?? 'Verified Driver',
      userAvatar: json['userAvatar'] as String?,
      rating: (json['rating'] as num?)?.toDouble() ?? 5.0,
      date: json['date'] != null
          ? DateTime.tryParse(json['date'] as String) ?? DateTime.now()
          : DateTime.now(),
      comment: json['comment'] as String? ?? '',
      verifiedRental: json['verifiedRental'] as bool? ?? true,
      vehicleModelName: json['vehicleModelName'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userName': userName,
      'userAvatar': userAvatar,
      'rating': rating,
      'date': date.toIso8601String(),
      'comment': comment,
      'verifiedRental': verifiedRental,
      'vehicleModelName': vehicleModelName,
    };
  }
}
