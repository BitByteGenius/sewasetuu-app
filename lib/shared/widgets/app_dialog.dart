import 'package:flutter/material.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/app_radius.dart';
import '../../app/theme/app_text_styles.dart';
import 'app_button.dart';

/// Reusable modal dialog wrapper adhering to SewaSetu theme standards.
class AppDialog extends StatelessWidget {
  final Widget? titleWidget;
  final String? title;
  final IconData? titleIcon;
  final Color? titleIconColor;
  final Widget content;
  final List<Widget>? actions;
  final EdgeInsetsGeometry padding;
  final BorderRadius? borderRadius;

  const AppDialog({
    super.key,
    this.titleWidget,
    this.title,
    this.titleIcon,
    this.titleIconColor,
    required this.content,
    this.actions,
    this.padding = const EdgeInsets.all(20),
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    Widget? effectiveTitle;
    if (titleWidget != null) {
      effectiveTitle = titleWidget;
    } else if (title != null) {
      effectiveTitle = Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (titleIcon != null) ...[
            Icon(
              titleIcon,
              color: titleIconColor ?? (isDark ? AppColors.primaryLight : AppColors.primary),
              size: 22,
            ),
            const SizedBox(width: 8),
          ],
          Expanded(
            child: Text(
              title!,
              style: AppTextStyles.titleMedium(isDark).copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      );
    }

    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius ?? AppRadius.radiusLg,
      ),
      backgroundColor: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
      title: effectiveTitle,
      contentPadding: padding,
      content: content,
      actions: actions,
    );
  }
}

/// Reusable confirmation dialog for delete, logout, or key user actions.
class AppConfirmationDialog extends StatelessWidget {
  final String title;
  final String message;
  final IconData? icon;
  final Color? iconColor;
  final String confirmText;
  final String cancelText;
  final VoidCallback onConfirm;
  final VoidCallback? onCancel;
  final bool isDanger;

  const AppConfirmationDialog({
    super.key,
    required this.title,
    required this.message,
    this.icon,
    this.iconColor,
    this.confirmText = 'Confirm',
    this.cancelText = 'Cancel',
    required this.onConfirm,
    this.onCancel,
    this.isDanger = false,
  });

  static Future<bool?> show(
    BuildContext context, {
    required String title,
    required String message,
    IconData? icon,
    Color? iconColor,
    String confirmText = 'Confirm',
    String cancelText = 'Cancel',
    bool isDanger = false,
  }) {
    return showDialog<bool>(
      context: context,
      builder: (ctx) => AppConfirmationDialog(
        title: title,
        message: message,
        icon: icon,
        iconColor: iconColor,
        confirmText: confirmText,
        cancelText: cancelText,
        isDanger: isDanger,
        onConfirm: () => Navigator.of(ctx).pop(true),
        onCancel: () => Navigator.of(ctx).pop(false),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final effectiveIconColor = iconColor ?? (isDanger ? AppColors.error : AppColors.primary);

    return AppDialog(
      title: title,
      titleIcon: icon ?? (isDanger ? Icons.warning_amber_rounded : Icons.info_outline_rounded),
      titleIconColor: effectiveIconColor,
      content: Text(
        message,
        style: AppTextStyles.bodyMedium(isDark).copyWith(height: 1.4),
      ),
      actions: [
        TextButton(
          onPressed: onCancel ?? () => Navigator.of(context).pop(false),
          child: Text(
            cancelText,
            style: TextStyle(
              color: isDark ? AppColors.textMutedDark : AppColors.textMutedLight,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        AppButton(
          text: confirmText,
          onPressed: onConfirm,
          variant: isDanger ? AppButtonVariant.danger : AppButtonVariant.primary,
          size: AppButtonSize.small,
        ),
      ],
    );
  }
}
