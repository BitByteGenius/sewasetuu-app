import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sewasetu/app/theme/app_colors.dart';
import '../models/onboarding_slide_model.dart';

/// Onboarding slide displaying short bold title at top,
/// and a realistic iPhone mockup (70% visible, cropped at bottom with side buttons) and cloudy shadow.
class OnboardingSlideWidget extends StatelessWidget {
  final OnboardingSlideModel slide;

  const OnboardingSlideWidget({
    super.key,
    required this.slide,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDark ? const Color(0xFF0F172A) : const Color(0xFFF8FAFC);

    return Column(
      children: [
        // 1. Top Section: Short, punchy bold title only
        Padding(
          padding: const EdgeInsets.only(top: 0, bottom: 14, left: 24, right: 24),
          child: Text(
            slide.title,
            textAlign: TextAlign.center,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 25,
              fontWeight: FontWeight.w800,
              height: 1.15,
              letterSpacing: -0.5,
              color: isDark ? Colors.white : const Color(0xFF0F172A),
            ),
          ),
        ),

        // 2. Middle Section: Realistic iPhone Mockup with visible side buttons (70% visible, cropped at bottom)
        Expanded(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final availableWidth = constraints.maxWidth;
              final availableHeight = constraints.maxHeight;

              // Full-scale iPhone mockup dimensions
              final mockupWidth = math.min(availableWidth * 0.78, 285.0);
              // Phone height extends beyond availableHeight so the phone end is naturally cropped at the bottom
              final mockupHeight = math.max(availableHeight + 160.0, 520.0);

              return Stack(
                alignment: Alignment.topCenter,
                clipBehavior: Clip.hardEdge,
                children: [
                  // iPhone Frame with visible side buttons extending downwards past bottom edge
                  Positioned(
                    top: 12,
                    child: SizedBox(
                      width: mockupWidth,
                      height: mockupHeight,
                      child: IPhoneMockupWidget(
                        slide: slide,
                        isDark: isDark,
                      ),
                    ),
                  ),

                  // Soft Cloudy Shadow rising from bottom to eliminate hard cuts
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    height: math.min(availableHeight * 0.44, 160.0),
                    child: IgnorePointer(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              backgroundColor.withOpacity(0.0),
                              backgroundColor.withOpacity(0.18),
                              backgroundColor.withOpacity(0.55),
                              backgroundColor.withOpacity(0.90),
                              backgroundColor,
                            ],
                            stops: const [0.0, 0.28, 0.58, 0.85, 1.0],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}

/// Realistic modern iPhone mockup with visible metallic side buttons,
/// Dynamic Island, status bar, and a clean overflow-free preview card.
class IPhoneMockupWidget extends StatelessWidget {
  final OnboardingSlideModel slide;
  final bool isDark;

  const IPhoneMockupWidget({
    super.key,
    required this.slide,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final buttonColor = isDark ? const Color(0xFF64748B) : const Color(0xFF475569);
    final chassisColor = isDark ? const Color(0xFF1E293B) : const Color(0xFF0F172A);
    final frameBorderColor = isDark ? const Color(0xFF334155) : const Color(0xFF1E293B);

    return Stack(
      alignment: Alignment.topCenter,
      clipBehavior: Clip.none,
      children: [
        // --- VISIBLE HARDWARE SIDE BUTTONS (iPhone styling) ---

        // 1. Left Action Button (Mute / Action Pill)
        Positioned(
          left: 0,
          top: 56,
          child: Container(
            width: 3.5,
            height: 16,
            decoration: BoxDecoration(
              color: buttonColor,
              borderRadius: const BorderRadius.horizontal(left: Radius.circular(2)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.35),
                  blurRadius: 2,
                  offset: const Offset(-1, 1),
                ),
              ],
            ),
          ),
        ),

        // 2. Left Volume Up Button
        Positioned(
          left: 0,
          top: 86,
          child: Container(
            width: 3.5,
            height: 32,
            decoration: BoxDecoration(
              color: buttonColor,
              borderRadius: const BorderRadius.horizontal(left: Radius.circular(2)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.35),
                  blurRadius: 2,
                  offset: const Offset(-1, 1),
                ),
              ],
            ),
          ),
        ),

        // 3. Left Volume Down Button
        Positioned(
          left: 0,
          top: 126,
          child: Container(
            width: 3.5,
            height: 32,
            decoration: BoxDecoration(
              color: buttonColor,
              borderRadius: const BorderRadius.horizontal(left: Radius.circular(2)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.35),
                  blurRadius: 2,
                  offset: const Offset(-1, 1),
                ),
              ],
            ),
          ),
        ),

        // 4. Right Side / Power Lock Button
        Positioned(
          right: 0,
          top: 84,
          child: Container(
            width: 3.5,
            height: 48,
            decoration: BoxDecoration(
              color: buttonColor,
              borderRadius: const BorderRadius.horizontal(right: Radius.circular(2)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.35),
                  blurRadius: 2,
                  offset: const Offset(1, 1),
                ),
              ],
            ),
          ),
        ),

        // --- MAIN IPHONE CHASSIS & SCREEN ---
        Positioned.fill(
          left: 3.5,
          right: 3.5,
          child: Container(
            decoration: BoxDecoration(
              color: chassisColor,
              borderRadius: BorderRadius.circular(42),
              border: Border.all(
                color: frameBorderColor,
                width: 3.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(isDark ? 0.45 : 0.24),
                  blurRadius: 30,
                  offset: const Offset(0, 16),
                  spreadRadius: -2,
                ),
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.14),
                  blurRadius: 38,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            padding: const EdgeInsets.all(6.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(35),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  // 1. Unsplash Network Image filling the iPhone display
                  Image.network(
                    slide.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: isDark ? const Color(0xFF1E293B) : const Color(0xFFCCFBF1),
                      child: Center(
                        child: Icon(
                          Icons.landscape_rounded,
                          size: 64,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ),

                  // 2. Top Status Bar Vignette
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    height: 50,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black.withOpacity(0.65),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ),

                  // 3. Bottom Gradient for Legibility
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    height: 190,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.80),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // 4. Status Bar & Dynamic Island (Apple iPhone format)
                  Positioned(
                    top: 10,
                    left: 14,
                    right: 14,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          '9:41',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            letterSpacing: -0.2,
                          ),
                        ),
                        // Dynamic Island Pill
                        Container(
                          width: 72,
                          height: 17,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(9),
                          ),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 6),
                              child: Container(
                                width: 5.5,
                                height: 5.5,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF1E1B4B),
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.signal_cellular_alt_rounded, size: 12, color: Colors.white),
                            SizedBox(width: 3),
                            Icon(Icons.wifi_rounded, size: 12, color: Colors.white),
                            SizedBox(width: 3),
                            Icon(Icons.battery_full_rounded, size: 13, color: Colors.white),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // 5. Clean, 100% Overflow-Free Live Preview Card in the top 70% visible section
                  Positioned(
                    left: 12,
                    right: 12,
                    top: 115,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.72),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.20),
                          width: 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.40),
                            blurRadius: 14,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          // Verified Icon Badge
                          Container(
                            width: 28,
                            height: 28,
                            decoration: BoxDecoration(
                              color: const Color(0xFF0F766E),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(
                              Icons.verified_rounded,
                              size: 16,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 8),

                          // Title and Subtitle with ellipsis
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  slide.cardTitle,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.plusJakartaSans(
                                    color: Colors.white,
                                    fontSize: 11.5,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(height: 1),
                                Text(
                                  '${slide.cardSubtitle} • ${slide.cardPrice}',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.75),
                                    fontSize: 9.5,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 6),

                          // Rating Tag
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.12),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.star_rounded, size: 12, color: Color(0xFFF59E0B)),
                                const SizedBox(width: 2),
                                Text(
                                  slide.cardRating,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // 6. iPhone Home Indicator bar at bottom
                  Positioned(
                    bottom: 8,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Container(
                        width: 90,
                        height: 3.5,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.70),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}


