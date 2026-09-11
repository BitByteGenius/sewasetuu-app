import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sewasetu/app/theme/app_colors.dart';
import 'package:sewasetu/app/theme/app_text_styles.dart';
import 'sewa_frosted_action_button.dart';

/// Premium collapsing sliver app bar with hero imagery and frosted action buttons.
class SewaSliverAppBar extends StatelessWidget {
  final double expandedHeight;
  final Widget background;
  final String? title;
  final VoidCallback? onBack;
  final bool showBackButton;
  final List<Widget>? actions;
  final bool pinned;

  const SewaSliverAppBar({
    super.key,
    this.expandedHeight = 280,
    required this.background,
    this.title,
    this.onBack,
    this.showBackButton = true,
    this.actions,
    this.pinned = true,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final canPop = Navigator.of(context).canPop();
    final shouldShowBack = showBackButton && canPop;

    return SliverAppBar(
      expandedHeight: expandedHeight,
      pinned: pinned,
      elevation: 0,
      scrolledUnderElevation: 0,
      surfaceTintColor: Colors.transparent,
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      leading: shouldShowBack
          ? Center(
              child: SewaFrostedActionButton(
                icon: Icons.arrow_back_ios_new_rounded,
                iconSize: 16,
                onTap: onBack ?? () => Navigator.of(context).maybePop(),
              ),
            )
          : null,
      actions: actions != null
          ? [
              ...actions!.map((action) => Center(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: action,
                    ),
                  )),
              const SizedBox(width: 8),
            ]
          : null,
      flexibleSpace: FlexibleSpaceBar(
        title: title != null
            ? Text(
                title!,
                style: AppTextStyles.titleMedium(isDark).copyWith(
                  fontWeight: FontWeight.w800,
                  shadows: const [
                    Shadow(color: Colors.black54, blurRadius: 8),
                  ],
                ),
              )
            : null,
        centerTitle: false,
        background: Stack(
          fit: StackFit.expand,
          children: [
            background,
            // Top protection gradient for status bar & action buttons
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: 100,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withValues(alpha: 0.65),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
            // Bottom protection gradient for title
            if (title != null)
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                height: 80,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black.withValues(alpha: 0.65),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
