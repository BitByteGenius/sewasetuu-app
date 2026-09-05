import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_radius.dart';
import '../../../app/theme/app_shadows.dart';
import '../../../app/theme/app_spacing.dart';
import '../controllers/rental_controller.dart';
import '../data/datasources/rental_mock_datasource.dart';
import '../models/vehicle_model.dart';
import '../screens/vehicle_list_screen.dart';

/// Premium animated carousel displaying high-impact automotive marketing campaigns and offers.
class RentalBannerCarousel extends StatefulWidget {
  final List<RentalBannerCampaign> campaigns;

  const RentalBannerCarousel({
    super.key,
    required this.campaigns,
  });

  @override
  State<RentalBannerCarousel> createState() => _RentalBannerCarouselState();
}

class _RentalBannerCarouselState extends State<RentalBannerCarousel> {
  late PageController _pageController;
  int _currentPage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.92);
    _startAutoSlide();
  }

  void _startAutoSlide() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (widget.campaigns.isEmpty || !_pageController.hasClients) return;
      final nextPage = (_currentPage + 1) % widget.campaigns.length;
      _pageController.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOutCubic,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _handleCtaTap(RentalBannerCampaign campaign) {
    RentalVehicleType targetType = RentalVehicleType.all;
    if (campaign.vehicleTypeId == 'suv') {
      targetType = RentalVehicleType.suv;
    } else if (campaign.vehicleTypeId == 'bike') {
      targetType = RentalVehicleType.bike;
    } else if (campaign.vehicleTypeId == 'luxury') {
      targetType = RentalVehicleType.luxury;
    } else if (campaign.vehicleTypeId == 'electric') {
      targetType = RentalVehicleType.electric;
    }

    if (Get.isRegistered<RentalController>()) {
      Get.find<RentalController>().selectCategoryTab(targetType);
    }
    Get.to(() => const VehicleListScreen());
  }

  @override
  Widget build(BuildContext context) {
    if (widget.campaigns.isEmpty) return const SizedBox.shrink();

    final screenWidth = MediaQuery.of(context).size.width;
    final carouselHeight = screenWidth > 600 ? 230.0 : 190.0;

    return Column(
      children: [
        SizedBox(
          height: carouselHeight,
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.campaigns.length,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              final campaign = widget.campaigns[index];
              return _buildBannerCard(campaign, carouselHeight);
            },
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        // Indicator Dots
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            widget.campaigns.length,
            (index) => AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 3),
              height: 5,
              width: _currentPage == index ? 22 : 6,
              decoration: BoxDecoration(
                color: _currentPage == index
                    ? AppColors.primary
                    : AppColors.primary.withAlpha((255 * 0.25).round()),
                borderRadius: AppRadius.radiusFull,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBannerCard(RentalBannerCampaign campaign, double height) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: AppRadius.radiusXl,
        boxShadow: AppShadows.card,
      ),
      child: ClipRRect(
        borderRadius: AppRadius.radiusXl,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Background Image
            CachedNetworkImage(
              imageUrl: campaign.imageUrl,
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                color: Colors.grey.shade900,
              ),
              errorWidget: (context, url, error) => Container(
                color: Colors.grey.shade900,
                child: const Icon(Icons.directions_car, color: Colors.white38, size: 48),
              ),
            ),

            // Cinematic Gradient Overlay
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Colors.black.withAlpha((255 * 0.88).round()),
                    Colors.black.withAlpha((255 * 0.65).round()),
                    Colors.transparent,
                  ],
                  stops: const [0.0, 0.55, 1.0],
                ),
              ),
            ),

            // Text & Content
            Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Badge
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: AppColors.secondary,
                      borderRadius: AppRadius.radiusXs,
                    ),
                    child: Text(
                      campaign.badgeText,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.6,
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),

                  // Title
                  Text(
                    campaign.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.3,
                    ),
                  ),
                  const SizedBox(height: 4),

                  // Subtitle
                  SizedBox(
                    width: 220,
                    child: Text(
                      campaign.subtitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.white.withAlpha((255 * 0.85).round()),
                        fontSize: 12,
                        height: 1.3,
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),

                  // CTA Button
                  InkWell(
                    onTap: () => _handleCtaTap(campaign),
                    borderRadius: AppRadius.radiusFull,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: AppRadius.radiusFull,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            campaign.ctaText,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(width: 4),
                          const Icon(
                            Icons.arrow_forward,
                            size: 14,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
