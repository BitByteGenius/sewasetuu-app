import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sewasetu/app/routes/app_routes.dart';
import 'package:sewasetu/app/theme/app_colors.dart';
import 'package:sewasetu/app/theme/app_radius.dart';
import 'package:sewasetu/app/theme/app_spacing.dart';
import 'package:sewasetu/app/theme/app_text_styles.dart';
import 'package:sewasetu/shared/enums/stay_type.dart';

/// Top Primary Category Cards (Rooms, PG, Mess, Homestay, Hotel)
class StayCategorySelectorWidget extends StatelessWidget {
  final ValueChanged<StayType> onCategorySelected;

  const StayCategorySelectorWidget({
    super.key,
    required this.onCategorySelected,
  });

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
                child: GestureDetector(
                  onTap: () => Get.toNamed(AppRoutes.stayList),
                  behavior: HitTestBehavior.opaque,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Text(
                          'Explore by Category',
                          style: AppTextStyles.headlineSmall(isDark).copyWith(
                            fontWeight: FontWeight.w800,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      AppSpacing.gapH8,
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 14,
                        color: isDark ? AppColors.textMutedDark : AppColors.textMutedLight,
                      ),
                    ],
                  ),
                ),
              ),
              AppSpacing.gapH8,
              TextButton(
                onPressed: () => Get.toNamed(AppRoutes.stayList),
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: const Size(50, 30),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  'See All',
                  style: AppTextStyles.labelMedium(isDark).copyWith(
                    color: isDark ? AppColors.primaryLight : AppColors.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
        AppSpacing.gapV12,
        SizedBox(
          height: 100,
          child: ListView.separated(
            padding: AppSpacing.horizontalLg,
            scrollDirection: Axis.horizontal,
            itemCount: StayType.values.length,
            separatorBuilder: (context, index) => AppSpacing.gapH12,
            itemBuilder: (context, index) {
              final type = StayType.values[index];
              return _buildCategoryItem(context, type, isDark);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryItem(BuildContext context, StayType type, bool isDark) {
    return InkWell(
      onTap: () => onCategorySelected(type),
      borderRadius: AppRadius.radiusLg,
      child: Container(
        width: 86,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        decoration: BoxDecoration(
          color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
          borderRadius: AppRadius.radiusLg,
          border: Border.all(
            color: isDark ? AppColors.borderDark : AppColors.borderLight,
            width: 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              type.emoji,
              style: const TextStyle(fontSize: 28),
            ),
            AppSpacing.gapV8,
            Text(
              type.label,
              style: AppTextStyles.labelSmall(isDark).copyWith(
                fontWeight: FontWeight.w700,
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
