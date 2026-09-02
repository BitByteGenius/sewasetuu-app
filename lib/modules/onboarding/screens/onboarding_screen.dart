import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sewasetu/app/theme/app_colors.dart';
import 'package:sewasetu/app/theme/app_radius.dart';
import 'package:sewasetu/app/theme/app_spacing.dart';
import 'package:sewasetu/app/theme/app_text_styles.dart';
import 'package:sewasetu/modules/onboarding/controllers/onboarding_controller.dart';
import 'package:sewasetu/modules/onboarding/widgets/onboarding_slide_widget.dart';
import 'package:sewasetu/shared/widgets/app_button.dart';

/// Onboarding carousel page with dot indicator and smooth page transitions.
class OnboardingScreen extends GetView<OnboardingController> {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          TextButton(
            onPressed: controller.completeOnboarding,
            child: Text(
              'Skip',
              style: AppTextStyles.labelMedium(isDark).copyWith(
                color: isDark ? AppColors.textMutedDark : AppColors.textSecondaryLight,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // PageView
            Expanded(
              child: PageView.builder(
                controller: controller.pageController,
                itemCount: controller.slides.length,
                onPageChanged: controller.onPageChanged,
                itemBuilder: (context, index) {
                  return OnboardingSlideWidget(slide: controller.slides[index]);
                },
              ),
            ),
            // Bottom Action Area with Page Indicator
            Padding(
              padding: AppSpacing.edgeInsetsXxl,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Dot Indicators
                  Obx(() {
                    return Row(
                      children: List.generate(
                        controller.slides.length,
                        (index) {
                          final isSelected = controller.currentPage.value == index;
                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            margin: const EdgeInsets.only(right: 6),
                            width: isSelected ? 24 : 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? (isDark ? AppColors.primaryLight : AppColors.primary)
                                  : (isDark ? AppColors.surfaceVariantDark : AppColors.borderLight),
                              borderRadius: AppRadius.radiusPill,
                            ),
                          );
                        },
                      ),
                    );
                  }),
                  // Next / Get Started Button
                  Obx(() {
                    final isLastPage =
                        controller.currentPage.value == controller.slides.length - 1;
                    return AppButton.primary(
                      text: isLastPage ? 'Get Started' : 'Next',
                      suffixIcon: const Icon(Icons.arrow_forward_rounded, size: 18, color: Colors.white),
                      onPressed: controller.nextPage,
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

typedef OnboardingPage = OnboardingScreen;
