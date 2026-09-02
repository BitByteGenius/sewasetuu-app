import 'package:flutter/material.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/app_spacing.dart';
import '../../app/theme/app_text_styles.dart';
import 'app_button.dart';

/// Illustrated empty state / error placeholder with optional retry or action button.
class AppEmptyState extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final String? actionText;
  final VoidCallback? onAction;

  const AppEmptyState({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    this.actionText,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Center(
      child: Padding(
        padding: AppSpacing.horizontalXxl,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: isDark ? AppColors.surfaceVariantDark : AppColors.primaryContainer,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 48,
                color: isDark ? AppColors.primaryLight : AppColors.primary,
              ),
            ),
            AppSpacing.gapV24,
            Text(
              title,
              style: AppTextStyles.headlineSmall(isDark),
              textAlign: TextAlign.center,
            ),
            AppSpacing.gapV8,
            Text(
              description,
              style: AppTextStyles.bodyMedium(isDark).copyWith(
                color: isDark ? AppColors.textMutedDark : AppColors.textSecondaryLight,
              ),
              textAlign: TextAlign.center,
            ),
            if (actionText != null && onAction != null) ...[
              AppSpacing.gapV24,
              AppButton.primary(
                text: actionText!,
                onPressed: onAction,
                size: AppButtonSize.medium,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
