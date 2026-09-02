import 'package:flutter/material.dart';
import 'package:sewasetu/app/theme/app_colors.dart';
import 'package:sewasetu/app/theme/app_radius.dart';
import 'package:sewasetu/app/theme/app_spacing.dart';
import 'package:sewasetu/app/theme/app_text_styles.dart';

/// Modal bottom sheet wrapper with drag handle, title, and action footer.
class AppBottomSheet extends StatelessWidget {
  final String title;
  final Widget child;
  final Widget? trailing;
  final Widget? footer;
  final double? maxHeightFactor;

  const AppBottomSheet({
    super.key,
    required this.title,
    required this.child,
    this.trailing,
    this.footer,
    this.maxHeightFactor = 0.85,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      constraints: BoxConstraints(
        maxHeight: screenHeight * (maxHeightFactor ?? 0.85),
      ),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
        borderRadius: AppRadius.topXxl,
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle bar
            Center(
              child: Container(
                margin: const EdgeInsets.only(top: 12, bottom: 8),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: isDark ? AppColors.borderDark : AppColors.borderLight,
                  borderRadius: AppRadius.radiusPill,
                ),
              ),
            ),
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: AppTextStyles.headlineSmall(isDark),
                    ),
                  ),
                  if (trailing != null) trailing!,
                  IconButton(
                    icon: const Icon(Icons.close, size: 20),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            // Body
            Flexible(
              child: SingleChildScrollView(
                padding: AppSpacing.edgeInsetsLg,
                child: child,
              ),
            ),
            // Footer Action
            if (footer != null) ...[
              const Divider(height: 1),
              Padding(
                padding: AppSpacing.edgeInsetsLg,
                child: footer!,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
