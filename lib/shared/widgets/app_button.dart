import 'package:flutter/material.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/app_radius.dart';
import '../../app/theme/app_shadows.dart';
import '../../app/theme/app_text_styles.dart';

enum AppButtonVariant { primary, secondary, outline, text, danger }

enum AppButtonSize { small, medium, large }

/// Premium animated button with tactile scaling, loading indicators, and variant styling.
class AppButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final AppButtonSize size;
  final bool isLoading;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Widget? icon;
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;
  final Color? textColor;
  final Color? borderColor;

  const AppButton({
    super.key,
    required this.text,
    this.onPressed,
    this.variant = AppButtonVariant.primary,
    this.size = AppButtonSize.medium,
    this.isLoading = false,
    this.prefixIcon,
    this.suffixIcon,
    this.icon,
    this.width,
    this.height,
    this.borderRadius,
    this.textColor,
    this.borderColor,
  });

  const AppButton.primary({
    super.key,
    required this.text,
    this.onPressed,
    this.size = AppButtonSize.medium,
    this.isLoading = false,
    this.prefixIcon,
    this.suffixIcon,
    this.icon,
    this.width,
    this.height,
    this.borderRadius,
    this.textColor,
    this.borderColor,
  }) : variant = AppButtonVariant.primary;

  const AppButton.secondary({
    super.key,
    required this.text,
    this.onPressed,
    this.size = AppButtonSize.medium,
    this.isLoading = false,
    this.prefixIcon,
    this.suffixIcon,
    this.icon,
    this.width,
    this.height,
    this.borderRadius,
    this.textColor,
    this.borderColor,
  }) : variant = AppButtonVariant.secondary;

  const AppButton.outline({
    super.key,
    required this.text,
    this.onPressed,
    this.size = AppButtonSize.medium,
    this.isLoading = false,
    this.prefixIcon,
    this.suffixIcon,
    this.icon,
    this.width,
    this.height,
    this.borderRadius,
    this.textColor,
    this.borderColor,
  }) : variant = AppButtonVariant.outline;

  const AppButton.text({
    super.key,
    required this.text,
    this.onPressed,
    this.size = AppButtonSize.medium,
    this.isLoading = false,
    this.prefixIcon,
    this.suffixIcon,
    this.icon,
    this.width,
    this.height,
    this.borderRadius,
    this.textColor,
    this.borderColor,
  }) : variant = AppButtonVariant.text;

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.96).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    if (widget.onPressed != null && !widget.isLoading) {
      _controller.forward();
    }
  }

  void _onTapUp(TapUpDetails details) {
    if (widget.onPressed != null && !widget.isLoading) {
      _controller.reverse();
    }
  }

  void _onTapCancel() {
    if (widget.onPressed != null && !widget.isLoading) {
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isEnabled = widget.onPressed != null && !widget.isLoading;

    // Size parameters
    double height;
    EdgeInsets padding;
    double fontSize;

    switch (widget.size) {
      case AppButtonSize.small:
        height = 38.0;
        padding = const EdgeInsets.symmetric(horizontal: 14);
        fontSize = 13.0;
        break;
      case AppButtonSize.large:
        height = 56.0;
        padding = const EdgeInsets.symmetric(horizontal: 24);
        fontSize = 16.0;
        break;
      case AppButtonSize.medium:
        height = 48.0;
        padding = const EdgeInsets.symmetric(horizontal: 20);
        fontSize = 14.5;
        break;
    }

    // Styling according to variant
    Color bgColor;
    Color fgColor;
    Border? border;
    List<BoxShadow>? shadows;

    switch (widget.variant) {
      case AppButtonVariant.primary:
        bgColor = isEnabled
            ? (isDark ? AppColors.primaryLight : AppColors.primary)
            : (isDark ? AppColors.surfaceVariantDark : AppColors.borderLight);
        fgColor = widget.textColor ?? (isEnabled
            ? (isDark ? Colors.black : Colors.white)
            : (isDark ? AppColors.textMutedDark : AppColors.textMutedLight));
        shadows = isEnabled && !isDark ? AppShadows.primaryGlow : null;
        break;
      case AppButtonVariant.secondary:
        bgColor = isEnabled
            ? (isDark ? AppColors.primaryContainerDark : AppColors.primaryContainer)
            : (isDark ? AppColors.surfaceVariantDark : AppColors.borderLight);
        fgColor = widget.textColor ?? (isDark ? AppColors.primaryLight : AppColors.primary);
        break;
      case AppButtonVariant.outline:
        bgColor = Colors.transparent;
        fgColor = widget.textColor ?? (isDark ? AppColors.primaryLight : AppColors.primary);
        border = Border.all(
          color: widget.borderColor ?? (isEnabled
              ? (isDark ? AppColors.primaryLight : AppColors.primary)
              : (isDark ? AppColors.borderDark : AppColors.borderLight)),
          width: 1.5,
        );
        break;
      case AppButtonVariant.text:
        bgColor = Colors.transparent;
        fgColor = widget.textColor ?? (isDark ? AppColors.primaryLight : AppColors.primary);
        break;
      case AppButtonVariant.danger:
        bgColor = isEnabled ? AppColors.error : AppColors.errorLight;
        fgColor = widget.textColor ?? Colors.white;
        break;
    }

    final radius = widget.borderRadius ?? AppRadius.radiusMd;
    final effectiveLeadingIcon = widget.icon ?? widget.prefixIcon;

    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) => Transform.scale(
        scale: _scaleAnimation.value,
        child: child,
      ),
      child: GestureDetector(
        onTapDown: _onTapDown,
        onTapUp: _onTapUp,
        onTapCancel: _onTapCancel,
        onTap: isEnabled ? widget.onPressed : null,
        child: Container(
          width: widget.width,
          height: widget.height ?? height,
          padding: padding,
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: radius,
            border: border,
            boxShadow: shadows,
          ),
          child: Center(
            child: widget.isLoading
                ? SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      valueColor: AlwaysStoppedAnimation<Color>(fgColor),
                    ),
                  )
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (effectiveLeadingIcon != null) ...[
                        effectiveLeadingIcon,
                        const SizedBox(width: 8),
                      ],
                      Text(
                        widget.text,
                        style: AppTextStyles.labelLarge(isDark).copyWith(
                          color: fgColor,
                          fontSize: fontSize,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      if (widget.suffixIcon != null) ...[
                        const SizedBox(width: 8),
                        widget.suffixIcon!,
                      ],
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
