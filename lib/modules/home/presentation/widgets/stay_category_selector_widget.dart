import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_radius.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../shared/enums/stay_type.dart';

/// Horizontal icon categories highlighting the primary Stay options.
class StayCategorySelectorWidget extends StatelessWidget {
  final ValueChanged<StayType> onSelectCategory;

  const StayCategorySelectorWidget({
    super.key,
    required this.onSelectCategory,
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
              Text(
                'Stay & Accommodation',
                style: AppTextStyles.headlineSmall(isDark).copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
              Text(
                'CORE SERVICE',
                style: AppTextStyles.labelSmall(isDark).copyWith(
                  color: isDark ? AppColors.primaryLight : AppColors.primary,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.0,
                ),
              ),
            ],
          ),
        ),
        AppSpacing.gapV12,
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: AppSpacing.horizontalLg,
          child: Row(
            children: StayType.values.map((type) {
              return Padding(
                padding: const EdgeInsets.only(right: 12),
                child: GestureDetector(
                  onTap: () => onSelectCategory(type),
                  child: Container(
                    width: 100,
                    padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
                    decoration: BoxDecoration(
                      color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
                      borderRadius: AppRadius.radiusLg,
                      border: Border.all(
                        color: isDark ? AppColors.borderDark : AppColors.borderLight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha(isDark ? 30 : 10),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: isDark ? AppColors.primaryContainerDark : AppColors.primaryContainer,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              type.emoji,
                              style: const TextStyle(fontSize: 22),
                            ),
                          ),
                        ),
                        AppSpacing.gapV8,
                        Text(
                          type.label,
                          style: AppTextStyles.labelSmall(isDark).copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
