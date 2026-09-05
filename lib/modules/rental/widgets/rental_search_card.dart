import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_radius.dart';
import '../../../app/theme/app_shadows.dart';
import '../../../app/theme/app_spacing.dart';
import '../../../app/theme/app_text_styles.dart';
import '../bindings/rental_binding.dart';
import '../controllers/rental_city_controller.dart';
import '../controllers/rental_search_controller.dart';
import '../screens/cities_screen.dart';
import '../screens/vehicle_list_screen.dart';

/// Visually strong, interactive search card for selecting city, dates, times, and hubs.
class RentalSearchCard extends StatelessWidget {
  const RentalSearchCard({super.key});

  Future<void> _pickDateTime(BuildContext context, bool isPickup) async {
    RentalBinding.ensureInitialized();
    final searchCtrl = Get.find<RentalSearchController>();
    final initialDate = isPickup ? searchCtrl.pickupDate.value : searchCtrl.returnDate.value;
    final initialTime = isPickup ? searchCtrl.pickupTime.value : searchCtrl.returnTime.value;

    final pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: isPickup ? DateTime.now() : searchCtrl.pickupDate.value,
      lastDate: DateTime.now().add(const Duration(days: 90)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.fromSeed(
              seedColor: AppColors.primary,
              primary: AppColors.primary,
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate == null || !context.mounted) return;

    final pickedTime = await showTimePicker(
      context: context,
      initialTime: initialTime,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.fromSeed(
              seedColor: AppColors.primary,
              primary: AppColors.primary,
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedTime == null) return;

    if (isPickup) {
      searchCtrl.updatePickupDateTime(pickedDate, pickedTime);
    } else {
      searchCtrl.updateReturnDateTime(pickedDate, pickedTime);
    }
  }

  @override
  Widget build(BuildContext context) {
    RentalBinding.ensureInitialized();
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final searchCtrl = Get.find<RentalSearchController>();
    final cityCtrl = Get.find<RentalCityController>();

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
        borderRadius: AppRadius.radiusXl,
        boxShadow: AppShadows.floating,
        border: Border.all(
          color: isDark ? AppColors.borderDark : AppColors.borderLight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 1. City Tile
          Obx(() {
            final city = cityCtrl.selectedCity.value;
            return InkWell(
              onTap: () => Get.to(() => const CitiesScreen()),
              borderRadius: AppRadius.radiusLg,
              child: Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: isDark ? AppColors.surfaceVariantDark : AppColors.surfaceVariantLight,
                  borderRadius: AppRadius.radiusLg,
                  border: Border.all(
                    color: isDark ? AppColors.borderDark : AppColors.borderLight,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(AppSpacing.sm),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withAlpha((255 * 0.12).round()),
                        borderRadius: AppRadius.radiusMd,
                      ),
                      child: const Icon(
                        Icons.location_city,
                        color: AppColors.primary,
                        size: 22,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'RENTAL LOCATION / CITY',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.6,
                              color: isDark ? AppColors.textMutedDark : AppColors.textSecondaryLight,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            city != null ? city.displayName : 'Select City',
                            style: AppTextStyles.titleMedium(isDark).copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: AppRadius.radiusFull,
                      ),
                      child: const Text(
                        'Change',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),

          const SizedBox(height: AppSpacing.md),

          // 2. Dates & Times Split Section
          Obx(() {
            return Row(
              children: [
                // Pickup Tile
                Expanded(
                  child: InkWell(
                    onTap: () => _pickDateTime(context, true),
                    borderRadius: AppRadius.radiusLg,
                    child: Container(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      decoration: BoxDecoration(
                        color: isDark ? AppColors.surfaceVariantDark : AppColors.surfaceVariantLight,
                        borderRadius: AppRadius.radiusLg,
                        border: Border.all(
                          color: isDark ? AppColors.borderDark : AppColors.borderLight,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.flight_land, size: 14, color: AppColors.primary),
                              const SizedBox(width: 4),
                              Text(
                                'PICKUP',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                  color: isDark ? AppColors.textMutedDark : AppColors.textSecondaryLight,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            searchCtrl.formattedPickup,
                            style: AppTextStyles.titleMedium(isDark).copyWith(
                              fontWeight: FontWeight.w700,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: AppSpacing.sm),

                // Return Tile
                Expanded(
                  child: InkWell(
                    onTap: () => _pickDateTime(context, false),
                    borderRadius: AppRadius.radiusLg,
                    child: Container(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      decoration: BoxDecoration(
                        color: isDark ? AppColors.surfaceVariantDark : AppColors.surfaceVariantLight,
                        borderRadius: AppRadius.radiusLg,
                        border: Border.all(
                          color: isDark ? AppColors.borderDark : AppColors.borderLight,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.flight_takeoff, size: 14, color: AppColors.secondary),
                              const SizedBox(width: 4),
                              Text(
                                'RETURN',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                  color: isDark ? AppColors.textMutedDark : AppColors.textSecondaryLight,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            searchCtrl.formattedReturn,
                            style: AppTextStyles.titleMedium(isDark).copyWith(
                              fontWeight: FontWeight.w700,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          }),

          const SizedBox(height: AppSpacing.sm),

          // Duration Badge
          Obx(() {
            return Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
                decoration: BoxDecoration(
                  color: (isDark ? AppColors.surfaceVariantDark : AppColors.primaryContainer)
                      .withAlpha((255 * 0.7).round()),
                  borderRadius: AppRadius.radiusFull,
                ),
                child: Text(
                  'Duration: ${searchCtrl.durationString}',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: isDark ? AppColors.primaryLight : AppColors.primary,
                  ),
                ),
              ),
            );
          }),

          const SizedBox(height: AppSpacing.md),

          // 3. Primary CTA: Find Vehicles
          ElevatedButton(
            onPressed: () {
              if (searchCtrl.validateSearch()) {
                Get.to(() => const VehicleListScreen());
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.md + 2),
              shape: const RoundedRectangleBorder(
                borderRadius: AppRadius.radiusLg,
              ),
              elevation: 0,
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.search, size: 20),
                SizedBox(width: AppSpacing.sm),
                Text(
                  'Find Vehicles',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.2,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
