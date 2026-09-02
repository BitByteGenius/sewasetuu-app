import 'package:flutter/material.dart';
import 'package:sewasetu/app/theme/app_colors.dart';
import 'package:sewasetu/app/theme/app_radius.dart';
import 'package:sewasetu/app/theme/app_spacing.dart';
import 'package:sewasetu/app/theme/app_text_styles.dart';
import '../models/onboarding_slide_model.dart';

class OnboardingSlideWidget extends StatelessWidget {
  final OnboardingSlideModel slide;

  const OnboardingSlideWidget({
    super.key,
    required this.slide,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Center(
      child: SingleChildScrollView(
        padding: AppSpacing.horizontalXxl,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Visual Illustration Card
            Container(
              height: 240,
              width: double.infinity,
              decoration: BoxDecoration(
                color: isDark ? AppColors.surfaceVariantDark : AppColors.surfaceVariantLight,
                borderRadius: AppRadius.radiusXxl,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(isDark ? 80 : 30),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  ClipRRect(
                    borderRadius: AppRadius.radiusXxl,
                    child: Image.network(
                      slide.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: isDark ? AppColors.surfaceVariantDark : AppColors.primaryContainer,
                        child: Center(
                          child: Icon(
                            Icons.apartment_rounded,
                            size: 64,
                            color: isDark ? AppColors.primaryLight : AppColors.primary,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: AppRadius.radiusXxl,
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withAlpha(180),
                        ],
                      ),
                    ),
                    padding: const EdgeInsets.all(16),
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: isDark ? AppColors.primaryLight : AppColors.primary,
                        borderRadius: AppRadius.radiusPill,
                      ),
                      child: Text(
                        slide.badgeText,
                        style: AppTextStyles.labelSmall(isDark).copyWith(
                          color: isDark ? Colors.black : Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            AppSpacing.gapV24,
            // Title
            Text(
              slide.title,
              style: AppTextStyles.displaySmall(isDark).copyWith(
                fontWeight: FontWeight.w800,
              ),
              textAlign: TextAlign.center,
            ),
            AppSpacing.gapV12,
            // Subtitle
            Text(
              slide.subtitle,
              style: AppTextStyles.bodyMedium(isDark).copyWith(
                color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
