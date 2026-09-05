import 'package:flutter/material.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_radius.dart';
import '../../../app/theme/app_spacing.dart';

/// Shimmer effect container for rental loading skeletons
class RentalSkeletonPulse extends StatefulWidget {
  final Widget child;

  const RentalSkeletonPulse({super.key, required this.child});

  @override
  State<RentalSkeletonPulse> createState() => _RentalSkeletonPulseState();
}

class _RentalSkeletonPulseState extends State<RentalSkeletonPulse>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 0.35, end: 0.85).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: widget.child,
    );
  }
}

/// Skeleton block placeholder
class SkeletonBox extends StatelessWidget {
  final double? width;
  final double height;
  final BorderRadius? borderRadius;

  const SkeletonBox({
    super.key,
    this.width,
    required this.height,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceVariantDark : AppColors.shimmerBase,
        borderRadius: borderRadius ?? AppRadius.radiusMd,
      ),
    );
  }
}

/// Vehicle card loading skeleton
class RentalVehicleCardSkeleton extends StatelessWidget {
  const RentalVehicleCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return RentalSkeletonPulse(
      child: Container(
        margin: const EdgeInsets.only(bottom: AppSpacing.md),
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
          borderRadius: AppRadius.radiusXl,
          border: Border.all(
            color: isDark ? AppColors.borderDark : AppColors.borderLight,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SkeletonBox(
              height: 180,
              width: double.infinity,
              borderRadius: AppRadius.radiusLg,
            ),
            const SizedBox(height: AppSpacing.md),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SkeletonBox(width: 140, height: 20),
                SkeletonBox(width: 60, height: 20),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            const SkeletonBox(width: 200, height: 14),
            const SizedBox(height: AppSpacing.md),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SkeletonBox(width: 100, height: 24),
                SkeletonBox(width: 90, height: 36, borderRadius: AppRadius.radiusFull),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// City card loading skeleton
class RentalCityCardSkeleton extends StatelessWidget {
  const RentalCityCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return RentalSkeletonPulse(
      child: Container(
        height: 110,
        margin: const EdgeInsets.only(bottom: AppSpacing.md),
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
          borderRadius: AppRadius.radiusLg,
          border: Border.all(
            color: isDark ? AppColors.borderDark : AppColors.borderLight,
          ),
        ),
        child: const Row(
          children: [
            SkeletonBox(width: 90, height: 90, borderRadius: AppRadius.radiusMd),
            SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SkeletonBox(width: 120, height: 20),
                  SizedBox(height: AppSpacing.sm),
                  SkeletonBox(width: 80, height: 14),
                  SizedBox(height: AppSpacing.sm),
                  SkeletonBox(width: 150, height: 12),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Vehicle details screen loading skeleton
class RentalDetailsSkeleton extends StatelessWidget {
  const RentalDetailsSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return const RentalSkeletonPulse(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SkeletonBox(height: 260, width: double.infinity, borderRadius: AppRadius.radiusXl),
            SizedBox(height: AppSpacing.lg),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SkeletonBox(width: 180, height: 26),
                SkeletonBox(width: 80, height: 26),
              ],
            ),
            SizedBox(height: AppSpacing.md),
            SkeletonBox(width: 140, height: 16),
            SizedBox(height: AppSpacing.xl),
            Row(
              children: [
                Expanded(child: SkeletonBox(height: 70)),
                SizedBox(width: AppSpacing.sm),
                Expanded(child: SkeletonBox(height: 70)),
                SizedBox(width: AppSpacing.sm),
                Expanded(child: SkeletonBox(height: 70)),
              ],
            ),
            SizedBox(height: AppSpacing.xl),
            SkeletonBox(width: 120, height: 20),
            SizedBox(height: AppSpacing.md),
            SkeletonBox(height: 100, width: double.infinity),
          ],
        ),
      ),
    );
  }
}
