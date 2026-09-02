import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/app_radius.dart';

/// Cached network image with smooth placeholder skeleton and error fallback.
class AppNetworkImage extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadius? borderRadius;
  final Widget? placeholder;
  final Widget? errorWidget;

  const AppNetworkImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
    this.placeholder,
    this.errorWidget,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final effectiveRadius = borderRadius ?? AppRadius.radiusMd;

    if (imageUrl.isEmpty) {
      return _buildErrorPlaceholder(isDark, effectiveRadius);
    }

    return ClipRRect(
      borderRadius: effectiveRadius,
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        width: width,
        height: height,
        fit: fit,
        placeholder: (context, url) =>
            placeholder ?? _buildSkeletonPlaceholder(isDark),
        errorWidget: (context, url, error) =>
            errorWidget ?? _buildErrorPlaceholder(isDark, effectiveRadius),
      ),
    );
  }

  Widget _buildSkeletonPlaceholder(bool isDark) {
    return Container(
      width: width,
      height: height,
      color: isDark ? AppColors.surfaceVariantDark : AppColors.surfaceVariantLight,
      child: Center(
        child: SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(
              isDark ? AppColors.textMutedDark : AppColors.textMutedLight,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildErrorPlaceholder(bool isDark, BorderRadius radius) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceVariantDark : AppColors.surfaceVariantLight,
        borderRadius: radius,
      ),
      child: Center(
        child: Icon(
          Icons.image_not_supported_outlined,
          color: isDark ? AppColors.textMutedDark : AppColors.textMutedLight,
          size: 28,
        ),
      ),
    );
  }
}
