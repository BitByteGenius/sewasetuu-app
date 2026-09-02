import 'package:flutter/material.dart';
import 'package:sewasetu/app/theme/app_colors.dart';
import 'package:sewasetu/app/theme/app_spacing.dart';
import 'package:sewasetu/app/theme/app_text_styles.dart';
import 'package:sewasetu/modules/stay/property/domain/entities/stay_entity.dart';
import 'package:sewasetu/modules/stay/property/presentation/widgets/stay_card_widget.dart';

/// Recommended / Top Picks stay cards carousel
class RecommendedStaysWidget extends StatelessWidget {
  final List<StayEntity> stays;
  final ValueChanged<StayEntity> onStayTap;
  final VoidCallback onViewAll;

  const RecommendedStaysWidget({
    super.key,
    required this.stays,
    required this.onStayTap,
    required this.onViewAll,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (stays.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: AppSpacing.horizontalLg,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Recommended Stays',
                        style: AppTextStyles.headlineSmall(isDark).copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text('🔥', style: const TextStyle(fontSize: 18)),
                    ],
                  ),
                  Text(
                    'Curated stays tailored to your recent searches',
                    style: AppTextStyles.bodySmall(isDark),
                  ),
                ],
              ),
              TextButton(
                onPressed: onViewAll,
                child: Text(
                  'View All',
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
          height: 280,
          child: ListView.separated(
            padding: AppSpacing.horizontalLg,
            scrollDirection: Axis.horizontal,
            itemCount: stays.length,
            separatorBuilder: (context, index) => AppSpacing.gapH12,
            itemBuilder: (context, index) {
              final stay = stays[index];
              return StayCardWidget(
                stay: stay,
                style: StayCardStyle.compact,
                width: 260,
                onTap: () => onStayTap(stay),
              );
            },
          ),
        ),
      ],
    );
  }
}
