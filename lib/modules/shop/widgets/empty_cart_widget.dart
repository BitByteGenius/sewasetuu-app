import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_button.dart';

/// Clean empty state shown when cart has no items
class EmptyCartWidget extends StatelessWidget {
  final VoidCallback onStartShopping;

  const EmptyCartWidget({
    super.key,
    required this.onStartShopping,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: isDark
                    ? AppColors.primaryContainerDark
                    : AppColors.primaryContainer,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.shopping_bag_outlined,
                size: 56,
                color: AppColors.primary,
              ),
            ),
            AppSpacing.gapV24,
            Text(
              'Your Shopping Bag is Empty',
              textAlign: TextAlign.center,
              style: AppTextStyles.titleLarge(isDark).copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
            AppSpacing.gapV8,
            Text(
              'Discover authentic handcrafted treasures, traditional silks, organic foods, and cultural artifacts from states across India.',
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyMedium(isDark).copyWith(
                color: isDark
                    ? AppColors.textMutedDark
                    : AppColors.textSecondaryLight,
              ),
            ),
            AppSpacing.gapV32,
            AppButton.primary(
              text: 'Explore Indian States',
              onPressed: onStartShopping,
            ),
          ],
        ),
      ),
    );
  }
}
