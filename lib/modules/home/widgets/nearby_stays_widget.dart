import 'package:flutter/material.dart';
import 'package:sewasetu/app/theme/app_colors.dart';
import 'package:sewasetu/app/theme/app_spacing.dart';
import 'package:sewasetu/app/theme/app_text_styles.dart';
import 'package:sewasetu/modules/stay/stay.dart';

/// Nearby stays in user's current city with list display.
class NearbyStaysWidget extends StatelessWidget {
  final List<PropertyModel> stays;
  final String currentCity;
  final ValueChanged<PropertyModel> onStayTap;
  final VoidCallback onViewAll;

  const NearbyStaysWidget({
    super.key,
    required this.stays,
    required this.currentCity,
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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Nearby in $currentCity',
                      style: AppTextStyles.headlineSmall(isDark).copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      'Instant check-in & flexible agreements',
                      style: AppTextStyles.bodySmall(isDark),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              TextButton(
                onPressed: onViewAll,
                child: Text(
                  'Explore',
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
        ListView.separated(
          padding: AppSpacing.horizontalLg,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: stays.length > 3 ? 3 : stays.length,
          separatorBuilder: (context, index) => AppSpacing.gapV12,
          itemBuilder: (context, index) {
            final stay = stays[index];
            return StayCardWidget(
              stay: stay,
              style: StayCardStyle.horizontal,
              onTap: () => onStayTap(stay),
            );
          },
        ),
      ],
    );
  }
}
