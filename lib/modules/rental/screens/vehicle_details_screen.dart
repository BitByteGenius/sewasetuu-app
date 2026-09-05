import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_radius.dart';
import '../../../app/theme/app_shadows.dart';
import '../../../app/theme/app_spacing.dart';
import '../../../app/theme/app_text_styles.dart';
import '../bindings/rental_binding.dart';
import '../bindings/vehicle_details_binding.dart';
import '../controllers/rental_search_controller.dart';
import '../controllers/vehicle_details_controller.dart';
import '../models/vehicle_model.dart';
import '../widgets/rental_loading_skeleton.dart';
import '../widgets/vehicle_features_widget.dart';
import '../widgets/vehicle_image_gallery.dart';
import '../widgets/vehicle_price_widget.dart';
import '../widgets/vehicle_specifications_widget.dart';
import 'rental_booking_screen.dart';

/// Flagship vehicle overview screen with specs, interactive gallery, variants, and sticky checkout CTA.
class VehicleDetailsScreen extends StatelessWidget {
  const VehicleDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    RentalBinding.ensureInitialized();
    if (!Get.isRegistered<VehicleDetailsController>()) {
      VehicleDetailsBinding().dependencies();
    }

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final detailsCtrl = Get.find<VehicleDetailsController>();
    final searchCtrl = Get.isRegistered<RentalSearchController>()
        ? Get.find<RentalSearchController>()
        : null;

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      body: Obx(() {
        final vehicle = detailsCtrl.vehicle.value;
        if (vehicle == null && detailsCtrl.isLoading.value) {
          return const SafeArea(child: RentalDetailsSkeleton());
        }

        if (vehicle == null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Vehicle information unavailable.'),
                const SizedBox(height: AppSpacing.md),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Back to catalog'),
                ),
              ],
            ),
          );
        }

        return Column(
          children: [
            // Scrollable Content
            Expanded(
              child: CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  // 1. Gallery
                  SliverToBoxAdapter(
                    child: VehicleImageGallery(vehicle: vehicle),
                  ),

                  // 2. Identity, Pricing, Specs
                  SliverPadding(
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate([
                        // Category & Year
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                  decoration: BoxDecoration(
                                    color: AppColors.primary.withAlpha((255 * 0.12).round()),
                                    borderRadius: AppRadius.radiusXs,
                                  ),
                                  child: Text(
                                    vehicle.category.toUpperCase(),
                                    style: const TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w800,
                                      letterSpacing: 0.6,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: AppSpacing.sm),
                                Text(
                                  '${vehicle.year} Model',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: isDark ? AppColors.textMutedDark : AppColors.textSecondaryLight,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(Icons.star_rounded, size: 18, color: AppColors.secondary),
                                const SizedBox(width: 2),
                                Text(
                                  vehicle.rating.toStringAsFixed(1),
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w800,
                                    color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                                  ),
                                ),
                                if (vehicle.reviewCount > 0)
                                  Text(
                                    ' (${vehicle.reviewCount} reviews)',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: isDark ? AppColors.textMutedDark : AppColors.textMutedLight,
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        ),

                        const SizedBox(height: AppSpacing.xs),

                        // Title
                        Text(
                          vehicle.fullName,
                          style: AppTextStyles.displaySmall(isDark).copyWith(
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                          ),
                        ),

                        if (vehicle.model.isNotEmpty) ...[
                          const SizedBox(height: 2),
                          Text(
                            vehicle.model,
                            style: TextStyle(
                              fontSize: 13,
                              color: isDark ? AppColors.textMutedDark : AppColors.textSecondaryLight,
                            ),
                          ),
                        ],

                        const SizedBox(height: AppSpacing.lg),

                        // Pricing & Policies Tile
                        VehiclePriceWidget(vehicle: vehicle),

                        const SizedBox(height: AppSpacing.lg),

                        // Color / Trim Variants (if applicable)
                        if (vehicle.variants.isNotEmpty) ...[
                          Text(
                            'AVAILABLE COLOR / TRIM VARIANTS',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 0.7,
                              color: isDark ? AppColors.textMutedDark : AppColors.textSecondaryLight,
                            ),
                          ),
                          const SizedBox(height: AppSpacing.sm),
                          Obx(() {
                            final selVar = detailsCtrl.selectedVariant.value;
                            return Wrap(
                              spacing: AppSpacing.sm,
                              children: vehicle.variants.map((variant) {
                                final isSelected = selVar?.id == variant.id;
                                return ChoiceChip(
                                  label: Text('${variant.color} (${variant.transmission})'),
                                  selected: isSelected,
                                  selectedColor: AppColors.primary,
                                  backgroundColor: isDark ? AppColors.surfaceDark : AppColors.surfaceVariantLight,
                                  labelStyle: TextStyle(
                                    fontSize: 12,
                                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                                    color: isSelected ? Colors.white : null,
                                  ),
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: AppRadius.radiusFull,
                                  ),
                                  onSelected: (_) => detailsCtrl.selectVariant(variant),
                                );
                              }).toList(),
                            );
                          }),
                          const SizedBox(height: AppSpacing.lg),
                        ],

                        // Vehicle Description
                        Text(
                          'ABOUT THIS RIDE',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.7,
                            color: isDark ? AppColors.textMutedDark : AppColors.textSecondaryLight,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        Text(
                          vehicle.description,
                          style: AppTextStyles.bodyMedium(isDark).copyWith(
                            height: 1.5,
                            color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                          ),
                        ),

                        const SizedBox(height: AppSpacing.xl),

                        // Section Tabs: Specs vs Features vs Reviews
                        Obx(() {
                          final currentTab = detailsCtrl.activeTabIndex.value;
                          return Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: isDark ? AppColors.surfaceDark : AppColors.surfaceVariantLight,
                              borderRadius: AppRadius.radiusFull,
                              border: Border.all(
                                color: isDark ? AppColors.borderDark : AppColors.borderLight,
                              ),
                            ),
                            child: Row(
                              children: [
                                _buildTabButton(0, 'Specs', currentTab == 0),
                                _buildTabButton(1, 'Features', currentTab == 1),
                                _buildTabButton(
                                  2,
                                  'Reviews (${detailsCtrl.reviews.length})',
                                  currentTab == 2,
                                ),
                              ],
                            ),
                          );
                        }),

                        const SizedBox(height: AppSpacing.md),

                        // Tab Content
                        Obx(() {
                          final currentTab = detailsCtrl.activeTabIndex.value;

                          if (currentTab == 0) {
                            return VehicleSpecificationsWidget(vehicle: vehicle);
                          } else if (currentTab == 1) {
                            return VehicleFeaturesWidget(vehicle: vehicle);
                          } else {
                            return _buildReviewsList(isDark, detailsCtrl);
                          }
                        }),

                        const SizedBox(height: AppSpacing.xl),

                        // Rental Requirements Checklist
                        _buildRentalPolicies(isDark),

                        const SizedBox(height: AppSpacing.xxl),
                      ]),
                    ),
                  ),
                ],
              ),
            ),

            // Sticky Bottom Booking Bar
            _buildStickyBookingBar(context, isDark, vehicle, detailsCtrl, searchCtrl),
          ],
        );
      }),
    );
  }

  Widget _buildTabButton(int index, String label, bool isSelected) {
    final detailsCtrl = Get.find<VehicleDetailsController>();
    return Expanded(
      child: InkWell(
        onTap: () => detailsCtrl.setTab(index),
        borderRadius: AppRadius.radiusFull,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : Colors.transparent,
            borderRadius: AppRadius.radiusFull,
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
              color: isSelected ? Colors.white : null,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildReviewsList(bool isDark, VehicleDetailsController ctrl) {
    if (ctrl.reviews.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: AppSpacing.lg),
        child: Center(child: Text('No reviews yet for this vehicle.')),
      );
    }

    return Column(
      children: ctrl.reviews.map((r) {
        return Container(
          margin: const EdgeInsets.only(bottom: AppSpacing.sm),
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: isDark ? AppColors.surfaceDark : AppColors.surfaceVariantLight,
            borderRadius: AppRadius.radiusLg,
            border: Border.all(
              color: isDark ? AppColors.borderDark : AppColors.borderLight,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 14,
                        backgroundColor: AppColors.primary.withAlpha((255 * 0.2).round()),
                        child: Text(
                          r.userName.substring(0, 1).toUpperCase(),
                          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 11),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            r.userName,
                            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
                          ),
                          const Text(
                            'Verified Driver',
                            style: TextStyle(color: AppColors.success, fontSize: 10),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.star_rounded, size: 16, color: AppColors.secondary),
                      Text(
                        r.rating.toStringAsFixed(1),
                        style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                r.comment,
                style: TextStyle(
                  fontSize: 12,
                  height: 1.4,
                  color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildRentalPolicies(bool isDark) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: (isDark ? AppColors.surfaceVariantDark : AppColors.primaryContainer)
            .withAlpha((255 * 0.4).round()),
        borderRadius: AppRadius.radiusLg,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.assignment_turned_in_outlined, size: 18, color: AppColors.primary),
              const SizedBox(width: AppSpacing.sm),
              Text(
                'BOOKING REQUIREMENTS',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.7,
                  color: isDark ? AppColors.primaryLight : AppColors.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          _buildBullet(isDark, 'Original Driving License required at pickup.'),
          _buildBullet(isDark, 'Government Photo ID (Aadhaar or Passport).'),
          _buildBullet(isDark, 'Fuel: Same-to-same policy on return.'),
          _buildBullet(isDark, 'Tolls & State Border permits to be paid directly.'),
        ],
      ),
    );
  }

  Widget _buildBullet(bool isDark, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('• ', style: TextStyle(color: isDark ? Colors.white70 : Colors.black87)),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 12,
                color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStickyBookingBar(
    BuildContext context,
    bool isDark,
    VehicleModel vehicle,
    VehicleDetailsController detailsCtrl,
    RentalSearchController? searchCtrl,
  ) {
    final estimatedPricing = detailsCtrl.estimatedPricing;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.md,
      ),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
        boxShadow: AppShadows.floating,
        border: Border(
          top: BorderSide(
            color: isDark ? AppColors.borderDark : AppColors.borderLight,
          ),
        ),
      ),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${estimatedPricing.durationDays} ${estimatedPricing.durationDays == 1 ? "day" : "days"} estimate',
                  style: TextStyle(
                    fontSize: 11,
                    color: isDark ? AppColors.textMutedDark : AppColors.textSecondaryLight,
                  ),
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '₹${estimatedPricing.rentalCost.toInt()}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                          color: AppColors.primary,
                        ),
                      ),
                      TextSpan(
                        text: ' base',
                        style: TextStyle(
                          fontSize: 11,
                          color: isDark ? AppColors.textMutedDark : AppColors.textSecondaryLight,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                Get.to(
                  () => const RentalBookingScreen(),
                  arguments: {
                    'vehicle': vehicle,
                    'search': searchCtrl?.searchModel.value,
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.xxl,
                  vertical: AppSpacing.md,
                ),
                shape: const RoundedRectangleBorder(
                  borderRadius: AppRadius.radiusFull,
                ),
                elevation: 0,
              ),
              child: const Row(
                children: [
                  Text(
                    'Continue to Book',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(width: 6),
                  Icon(Icons.arrow_forward_rounded, size: 16),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
