class OnboardingSlideModel {
  final String title;
  final String subtitle;
  final String imageUrl;
  final String badgeText;
  final String cardTitle;
  final String cardSubtitle;
  final String cardPrice;
  final String cardRating;

  const OnboardingSlideModel({
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    required this.badgeText,
    this.cardTitle = '',
    this.cardSubtitle = '',
    this.cardPrice = '',
    this.cardRating = '4.95',
  });
}

typedef OnboardingSlide = OnboardingSlideModel;

