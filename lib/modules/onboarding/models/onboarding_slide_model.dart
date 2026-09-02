class OnboardingSlideModel {
  final String title;
  final String subtitle;
  final String imageUrl;
  final String badgeText;

  const OnboardingSlideModel({
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    required this.badgeText,
  });
}

typedef OnboardingSlide = OnboardingSlideModel;
