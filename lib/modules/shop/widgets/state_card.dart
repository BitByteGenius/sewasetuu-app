import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_radius.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_card.dart';
import '../../../../shared/widgets/app_network_image.dart';
import '../models/shop_state_model.dart';
import '../shop_navigator.dart';

/// Card representing a State in the grid or list exploration view
class StateCard extends StatelessWidget {
  final ShopStateModel stateModel;

  const StateCard({
    super.key,
    required this.stateModel,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return AppCard(
      padding: EdgeInsets.zero,
      onTap: () => ShopNavigator.toStateProducts(stateModel),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image banner with item badge
          Stack(
            children: [
              AppNetworkImage(
                imageUrl: stateModel.image,
                height: 125,
                width: double.infinity,
                borderRadius: AppRadius.topXl,
              ),
              Positioned(
                top: 10,
                right: 10,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withAlpha(160),
                    borderRadius: AppRadius.radiusPill,
                    border: Border.all(color: Colors.white.withAlpha(40)),
                  ),
                  child: Text(
                    '${stateModel.productCount} Items',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 8,
                left: 10,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.primaryDark : AppColors.primary,
                    borderRadius: AppRadius.radiusPill,
                  ),
                  child: Text(
                    stateModel.region,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 9.5,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
          // State details
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  stateModel.name,
                  style: AppTextStyles.titleMedium(isDark).copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  stateModel.shortDescription,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.bodySmall(isDark).copyWith(
                    color: isDark
                        ? AppColors.textMutedDark
                        : AppColors.textSecondaryLight,
                    fontSize: 11.5,
                    height: 1.3,
                  ),
                ),
                AppSpacing.gapV8,
                // Highlights
                if (stateModel.culturalHighlights.isNotEmpty)
                  Wrap(
                    spacing: 4,
                    runSpacing: 4,
                    children: stateModel.culturalHighlights.take(2).map((h) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: isDark
                              ? AppColors.surfaceVariantDark
                              : AppColors.surfaceVariantLight,
                          borderRadius: AppRadius.radiusSm,
                        ),
                        child: Text(
                          h,
                          style: TextStyle(
                            fontSize: 10,
                            color: isDark
                                ? AppColors.textSecondaryDark
                                : AppColors.textSecondaryLight,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
