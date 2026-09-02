import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sewasetu/app/routes/app_routes.dart';
import 'package:sewasetu/app/theme/app_colors.dart';
import 'package:sewasetu/app/theme/app_spacing.dart';
import 'package:sewasetu/app/theme/app_text_styles.dart';
import 'package:sewasetu/modules/stay/controllers/property_details_controller.dart';
import 'package:sewasetu/modules/stay/widgets/all_amenities_modal.dart';
import 'package:sewasetu/modules/stay/widgets/all_reviews_modal.dart';
import 'package:sewasetu/modules/stay/widgets/amenities_grid_widget.dart';
import 'package:sewasetu/modules/stay/widgets/host_profile_card_widget.dart';
import 'package:sewasetu/modules/stay/widgets/location_map_preview_widget.dart';
import 'package:sewasetu/modules/stay/widgets/property_image_gallery.dart';
import 'package:sewasetu/modules/stay/widgets/reviews_breakdown_widget.dart';
import 'package:sewasetu/modules/stay/widgets/review_item_widget.dart';
import 'package:sewasetu/modules/stay/widgets/room_options_selector_widget.dart';
import 'package:sewasetu/modules/stay/widgets/similar_properties_widget.dart';
import 'package:sewasetu/modules/stay/widgets/sticky_booking_bar_widget.dart';
import 'package:sewasetu/shared/enums/view_state.dart';
import 'package:sewasetu/shared/widgets/app_badge.dart';
import 'package:sewasetu/shared/widgets/app_empty_state.dart';
import 'package:sewasetu/shared/widgets/app_skeleton.dart';

