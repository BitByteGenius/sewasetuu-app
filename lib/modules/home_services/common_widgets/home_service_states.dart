import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sewasetu/app/theme/app_colors.dart';
import 'package:sewasetu/shared/widgets/app_button.dart';
import 'package:sewasetu/shared/widgets/app_skeleton.dart';

/// Reusable Loading Skeleton for Home Services
class HomeServiceLoadingState extends StatelessWidget {
  const HomeServiceLoadingState({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: const [
          AppSkeleton(height: 120, width: double.infinity),
          SizedBox(height: 16),
          AppSkeleton(height: 180, width: double.infinity),
          SizedBox(height: 16),
          AppSkeleton(height: 140, width: double.infinity),
          SizedBox(height: 16),
          AppSkeleton(height: 140, width: double.infinity),
        ],
      ),
    );
  }
}

/// Reusable Professional Empty State for Home Services
class HomeServiceEmptyState extends StatelessWidget {
  final String title;
  final String message;
  final String? buttonText;
  final VoidCallback? onAction;

  const HomeServiceEmptyState({
    super.key,
    this.title = 'No services found',
    this.message = 'Try selecting a different category or clear filters.',
    this.buttonText = 'Show All Services',
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF132338) : const Color(0xFFE6F4F1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.search_off_rounded,
                size: 54,
                color: isDark ? const Color(0xFF14B8A6) : const Color(0xFF0F766E),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: isDark ? AppColors.textPrimaryDark : const Color(0xFF1E293B),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 13.5,
                color: isDark ? AppColors.textMutedDark : const Color(0xFF64748B),
              ),
            ),
            if (onAction != null && buttonText != null) ...[
              const SizedBox(height: 20),
              AppButton(
                text: buttonText!,
                onPressed: onAction,
                size: AppButtonSize.medium,
                borderRadius: BorderRadius.circular(12),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Reusable Error State for Home Services
class HomeServiceErrorState extends StatelessWidget {
  final String title;
  final String message;
  final VoidCallback onRetry;

  const HomeServiceErrorState({
    super.key,
    this.title = 'Failed to load services',
    this.message = 'Something went wrong while loading service details.',
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Color(0xFFFFE4E6),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.error_outline_rounded,
                size: 54,
                color: Color(0xFFE11D48),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: isDark ? AppColors.textPrimaryDark : const Color(0xFF1E293B),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 13.5,
                color: isDark ? AppColors.textMutedDark : const Color(0xFF64748B),
              ),
            ),
            const SizedBox(height: 20),
            AppButton(
              text: 'Retry Loading',
              prefixIcon: const Icon(Icons.refresh_rounded, size: 18, color: Colors.white),
              onPressed: onRetry,
              size: AppButtonSize.medium,
              borderRadius: BorderRadius.circular(12),
            ),
          ],
        ),
      ),
    );
  }
}
