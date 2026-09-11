import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_radius.dart';
import '../../../app/theme/app_shadows.dart';
import '../../../app/theme/app_spacing.dart';
import '../../../app/theme/app_text_styles.dart';
import '../../../shared/widgets/app_bar/app_bar.dart';
import '../bindings/rental_binding.dart';
import '../controllers/rental_city_controller.dart';
import '../models/rental_city_model.dart';
import '../widgets/rental_loading_skeleton.dart';

/// Screen displaying Phase 1 active rental cities and upcoming expansion cities.
class CitiesScreen extends StatelessWidget {
  const CitiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    RentalBinding.ensureInitialized();
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cityCtrl = Get.find<RentalCityController>();

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      appBar: const SewaAppBar(
        titleText: 'Select Rental City',
        showBackButton: true,
      ),
      body: Column(
        children: [
          // 1. Search Bar
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.lg,
              vertical: AppSpacing.md,
            ),
            color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
            child: TextField(
              onChanged: cityCtrl.updateSearchQuery,
              decoration: InputDecoration(
                hintText: 'Search city or state...',
                hintStyle: TextStyle(
                  fontSize: 13,
                  color: isDark ? AppColors.textMutedDark : AppColors.textMutedLight,
                ),
                prefixIcon: const Icon(Icons.search, size: 20, color: AppColors.primary),
                filled: true,
                fillColor: isDark ? AppColors.surfaceVariantDark : AppColors.surfaceVariantLight,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                border: OutlineInputBorder(
                  borderRadius: AppRadius.radiusFull,
                  borderSide: BorderSide.none,
                ),
              ),
              style: AppTextStyles.bodyMedium(isDark),
            ),
          ),

          const Divider(height: 1),

          // 2. City Lists
          Expanded(
            child: Obx(() {
              if (cityCtrl.isLoading.value) {
                return ListView.builder(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  itemCount: 4,
                  itemBuilder: (_, __) => const RentalCityCardSkeleton(),
                );
              }

              final available = cityCtrl.availableCities;
              final comingSoon = cityCtrl.comingSoonCities;

              return ListView(
                padding: const EdgeInsets.all(AppSpacing.lg),
                children: [
                  // Available Cities Section
                  Row(
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: AppColors.success,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Text(
                        'AVAILABLE NOW (${available.length})',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.8,
                          color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.md),

                  if (available.isEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
                      child: Text(
                        'No available cities match your search.',
                        style: TextStyle(
                          fontSize: 13,
                          color: isDark ? AppColors.textMutedDark : AppColors.textSecondaryLight,
                        ),
                      ),
                    )
                  else
                    ...available.map((city) => _buildCityCard(context, city, true, isDark, cityCtrl)),

                  const SizedBox(height: AppSpacing.xl),

                  // Coming Soon Cities Section
                  Row(
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: AppColors.warning,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Text(
                        'COMING SOON IN PHASE 2',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.8,
                          color: isDark ? AppColors.textMutedDark : AppColors.textSecondaryLight,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.md),

                  ...comingSoon.map((city) => _buildCityCard(context, city, false, isDark, cityCtrl)),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildCityCard(
    BuildContext context,
    RentalCityModel city,
    bool isAvailable,
    bool isDark,
    RentalCityController ctrl,
  ) {
    final isSelected = ctrl.selectedCity.value?.id == city.id;

    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
        borderRadius: AppRadius.radiusLg,
        boxShadow: AppShadows.soft,
        border: Border.all(
          color: isSelected
              ? AppColors.primary
              : (isDark ? AppColors.borderDark : AppColors.borderLight),
          width: isSelected ? 2.0 : 1.0,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            final success = ctrl.selectCity(city);
            if (success) {
              Navigator.pop(context);
            }
          },
          borderRadius: AppRadius.radiusLg,
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Row(
              children: [
                // Thumbnail
                ClipRRect(
                  borderRadius: AppRadius.radiusMd,
                  child: SizedBox(
                    width: 75,
                    height: 75,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        CachedNetworkImage(
                          imageUrl: city.image,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Container(color: Colors.grey.shade900),
                          errorWidget: (context, url, error) => Container(
                            color: Colors.grey.shade900,
                            child: const Icon(Icons.location_city, color: Colors.white38),
                          ),
                        ),
                        if (!isAvailable)
                          Container(
                            color: Colors.black.withAlpha((255 * 0.4).round()),
                          ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(width: AppSpacing.md),

                // City details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            city.name,
                            style: AppTextStyles.titleMedium(isDark).copyWith(
                              fontWeight: FontWeight.w800,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(width: 6),
                          if (isSelected)
                            const Icon(
                              Icons.check_circle_rounded,
                              size: 16,
                              color: AppColors.primary,
                            ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Text(
                        city.state,
                        style: TextStyle(
                          fontSize: 12,
                          color: isDark ? AppColors.textMutedDark : AppColors.textSecondaryLight,
                        ),
                      ),
                      const SizedBox(height: 6),
                      if (isAvailable)
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: AppColors.successLight,
                                borderRadius: AppRadius.radiusXs,
                              ),
                              child: Text(
                                '${city.vehicleCount} Vehicles Available',
                                style: const TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF065F46),
                                ),
                              ),
                            ),
                          ],
                        )
                      else
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: AppColors.warningLight,
                                borderRadius: AppRadius.radiusXs,
                              ),
                              child: const Text(
                                'Coming Soon (Phase 2)',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF92400E),
                                ),
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),

                // Trailing Arrow or Selected Pill
                Icon(
                  isAvailable ? Icons.chevron_right_rounded : Icons.lock_clock_outlined,
                  color: isDark ? AppColors.textMutedDark : AppColors.textMutedLight,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
