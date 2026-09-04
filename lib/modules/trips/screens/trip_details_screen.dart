import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_radius.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_card.dart';
import '../../../../shared/widgets/app_network_image.dart';
import '../controllers/trip_details_controller.dart';
import '../models/trip_package_model.dart';
import '../trips_navigator.dart';
import '../widgets/itinerary_timeline.dart';
import '../widgets/traveler_selector.dart';
import '../widgets/trip_booking_bottom_bar.dart';
import '../widgets/trip_date_selector.dart';
import '../widgets/trip_exclusions_widget.dart';
import '../widgets/trip_inclusions_widget.dart';

/// Flagship screen presenting complete package overview, itinerary, dates, and party selection
class TripDetailsScreen extends StatefulWidget {
  final TripPackageModel package;

  const TripDetailsScreen({
    super.key,
    required this.package,
  });

  @override
  State<TripDetailsScreen> createState() => _TripDetailsScreenState();
}

class _TripDetailsScreenState extends State<TripDetailsScreen> {
  late final TripDetailsController controller;
  late final PageController _photoPageController;

  @override
  void initState() {
    super.initState();
    controller = Get.find<TripDetailsController>(tag: widget.package.id);
    _photoPageController = PageController();
  }

  @override
  void dispose() {
    _photoPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final package = widget.package;
    final allImages = [
      package.coverImage,
      ...package.images.where((img) => img != package.coverImage),
    ];

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // 1. Immersive Photo Gallery Sliver
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            leading: IconButton(
              icon: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.black.withAlpha(120),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.arrow_back_ios_new_rounded,
                    color: Colors.white, size: 16),
              ),
              onPressed: () => Get.back(),
            ),
            actions: [
              IconButton(
                icon: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.black.withAlpha(120),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.share_outlined,
                      color: Colors.white, size: 18),
                ),
                onPressed: () {
                  Get.snackbar(
                    'Share Itinerary',
                    'Trip itinerary link copied to clipboard!',
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.black.withAlpha(200),
                    colorText: Colors.white,
                    margin: const EdgeInsets.all(16),
                    borderRadius: 12,
                    duration: const Duration(seconds: 2),
                  );
                },
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  PageView.builder(
                    controller: _photoPageController,
                    itemCount: allImages.length,
                    onPageChanged: (idx) => controller.setPhotoIndex(idx),
                    itemBuilder: (context, index) {
                      return AppNetworkImage(
                        imageUrl: allImages[index],
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                  // Dark shadow gradient on top and bottom
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withAlpha(100),
                          Colors.transparent,
                          Colors.black.withAlpha(180),
                        ],
                      ),
                    ),
                  ),
                  // Bottom photo index indicator
                  Positioned(
                    bottom: 14,
                    right: 14,
                    child: Obx(() {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.black.withAlpha(160),
                          borderRadius: AppRadius.radiusFull,
                        ),
                        child: Text(
                          '${controller.currentPhotoIndex.value + 1} / ${allImages.length}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      );
                    }),
                  ),
                  // Bottom left duration pill
                  Positioned(
                    bottom: 14,
                    left: 14,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: AppRadius.radiusSm,
                      ),
                      child: Text(
                        package.durationText.toUpperCase(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10.5,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 2. Scrollable Body Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Location & Rating Header Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.location_on,
                              size: 16, color: AppColors.primary),
                          const SizedBox(width: 4),
                          Text(
                            package.locationText,
                            style: AppTextStyles.labelMedium(isDark).copyWith(
                              color: isDark
                                  ? AppColors.primaryLight
                                  : AppColors.primary,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: AppColors.secondary.withAlpha(25),
                          borderRadius: AppRadius.radiusSm,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.star_rounded,
                                color: AppColors.secondary, size: 16),
                            const SizedBox(width: 4),
                            Text(
                              package.rating.toStringAsFixed(1),
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            Text(
                              ' (${package.reviewCount} reviews)',
                              style: TextStyle(
                                fontSize: 11,
                                color: isDark
                                    ? AppColors.textMutedDark
                                    : AppColors.textMutedLight,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Package Title
                  Text(
                    package.title,
                    style: AppTextStyles.headlineSmall(isDark).copyWith(
                      fontWeight: FontWeight.w900,
                      height: 1.25,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Price & Discount Box
                  AppCard(
                    padding: const EdgeInsets.all(14),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'STARTING FROM',
                              style: AppTextStyles.labelSmall(isDark).copyWith(
                                letterSpacing: 0.6,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              textBaseline: TextBaseline.alphabetic,
                              children: [
                                Text(
                                  '₹${package.basePrice.toStringAsFixed(0)}',
                                  style: AppTextStyles.priceTag(isDark,
                                      fontSize: 22),
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  '/ person',
                                  style: AppTextStyles.bodySmall(isDark),
                                ),
                              ],
                            ),
                          ],
                        ),
                        if (package.hasDiscount)
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 6),
                            decoration: BoxDecoration(
                              color: Colors.green.withAlpha(25),
                              borderRadius: AppRadius.radiusSm,
                            ),
                            child: Column(
                              children: [
                                Text(
                                  '₹${package.originalPrice!.toStringAsFixed(0)}',
                                  style: TextStyle(
                                    fontSize: 11,
                                    decoration: TextDecoration.lineThrough,
                                    color: isDark
                                        ? AppColors.textMutedDark
                                        : AppColors.textMutedLight,
                                  ),
                                ),
                                Text(
                                  '${package.discountPercentage}% OFF',
                                  style: const TextStyle(
                                    color: Colors.green,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                  AppSpacing.gapV20,

                  // Trip Highlights Chips
                  if (package.highlights.isNotEmpty) ...[
                    Text(
                      'Trip Highlights',
                      style: AppTextStyles.titleMedium(isDark).copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    AppSpacing.gapV8,
                    ...package.highlights.map((hl) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 6),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('✨ ', style: TextStyle(fontSize: 14)),
                            Expanded(
                              child: Text(
                                hl,
                                style: AppTextStyles.bodyMedium(isDark).copyWith(
                                  height: 1.35,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                    AppSpacing.gapV20,
                  ],

                  // About the Trip Narrative
                  Text(
                    'About This Journey',
                    style: AppTextStyles.titleMedium(isDark).copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  AppSpacing.gapV8,
                  Text(
                    package.description,
                    style: AppTextStyles.bodyMedium(isDark).copyWith(
                      height: 1.5,
                    ),
                  ),
                  AppSpacing.gapV24,

                  // Date Selection Section
                  Obx(() {
                    return TripDateSelector(
                      availableDates: package.availableDates,
                      selectedDate: controller.selectedDate.value,
                      onDateSelected: (date) => controller.selectDate(date),
                    );
                  }),
                  AppSpacing.gapV20,

                  // Traveler & Room Selection
                  Obx(() {
                    return TravelerSelector(
                      travelers: controller.travelers.value,
                      maxTravelers: package.maxTravelers,
                      minTravelers: package.minTravelers,
                      onChanged: (newTravelers) {
                        controller.updateTravelers(
                          adults: newTravelers.adults,
                          children: newTravelers.children,
                          rooms: newTravelers.rooms,
                        );
                      },
                    );
                  }),
                  AppSpacing.gapV24,

                  // Day-by-Day Itinerary Timeline
                  Obx(() {
                    return ItineraryTimeline(
                      itinerary: package.itinerary,
                      expandedDays: controller.expandedDays,
                      onToggleDay: (dayNum) =>
                          controller.toggleDayExpanded(dayNum),
                      onExpandAll: () => controller.expandAllDays(),
                      onCollapseAll: () => controller.collapseAllDays(),
                    );
                  }),
                  AppSpacing.gapV24,

                  // Inclusions & Exclusions
                  TripInclusionsWidget(inclusions: package.includedItems),
                  AppSpacing.gapV16,
                  TripExclusionsWidget(exclusions: package.excludedItems),
                  AppSpacing.gapV24,

                  // Cancellation Policy & Travel Notes
                  AppCard(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.security_update_good_rounded,
                                size: 18, color: AppColors.primary),
                            const SizedBox(width: 8),
                            Text(
                              'Cancellation & Booking Policy',
                              style: AppTextStyles.titleSmall(isDark).copyWith(
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                        AppSpacing.gapV8,
                        Text(
                          '• Free cancellation up to 7 days before departure date.\n• 50% refund between 3 to 7 days prior to start.\n• 24/7 dedicated support via phone & WhatsApp throughout your travel.\n• Instant booking confirmation voucher issued upon checkout.',
                          style: AppTextStyles.bodySmall(isDark).copyWith(
                            height: 1.45,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 100), // Padding for sticky bottom bar
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Obx(() {
        return TripBookingBottomBar(
          totalPrice: controller.grandTotal,
          pricePerPerson: controller.package.basePrice,
          travelerSummary: controller.travelers.value.travelerSummary,
          onBookNow: () => TripsNavigator.toTripCheckout(controller),
        );
      }),
    );
  }
}