/// Comprehensive Property Details Experience with Rooms, Amenities, Reviews Breakdown and 400m Privacy Map
class PropertyDetailsScreen extends GetView<PropertyDetailsController> {
  const PropertyDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Obx(() {
        switch (controller.state.value) {
          case ViewState.loading:
            return Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              child: const StayCardSkeleton(),
            );
          case ViewState.error:
            return AppEmptyState(
              icon: Icons.error_outline_rounded,
              title: 'Failed to load details',
              description: 'We could not retrieve property details. Please try again.',
              actionText: 'Retry',
              onAction: () => controller.loadDetails(Get.arguments as String? ?? 'stay-1'),
            );
          case ViewState.empty:
          case ViewState.initial:
          case ViewState.loaded:
            final stay = controller.stay.value;
            if (stay == null) {
              return const Center(child: CircularProgressIndicator());
            }

            final selectedRoom = controller.availableRooms.firstWhere(
              (r) => r.id == controller.selectedRoomId.value,
              orElse: () => controller.availableRooms.first,
            );

            return Stack(
              children: [
                // Scrollable Content
                SingleChildScrollView(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).padding.bottom + 90,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 1. Large Image Gallery with Hero and Full-Screen Tap
                      GestureDetector(
                        onTap: () => controller.openGallery(0),
                        child: PropertyImageGallery(
                          heroTag: 'stay-img-${stay.id}',
                          images: stay.images,
                          isFavorite: controller.isFavorite.value,
                          onFavoriteTap: controller.toggleFavorite,
                        ),
                      ),

                      Padding(
                        padding: AppSpacing.screenPadding,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // 2. Category & Verified Badge
                            Row(
                              children: [
                                AppBadge(
                                  text: '${stay.stayType.emoji} ${stay.stayType.label}',
                                  backgroundColor: isDark ? AppColors.surfaceVariantDark : AppColors.primaryContainer,
                                  textColor: isDark ? AppColors.primaryLight : AppColors.primary,
                                ),
                                if (stay.isVerified) ...[
                                  const SizedBox(width: 8),
                                  const AppBadge.verified(),
                                ],
                              ],
                            ),
                            AppSpacing.gapV12,

                            // 3. Property Title
                            Text(
                              stay.title,
                              style: AppTextStyles.headlineMedium(isDark).copyWith(
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            AppSpacing.gapV8,

                            // 4. Location & Rating Subtitle
                            Row(
                              children: [
                                const Icon(Icons.star_rounded, size: 18, color: AppColors.starGold),
                                const SizedBox(width: 4),
                                Text(
                                  '${stay.rating} (${stay.reviewsCount} reviews)',
                                  style: AppTextStyles.titleSmall(isDark).copyWith(
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                const Text('•'),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    stay.city,
                                    style: AppTextStyles.bodyMedium(isDark),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            AppSpacing.gapV16,
                            const Divider(height: 1),
                            AppSpacing.gapV16,

                            // 5. Host Information Card
                            HostProfileCardWidget(
                              host: stay.host,
                              onContactTap: () {
                                Get.snackbar(
                                  'Host Contacted',
                                  'Message sent to ${stay.host.name}. Average response time: 10 mins.',
                                  snackPosition: SnackPosition.BOTTOM,
                                );
                              },
                            ),
                            AppSpacing.gapV24,

                            // 6. About Description
                            Text(
                              'About this place',
                              style: AppTextStyles.headlineSmall(isDark).copyWith(
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            AppSpacing.gapV8,
                            Text(
                              stay.description,
                              style: AppTextStyles.bodyLarge(isDark).copyWith(
                                color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                                height: 1.6,
                              ),
                            ),
                            AppSpacing.gapV24,
                            const Divider(height: 1),
                            AppSpacing.gapV24,

                            // 7. Room Configurations Selector
                            if (controller.availableRooms.isNotEmpty) ...[
                              Obx(() {
                                return RoomOptionsSelectorWidget(
                                  rooms: controller.availableRooms,
                                  selectedRoomId: controller.selectedRoomId.value,
                                  onRoomSelected: controller.selectRoom,
                                );
                              }),
                              AppSpacing.gapV24,
                              const Divider(height: 1),
                              AppSpacing.gapV24,
                            ],

                            // 8. Amenities Section with Full Modal Trigger
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Amenities Offered',
                                  style: AppTextStyles.headlineSmall(isDark).copyWith(
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () => AllAmenitiesModal.show(
                                    context,
                                    amenities: stay.amenities,
                                  ),
                                  child: Text(
                                    'View all',
                                    style: AppTextStyles.labelMedium(isDark).copyWith(
                                      color: isDark ? AppColors.primaryLight : AppColors.primary,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            AppSpacing.gapV12,
                            AmenitiesGridWidget(amenities: stay.amenities),
                            AppSpacing.gapV24,
                            const Divider(height: 1),
                            AppSpacing.gapV24,

                            // 9. Location with 400m Privacy Radius
                            Text(
                              'Location & Neighborhood',
                              style: AppTextStyles.headlineSmall(isDark).copyWith(
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            AppSpacing.gapV12,
                            LocationMapPreviewWidget(
                              address: stay.address,
                              city: stay.city,
                              distanceText: stay.distanceText,
                            ),
                            AppSpacing.gapV24,
                            const Divider(height: 1),
                            AppSpacing.gapV24,

                            // 10. Reviews Breakdown (6 Dimensions)
                            ReviewsBreakdownWidget(
                              overallRating: stay.rating,
                              totalReviews: stay.reviewsCount,
                            ),
                            AppSpacing.gapV16,

                            // Top 2 Guest Reviews
                            ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: controller.reviews.take(2).length,
                              separatorBuilder: (context, index) => AppSpacing.gapV12,
                              itemBuilder: (context, index) {
                                return ReviewItemWidget(review: controller.reviews[index]);
                              },
                            ),
                            AppSpacing.gapV12,

                            // "Show all reviews" Button
                            OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                minimumSize: const Size(double.infinity, 44),
                              ),
                              onPressed: () => AllReviewsModal.show(
                                context,
                                reviews: controller.reviews,
                                rating: stay.rating,
                              ),
                              child: Text('Show all ${controller.reviews.length} reviews'),
                            ),
                            AppSpacing.gapV24,
                            const Divider(height: 1),
                            AppSpacing.gapV24,

                            // 11. Similar Accommodations Carousel
                            SimilarPropertiesWidget(
                              similarStays: controller.similarStays,
                              onStayTap: (simStay) => Get.toNamed(
                                AppRoutes.stayDetails,
                                arguments: simStay.id,
                                preventDuplicates: false,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Sticky Bottom Booking Bar with Selected Room Price
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: StickyBookingBarWidget(
                    pricePerNight: selectedRoom.pricePerNight,
                    pricePerMonth: stay.pricePerMonth,
                    isBooking: false,
                    onBookNow: controller.initiateBooking,
                  ),
                ),
              ],
            );
        }
      }),
    );
  }
}

typedef PropertyDetailsPage = PropertyDetailsScreen;
