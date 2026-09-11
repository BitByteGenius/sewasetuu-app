import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sewasetu/app/theme/app_colors.dart';
import 'package:sewasetu/app/theme/app_text_styles.dart';

/// Standardized, premium application bar used across all 4 SewaSetu services.
class SewaAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? titleText;
  final Widget? titleWidget;
  final String? subtitleText;
  final Widget? leading;
  final bool showBackButton;
  final VoidCallback? onBackPressed;
  final List<Widget>? actions;
  final bool centerTitle;
  final Color? backgroundColor;
  final double elevation;
  final PreferredSizeWidget? bottom;
  final double toolbarHeight;
  final Widget? trailingBadge;

  const SewaAppBar({
    super.key,
    this.titleText,
    this.titleWidget,
    this.subtitleText,
    this.leading,
    this.showBackButton = true,
    this.onBackPressed,
    this.actions,
    this.centerTitle = false,
    this.backgroundColor,
    this.elevation = 0,
    this.bottom,
    this.toolbarHeight = kToolbarHeight,
    this.trailingBadge,
  });

  @override
  Size get preferredSize => Size.fromHeight(
        toolbarHeight + (bottom?.preferredSize.height ?? (subtitleText != null ? 8 : 0)),
      );

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final canPop = Navigator.of(context).canPop();
    final shouldShowBack = showBackButton && canPop;

    final effectiveBg = backgroundColor ??
        (isDark ? AppColors.backgroundDark : AppColors.backgroundLight);

    final titleSection = titleWidget ??
        (titleText != null
            ? Column(
                crossAxisAlignment: centerTitle
                    ? CrossAxisAlignment.center
                    : CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Text(
                          titleText!,
                          style: AppTextStyles.titleLarge(isDark).copyWith(
                            fontWeight: FontWeight.w800,
                            letterSpacing: -0.3,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (trailingBadge != null) ...[
                        const SizedBox(width: 8),
                        trailingBadge!,
                      ],
                    ],
                  ),
                  if (subtitleText != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      subtitleText!,
                      style: AppTextStyles.bodySmall(isDark).copyWith(
                        color: isDark
                            ? AppColors.textMutedDark
                            : AppColors.textSecondaryLight,
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ],
              )
            : null);

    final effectiveLeading = leading ??
        (shouldShowBack
            ? IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  size: 18,
                ),
                color: isDark ? Colors.white : AppColors.textPrimaryLight,
                tooltip: 'Back',
                onPressed: onBackPressed ?? () => Navigator.of(context).maybePop(),
              )
            : null);

    return AppBar(
      automaticallyImplyLeading: false,
      elevation: elevation,
      scrolledUnderElevation: 0,
      surfaceTintColor: Colors.transparent,
      backgroundColor: effectiveBg,
      foregroundColor: isDark ? Colors.white : AppColors.textPrimaryLight,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
        statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
      ),
      leading: effectiveLeading,
      titleSpacing: shouldShowBack ? 0 : 16,
      title: titleSection,
      centerTitle: centerTitle,
      actions: actions != null
          ? [
              ...actions!,
              const SizedBox(width: 8),
            ]
          : null,
      bottom: bottom,
    );
  }
}
