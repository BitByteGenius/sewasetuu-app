import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../app/routes/app_routes.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_radius.dart';
import '../../../../app/theme/app_shadows.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_text_styles.dart';

/// Interactive search card with instant search redirect and direct filter trigger.
class HomeSearchBarWidget extends StatelessWidget {
  final VoidCallback? onFilterTap;

  const HomeSearchBarWidget({
    super.key,
    this.onFilterTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: AppSpacing.horizontalLg,
      child: GestureDetector(
        onTap: () => Get.toNamed(AppRoutes.staySearch),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
            borderRadius: AppRadius.radiusLg,
            border: Border.all(
              color: isDark ? AppColors.borderDark : AppColors.borderLight,
            ),
            boxShadow: isDark ? AppShadows.darkCard : AppShadows.soft,
          ),
          child: Row(
            children: [
              Icon(
                Icons.search_rounded,
                size: 22,
                color: isDark ? AppColors.primaryLight : AppColors.primary,
              ),
              AppSpacing.gapH12,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Search rooms, PGs, mess, homestays...',
                      style: AppTextStyles.bodyMedium(isDark).copyWith(
                        color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      'Anywhere • Any price • Verified only',
                      style: AppTextStyles.bodySmall(isDark).copyWith(
                        color: isDark ? AppColors.textMutedDark : AppColors.textMutedLight,
                      ),
                    ),
                  ],
                ),
              ),
              AppSpacing.gapH8,
              GestureDetector(
                onTap: onFilterTap,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.surfaceVariantDark : AppColors.surfaceVariantLight,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.tune_rounded,
                    size: 18,
                    color: isDark ? AppColors.primaryLight : AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
