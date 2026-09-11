import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sewasetu/app/theme/app_colors.dart';
import 'package:sewasetu/modules/onboarding/controllers/onboarding_controller.dart';
import 'package:sewasetu/modules/onboarding/widgets/onboarding_slide_widget.dart';

/// Premium 3-screen onboarding screen featuring centered mockups,
/// misty cloudy bottom fade, and a symmetrical 40/60 balanced bottom action bar.
class OnboardingScreen extends GetView<OnboardingController> {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDark ? const Color(0xFF0F172A) : const Color(0xFFF8FAFC);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 38,
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 14),
            child: TextButton(
              onPressed: controller.completeOnboarding,
              style: TextButton.styleFrom(
                minimumSize: Size.zero,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text(
                'Skip',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            // 1. Carousel PageView
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

            // 2. Symmetrical 40/60 Bottom Action Area (Equal 56px height)
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 6, 20, 16),
              child: Row(
                children: [
                  // Left 40%: Clean Floating Page Indicators (No background container)
                  Expanded(
                    flex: 40,
                    child: SizedBox(
                      height: 56,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Obx(() {
                          return Row(
                            mainAxisSize: MainAxisSize.min,
                            children: List.generate(
                              controller.slides.length,
                              (index) {
                                final isSelected =
                                    controller.currentPage.value == index;
                                return AnimatedContainer(
                                  duration: const Duration(milliseconds: 320),
                                  curve: Curves.easeOutCubic,
                                  margin: const EdgeInsets.only(right: 6),
                                  width: isSelected ? 26 : 8,
                                  height: 8,
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? (isDark
                                            ? AppColors.primaryLight
                                            : AppColors.primary)
                                        : (isDark
                                            ? Colors.white24
                                            : Colors.black12),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                );
                              },
                            ),
                          );
                        }),
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  // Right 60%: Primary Action Button (Height: 56)
                  Expanded(
                    flex: 60,
                    child: Obx(() {
                      final isLastPage =
                          controller.currentPage.value == controller.slides.length - 1;
                      return Container(
                        height: 56,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF0F766E), Color(0xFF14B8A6)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF0F766E).withValues(alpha: 0.38),
                              blurRadius: 14,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: controller.nextPage,
                            borderRadius: BorderRadius.circular(16),
                            child: Center(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    isLastPage ? 'Get Started' : 'Next',
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: 15.5,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                      letterSpacing: 0.3,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Icon(
                                    isLastPage
                                        ? Icons.arrow_forward_rounded
                                        : Icons.arrow_forward_rounded,
                                    color: Colors.white,
                                    size: 19,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
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

