import 'package:flutter/material.dart';
import 'package:sewasetu/app/theme/app_colors.dart';
import 'package:sewasetu/app/theme/app_radius.dart';
import 'package:sewasetu/app/theme/app_text_styles.dart';
import 'package:sewasetu/shared/widgets/app_bar/app_bar.dart';
import 'package:sewasetu/shared/widgets/app_network_image.dart';

/// Interactive image gallery carousel with page indicators and Hero transition.
class PropertyImageGallery extends StatefulWidget {
  final String heroTag;
  final List<String> images;
  final VoidCallback? onBackTap;
  final VoidCallback? onFavoriteTap;
  final bool isFavorite;

  const PropertyImageGallery({
    super.key,
    required this.heroTag,
    required this.images,
    this.onBackTap,
    this.onFavoriteTap,
    this.isFavorite = false,
  });

  @override
  State<PropertyImageGallery> createState() => _PropertyImageGalleryState();
}

class _PropertyImageGalleryState extends State<PropertyImageGallery> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final totalImages = widget.images.isEmpty ? 1 : widget.images.length;

    return Stack(
      children: [
        // Image Carousel
        SizedBox(
          height: 320,
          child: widget.images.isEmpty
              ? Container(color: isDark ? AppColors.surfaceVariantDark : AppColors.surfaceVariantLight)
              : PageView.builder(
                  controller: _pageController,
                  itemCount: widget.images.length,
                  onPageChanged: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return Hero(
                        tag: widget.heroTag,
                        child: AppNetworkImage(
                          imageUrl: widget.images[index],
                          height: 320,
                          width: double.infinity,
                          borderRadius: BorderRadius.zero,
                        ),
                      );
                    }
                    return AppNetworkImage(
                      imageUrl: widget.images[index],
                      height: 320,
                      width: double.infinity,
                      borderRadius: BorderRadius.zero,
                    );
                  },
                ),
        ),
        // Top Action Bar Overlay
        Positioned(
          top: MediaQuery.of(context).padding.top + 8,
          left: 16,
          right: 16,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SewaFrostedActionButton(
                icon: Icons.arrow_back_ios_new_rounded,
                onTap: widget.onBackTap ?? () => Navigator.of(context).pop(),
              ),
              Row(
                children: [
                  SewaFrostedActionButton(
                    icon: Icons.share_outlined,
                    onTap: () {},
                  ),
                  const SizedBox(width: 10),
                  SewaFrostedActionButton(
                    icon: widget.isFavorite ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                    iconColor: widget.isFavorite ? AppColors.error : null,
                    onTap: widget.onFavoriteTap ?? () {},
                  ),
                ],
              ),
            ],
          ),
        ),
        // Page Counter Badge (Bottom Right)
        Positioned(
          bottom: 16,
          right: 16,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.black.withAlpha(160),
              borderRadius: AppRadius.radiusPill,
            ),
            child: Text(
              '${_currentIndex + 1} / $totalImages',
              style: AppTextStyles.labelSmall(true).copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
