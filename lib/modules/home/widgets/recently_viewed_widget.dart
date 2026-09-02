import 'package:flutter/material.dart';
import 'package:sewasetu/app/theme/app_colors.dart';
import 'package:sewasetu/app/theme/app_radius.dart';
import 'package:sewasetu/app/theme/app_spacing.dart';
import 'package:sewasetu/app/theme/app_text_styles.dart';
import 'package:sewasetu/core/utils/formatters.dart';
import 'package:sewasetu/modules/stay/stay.dart';
import 'package:sewasetu/shared/widgets/app_card.dart';
import 'package:sewasetu/shared/widgets/app_network_image.dart';

/// Horizontal list of recently viewed stays for quick re-engagement
class RecentlyViewedWidget extends StatelessWidget {
  final List<PropertyModel> stays;
  final ValueChanged<PropertyModel> onStayTap;

  const RecentlyViewedWidget({
    super.key,
    required this.stays,
    required this.onStayTap,
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Recently Viewed',
                style: AppTextStyles.headlineSmall(isDark).copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
              Text(
                'Pick up where you left off',
                style: AppTextStyles.bodySmall(isDark),
              ),
            ],
          ),
        ),
        AppSpacing.gapV12,
        SizedBox(
          height: 110,
          child: ListView.separated(
            padding: AppSpacing.horizontalLg,
            scrollDirection: Axis.horizontal,
            itemCount: stays.length,
            separatorBuilder: (context, index) => AppSpacing.gapH12,
            itemBuilder: (context, index) {
              final stay = stays[index];
              return AppCard(
                padding: const EdgeInsets.all(8),
                width: 280,
                onTap: () => onStayTap(stay),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: AppRadius.radiusMd,
                      child: AppNetworkImage(
                        imageUrl: stay.images.isNotEmpty ? stay.images.first : '',
                        width: 90,
                        height: 90,
                      ),
                    ),
                    AppSpacing.gapH12,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            stay.stayType.label,
                            style: AppTextStyles.labelSmall(isDark).copyWith(
                              color: isDark ? AppColors.primaryLight : AppColors.primary,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          AppSpacing.gapV4,
                          Text(
                            stay.title,
                            style: AppTextStyles.titleSmall(isDark),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          AppSpacing.gapV4,
                          Text(
                            '${AppFormatters.formatCurrency(stay.pricePerNight)} / night',
                            style: AppTextStyles.labelMedium(isDark).copyWith(
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
