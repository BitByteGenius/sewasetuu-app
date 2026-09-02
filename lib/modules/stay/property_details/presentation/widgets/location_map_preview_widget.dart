import 'package:flutter/material.dart';
import 'package:sewasetu/app/theme/app_colors.dart';
import 'package:sewasetu/app/theme/app_radius.dart';
import 'package:sewasetu/app/theme/app_spacing.dart';
import 'package:sewasetu/app/theme/app_text_styles.dart';

/// Clean stylized map visual card preview with address, distance markers and 400m privacy circle overlay
class LocationMapPreviewWidget extends StatelessWidget {
  final String address;
  final String city;
  final String distanceText;

  const LocationMapPreviewWidget({
    super.key,
    required this.address,
    required this.city,
    required this.distanceText,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Stylized map placeholder container with 400m circle overlay
        ClipRRect(
          borderRadius: AppRadius.radiusLg,
          child: Container(
            height: 180,
            width: double.infinity,
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF1E2A38) : const Color(0xFFE2E8F0),
            ),
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.network(
                    'https://images.unsplash.com/photo-1524661135-423995f22d0b?auto=format&fit=crop&w=800&q=80',
                    fit: BoxFit.cover,
                    opacity: const AlwaysStoppedAnimation(0.7),
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: isDark ? const Color(0xFF1E2A38) : const Color(0xFFE2E8F0),
                    ),
                  ),
                ),
                // 400m Translucent Privacy Circle overlay
                Center(
                  child: Container(
                    width: 140,
                    height: 140,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: (isDark ? AppColors.primaryLight : AppColors.primary).withAlpha(40),
                      border: Border.all(
                        color: (isDark ? AppColors.primaryLight : AppColors.primary).withAlpha(160),
                        width: 2,
                      ),
                    ),
                  ),
                ),
                // Center Icon Marker
                Center(
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: isDark ? AppColors.primaryLight : AppColors.primary,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha(60),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.home_rounded,
                      color: isDark ? Colors.black : Colors.white,
                      size: 20,
                    ),
                  ),
                ),
                // Privacy notice tag (Top Left)
                Positioned(
                  top: 10,
                  left: 10,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: (isDark ? AppColors.surfaceDark : Colors.white).withAlpha(240),
                      borderRadius: AppRadius.radiusPill,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.security_rounded,
                          size: 13,
                          color: isDark ? AppColors.primaryLight : AppColors.primary,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Approximate location (400m)',
                          style: AppTextStyles.labelSmall(isDark).copyWith(
                            fontWeight: FontWeight.w700,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Distance Pill (Bottom Left)
                Positioned(
                  bottom: 12,
                  left: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: isDark ? AppColors.surfaceDark.withAlpha(230) : Colors.white.withAlpha(240),
                      borderRadius: AppRadius.radiusPill,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.near_me_outlined,
                          size: 14,
                          color: isDark ? AppColors.primaryLight : AppColors.primary,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          distanceText,
                          style: AppTextStyles.labelSmall(isDark).copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        AppSpacing.gapV12,
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Icons.location_on_outlined,
              size: 20,
              color: isDark ? AppColors.primaryLight : AppColors.primary,
            ),
            AppSpacing.gapH8,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    address,
                    style: AppTextStyles.bodyMedium(isDark).copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    city,
                    style: AppTextStyles.bodySmall(isDark),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
