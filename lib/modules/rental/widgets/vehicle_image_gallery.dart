import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/theme/app_radius.dart';
import '../../../app/theme/app_shadows.dart';
import '../../../app/theme/app_spacing.dart';
import '../../../shared/widgets/app_bar/app_bar.dart';
import '../controllers/rental_favorites_controller.dart';
import '../models/vehicle_model.dart';

/// Full-width swipeable image gallery for vehicle details with indicators and full-screen viewer.
class VehicleImageGallery extends StatefulWidget {
  final VehicleModel vehicle;

  const VehicleImageGallery({
    super.key,
    required this.vehicle,
  });

  @override
  State<VehicleImageGallery> createState() => _VehicleImageGalleryState();
}

class _VehicleImageGalleryState extends State<VehicleImageGallery> {
  late PageController _pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _openFullScreen(int initialIndex) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withAlpha((255 * 0.95).round()),
      builder: (context) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.close, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            title: Text(
              widget.vehicle.fullName,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
          body: PageView.builder(
            itemCount: widget.vehicle.images.length,
            controller: PageController(initialPage: initialIndex),
            itemBuilder: (context, index) {
              return InteractiveViewer(
                child: Center(
                  child: CachedNetworkImage(
                    imageUrl: widget.vehicle.images[index],
                    fit: BoxFit.contain,
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final images = widget.vehicle.images.isNotEmpty
        ? widget.vehicle.images
        : ['https://images.unsplash.com/photo-1533473359331-0135ef1b58bf?auto=format&fit=crop&w=1000&q=80'];

    final favCtrl = Get.isRegistered<RentalFavoritesController>()
        ? Get.find<RentalFavoritesController>()
        : null;

    return Stack(
      children: [
        // 1. PageView Images
        SizedBox(
          height: 280,
          child: PageView.builder(
            controller: _pageController,
            itemCount: images.length,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => _openFullScreen(index),
                child: Hero(
                  tag: 'vehicle_img_${widget.vehicle.id}_$index',
                  child: CachedNetworkImage(
                    imageUrl: images[index],
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      color: Colors.grey.shade900,
                      child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
                    ),
                    errorWidget: (context, url, error) => Container(
                      color: Colors.grey.shade900,
                      child: const Icon(Icons.directions_car, color: Colors.white38, size: 60),
                    ),
                  ),
                ),
              );
            },
          ),
        ),

        // Gradient at top for icons visibility
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          height: 90,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withAlpha((255 * 0.6).round()),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),

        // Navigation Bar Actions (Back & Favorite)
        Positioned(
          top: MediaQuery.of(context).padding.top + 8,
          left: AppSpacing.md,
          right: AppSpacing.md,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Back Button
              SewaFrostedActionButton(
                icon: Icons.arrow_back_ios_new_rounded,
                onPressed: () => Navigator.pop(context),
              ),

              // Favorite Action
              if (favCtrl != null)
                Obx(() {
                  final isFav = favCtrl.isFavorite(widget.vehicle.id);
                  return SewaFrostedActionButton(
                    icon: isFav ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                    iconColor: isFav ? Colors.redAccent : Colors.white,
                    onPressed: () => favCtrl.toggleFavorite(widget.vehicle),
                  );
                }),
            ],
          ),
        ),

        // Bottom Image Counter Dots
        if (images.length > 1)
          Positioned(
            bottom: AppSpacing.md,
            right: AppSpacing.lg,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.black.withAlpha((255 * 0.65).round()),
                borderRadius: AppRadius.radiusFull,
                boxShadow: AppShadows.soft,
              ),
              child: Text(
                '${_currentIndex + 1} / ${images.length}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
