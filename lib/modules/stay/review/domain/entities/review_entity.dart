/// Domain entity representing a user review for a stay
class StayReviewEntity {
  final String id;
  final String userName;
  final String userAvatar;
  final double rating;
  final String dateText;
  final String comment;

  const StayReviewEntity({
    required this.id,
    required this.userName,
    required this.userAvatar,
    required this.rating,
    required this.dateText,
    required this.comment,
  });
}
