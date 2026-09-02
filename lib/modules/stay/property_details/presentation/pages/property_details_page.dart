import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sewasetu/app/theme/app_colors.dart';
import 'package:sewasetu/app/theme/app_spacing.dart';
import 'package:sewasetu/app/theme/app_text_styles.dart';
import 'package:sewasetu/shared/enums/view_state.dart';
import 'package:sewasetu/shared/widgets/app_badge.dart';
import 'package:sewasetu/shared/widgets/app_empty_state.dart';
import 'package:sewasetu/shared/widgets/app_loader.dart';
import 'package:sewasetu/shared/widgets/app_rating_bar.dart';
import 'package:sewasetu/modules/stay/review/presentation/widgets/review_item_widget.dart';
import 'package:sewasetu/modules/stay/property_details/presentation/controllers/property_details_controller.dart';
import 'package:sewasetu/modules/stay/property_details/presentation/widgets/amenities_grid_widget.dart';
import 'package:sewasetu/modules/stay/property_details/presentation/widgets/host_profile_card_widget.dart';
import 'package:sewasetu/modules/stay/property_details/presentation/widgets/location_map_preview_widget.dart';
import 'package:sewasetu/modules/stay/property_details/presentation/widgets/property_image_gallery.dart';
import 'package:sewasetu/modules/stay/property_details/presentation/widgets/sticky_booking_bar_widget.dart';

/// Property Details Page displaying photos, host, amenities, map, reviews, and booking bar.
class PropertyDetailsPage extends GetView<PropertyDetailsController> {
  const PropertyDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Obx(() {
        switch (controller.state.value) {
          case ViewState.loading:
            return const Center(child: AppLoader(message: 'Loading property details...'));
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
              return const Center(child: AppLoader());
            }

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
                      // Image Carousel with Hero tag
                      PropertyImageGallery(
                        heroTag: 'stay-img-${stay.id}',
                        images: stay.images,
                        isFavorite: controller.isFavorite.value,
                        onFavoriteTap: controller.toggleFavorite,
                      ),
                      Padding(
                        padding: AppSpacing.screenPadding,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Category & Verified Badge
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
                            // Title
                            Text(
                              stay.title,
                              style: AppTextStyles.headlineMedium(isDark).copyWith(
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            AppSpacing.gapV8,
                            // Rating and Reviews
                            Row(
                              children: [
                                AppRatingBar(
                                  rating: stay.rating,
                                  reviewsCount: stay.reviewsCount,
                                  iconSize: 16,
                                ),
                                const SizedBox(width: 8),
                                const Text('•'),
                                const SizedBox(width: 8),
                                Text(
                                  stay.roomConfiguration,
                                  style: AppTextStyles.bodyMedium(isDark).copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            AppSpacing.gapV16,
                            const Divider(height: 1),
                            AppSpacing.gapV16,

                            // Host Card
                            HostProfileCardWidget(host: stay.host),

                            AppSpacing.gapV24,
                            // Description Section
                            Text(
                              'About this space',
                              style: AppTextStyles.headlineSmall(isDark),
                            ),
                            AppSpacing.gapV8,
                            Text(
                              stay.description,
                              style: AppTextStyles.bodyLarge(isDark).copyWith(
                                color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                              ),
                            ),

                            AppSpacing.gapV24,
                            const Divider(height: 1),
                            AppSpacing.gapV24,

                            // Amenities Section
                            Text(
                              'What this place offers',
                              style: AppTextStyles.headlineSmall(isDark),
                            ),
                            AppSpacing.gapV12,
                            AmenitiesGridWidget(amenities: stay.amenities),

                            AppSpacing.gapV24,
                            const Divider(height: 1),
                            AppSpacing.gapV24,

                            // Location Section
                            Text(
                              'Where you’ll be',
                              style: AppTextStyles.headlineSmall(isDark),
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

                            // Reviews Section
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Guest Reviews',
                                  style: AppTextStyles.headlineSmall(isDark),
                                ),
                                AppRatingBar(
                                  rating: stay.rating,
                                  reviewsCount: stay.reviewsCount,
                                ),
                              ],
                            ),
                            AppSpacing.gapV16,
                            ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: controller.reviews.length,
                              separatorBuilder: (context, index) => AppSpacing.gapV12,
                              itemBuilder: (context, index) {
                                return ReviewItemWidget(review: controller.reviews[index]);
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Sticky Bottom Booking Bar
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: StickyBookingBarWidget(
                    pricePerNight: stay.pricePerNight,
                    pricePerMonth: stay.pricePerMonth,
                    isBooking: controller.isBooking.value,
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
