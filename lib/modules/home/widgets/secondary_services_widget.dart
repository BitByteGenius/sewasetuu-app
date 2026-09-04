import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sewasetu/app/routes/app_routes.dart';
import 'package:sewasetu/app/theme/app_colors.dart';
import 'package:sewasetu/app/theme/app_radius.dart';
import 'package:sewasetu/app/theme/app_spacing.dart';
import 'package:sewasetu/app/theme/app_text_styles.dart';
import 'package:sewasetu/modules/shop/shop_navigator.dart';

/// Secondary marketplace section highlighting upcoming modules (Services, Rentals, Trips).
class SecondaryServicesWidget extends StatelessWidget {
  const SecondaryServicesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: AppSpacing.horizontalLg,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'More Marketplace Services',
                      style: AppTextStyles.headlineSmall(isDark).copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      'On-demand local home services & vehicle rentals',
                      style: AppTextStyles.bodySmall(isDark),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        AppSpacing.gapV12,
        Padding(
          padding: AppSpacing.horizontalLg,
          child: Row(
            children: [
              // Home Services Card
              Expanded(
                child: _buildServiceCard(
                  context: context,
                  isDark: isDark,
                  title: 'Local Services',
                  subtitle: 'Electrician, Plumber, Driver',
                  emoji: '⚡',
                  color: const Color(0xFF3B82F6),
                  onTap: () => Get.toNamed(AppRoutes.services),
                ),
              ),
              const SizedBox(width: 12),
              // Rentals Card
              Expanded(
                child: _buildServiceCard(
                  context: context,
                  isDark: isDark,
                  title: 'Vehicle Rentals',
                  subtitle: 'Self-Drive Cars & Bikes',
                  emoji: '🚘',
                  color: const Color(0xFFF59E0B),
                  onTap: () => Get.toNamed(AppRoutes.rentals),
                ),
              ),
              const SizedBox(width: 12),
              // Shop Card
              Expanded(
                child: _buildServiceCard(
                  context: context,
                  isDark: isDark,
                  title: 'Shop',
                  subtitle: 'Traditional & Modern Products',
                  emoji: '🛒',
                  color: const Color(0xFFF59E0B),
                  onTap: () => ShopNavigator.toShop(),
                ),
              ),
            ],
          ),
        ),
        AppSpacing.gapV12,
        // Tour Packages Banner
        Padding(
          padding: AppSpacing.horizontalLg,
          child: GestureDetector(
            onTap: () => Get.toNamed(AppRoutes.trips),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: isDark
                      ? [const Color(0xFF312E81), const Color(0xFF1E1B4B)]
                      : [const Color(0xFF4F46E5), const Color(0xFF6366F1)],
                ),
                borderRadius: AppRadius.radiusLg,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF4F46E5).withAlpha(60),
                    blurRadius: 16,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(50),
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Text('🏔️', style: TextStyle(fontSize: 22)),
                    ),
                  ),
                  AppSpacing.gapH12,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Tour Packages & Trips',
                          style: AppTextStyles.titleMedium(true).copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Text(
                          'Curated travel journeys for Goa, Manali, Shillong',
                          style: AppTextStyles.bodySmall(true).copyWith(
                            color: Colors.white.withAlpha(200),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white, size: 16),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildServiceCard({
    required BuildContext context,
    required bool isDark,
    required String title,
    required String subtitle,
    required String emoji,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
          borderRadius: AppRadius.radiusLg,
          border: Border.all(
            color: isDark ? AppColors.borderDark : AppColors.borderLight,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withAlpha(30),
                shape: BoxShape.circle,
              ),
              child: Text(emoji, style: const TextStyle(fontSize: 20)),
            ),
            AppSpacing.gapV12,
            Text(
              title,
              style: AppTextStyles.titleMedium(isDark).copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            AppSpacing.gapV4,
            Text(
              subtitle,
              style: AppTextStyles.bodySmall(isDark).copyWith(
                fontSize: 11,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
