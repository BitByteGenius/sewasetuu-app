import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_radius.dart';
import '../../../app/theme/app_spacing.dart';
import '../../../app/theme/app_text_styles.dart';
import '../../../shared/widgets/app_bar/app_bar.dart';
import '../bindings/rental_binding.dart';
import '../controllers/rental_city_controller.dart';
import '../controllers/rental_search_controller.dart';
import '../models/vehicle_model.dart';
import '../widgets/rental_duration_selector.dart';
import 'cities_screen.dart';
import 'vehicle_list_screen.dart';

/// Full-screen search configuration screen for modifying dates, times, city, and vehicle types.
class RentalSearchScreen extends StatelessWidget {
  const RentalSearchScreen({super.key});

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

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      appBar: const SewaAppBar(
        titleText: 'Rental Schedule & Location',
        showBackButton: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. City Tile
            Text(
              'RENTAL CITY',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.7,
                color: isDark ? AppColors.textMutedDark : AppColors.textSecondaryLight,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Obx(() {
              final city = cityCtrl.selectedCity.value;
              return InkWell(
                onTap: () => Get.to(() => const CitiesScreen()),
                borderRadius: AppRadius.radiusLg,
                child: Container(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
                    borderRadius: AppRadius.radiusLg,
                    border: Border.all(
                      color: isDark ? AppColors.borderDark : AppColors.borderLight,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.location_city, color: AppColors.primary),
                          const SizedBox(width: AppSpacing.md),
                          Text(
                            city?.displayName ?? 'Select City',
                            style: AppTextStyles.titleMedium(isDark).copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      const Icon(Icons.chevron_right),
                    ],
                  ),
                ),
              );
            }),

            const SizedBox(height: AppSpacing.xl),

            // 2. Dates & Times
            Text(
              'PICKUP & RETURN SCHEDULE',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.7,
                color: isDark ? AppColors.textMutedDark : AppColors.textSecondaryLight,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),

            Obx(() {
              return Column(
                children: [
                  // Pickup row
                  InkWell(
                    onTap: () => _pickDateTime(context, true),
                    borderRadius: AppRadius.radiusLg,
                    child: Container(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      decoration: BoxDecoration(
                        color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
                        borderRadius: AppRadius.radiusLg,
                        border: Border.all(
                          color: isDark ? AppColors.borderDark : AppColors.borderLight,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Row(
                            children: [
                              Icon(Icons.flight_land, color: AppColors.primary, size: 20),
                              SizedBox(width: AppSpacing.sm),
                              Text('Pickup', style: TextStyle(fontWeight: FontWeight.w600)),
                            ],
                          ),
                          Text(
                            searchCtrl.formattedPickup,
                            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: AppSpacing.sm),

                  // Return row
                  InkWell(
                    onTap: () => _pickDateTime(context, false),
                    borderRadius: AppRadius.radiusLg,
                    child: Container(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      decoration: BoxDecoration(
                        color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
                        borderRadius: AppRadius.radiusLg,
                        border: Border.all(
                          color: isDark ? AppColors.borderDark : AppColors.borderLight,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Row(
                            children: [
                              Icon(Icons.flight_takeoff, color: AppColors.secondary, size: 20),
                              SizedBox(width: AppSpacing.sm),
                              Text('Return', style: TextStyle(fontWeight: FontWeight.w600)),
                            ],
                          ),
                          Text(
                            searchCtrl.formattedReturn,
                            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }),

            const SizedBox(height: AppSpacing.lg),

            // 3. Duration Presets
            const RentalDurationSelector(),

            const SizedBox(height: AppSpacing.xl),

            // 4. Vehicle Type Selection
            Text(
              'VEHICLE TYPE PREFERENCE',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.7,
                color: isDark ? AppColors.textMutedDark : AppColors.textSecondaryLight,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),

            Obx(() {
              final activeType = searchCtrl.selectedVehicleType.value;
              return Wrap(
                spacing: AppSpacing.sm,
                runSpacing: AppSpacing.sm,
                children: RentalVehicleType.values.map((t) {
                  final isSelected = activeType == t;
                  return ChoiceChip(
                    label: Text(t.label),
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
                    onSelected: (_) => searchCtrl.setVehicleType(t),
                  );
                }).toList(),
              );
            }),

            const SizedBox(height: AppSpacing.xxl),

            // 5. Apply Button
            ElevatedButton(
              onPressed: () {
                if (searchCtrl.validateSearch()) {
                  Get.to(() => const VehicleListScreen());
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                minimumSize: const Size.fromHeight(52),
                shape: const RoundedRectangleBorder(
                  borderRadius: AppRadius.radiusLg,
                ),
                elevation: 0,
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.search),
                  SizedBox(width: AppSpacing.sm),
                  Text(
                    'Search Available Rides',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
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
