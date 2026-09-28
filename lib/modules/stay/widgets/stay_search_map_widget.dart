import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sewasetu/app/theme/app_colors.dart';
import 'package:sewasetu/app/theme/app_radius.dart';
import 'package:sewasetu/app/theme/app_shadows.dart';
import 'package:sewasetu/app/theme/app_spacing.dart';
import 'package:sewasetu/app/theme/app_text_styles.dart';
import 'package:sewasetu/core/utils/formatters.dart';
import 'package:sewasetu/modules/stay/controllers/search_controller.dart' as stay_search;
import 'package:sewasetu/modules/stay/widgets/property_card.dart';
import 'package:sewasetu/shared/enums/stay_type.dart';

/// Production-ready Interactive Map Section showing properties within 400m radius
class StaySearchMapWidget extends StatelessWidget {
  final stay_search.SearchController controller;

  const StaySearchMapWidget({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : Colors.white,
        borderRadius: AppRadius.radiusXl,
        boxShadow: AppShadows.md,
        border: Border.all(
          color: isDark ? AppColors.borderDark : AppColors.borderLight,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: (isDark ? AppColors.primaryLight : AppColors.primary).withAlpha(30),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.my_location_rounded,
                    size: 18,
                    color: isDark ? AppColors.primaryLight : AppColors.primary,
                  ),
                ),
                AppSpacing.gapH12,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Map View & Nearby Stays',
                        style: AppTextStyles.titleMedium(isDark).copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Obx(() {
                        final count400m = controller.propertiesWithin400m.length;
                        return Text(
                          '$count400m available within 400m radius of location',
                          style: AppTextStyles.bodySmall(isDark).copyWith(
                            color: isDark ? AppColors.textMutedDark : AppColors.textMutedLight,
                          ),
                        );
                      }),
                    ],
                  ),
                ),
                // Radius toggle chip
                Obx(() {
                  final is400mOnly = controller.is400mRadiusOnlyMap.value;
                  return InkWell(
                    onTap: controller.toggle400mRadiusOnlyMap,
                    borderRadius: AppRadius.radiusPill,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: is400mOnly
                            ? (isDark ? AppColors.primaryLight : AppColors.primary)
                            : (isDark ? AppColors.surfaceVariantDark : AppColors.surfaceVariantLight),
                        borderRadius: AppRadius.radiusPill,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            is400mOnly ? Icons.radar_rounded : Icons.map_rounded,
                            size: 13,
                            color: is400mOnly
                                ? (isDark ? Colors.black : Colors.white)
                                : (isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            is400mOnly ? '400m Radius' : 'All Map',
                            style: AppTextStyles.labelSmall(isDark).copyWith(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: is400mOnly
                                  ? (isDark ? Colors.black : Colors.white)
                                  : (isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),

          // Map Canvas Container
          SizedBox(
            height: 380,
            width: double.infinity,
            child: Obx(() {
              final activeStays = controller.is400mRadiusOnlyMap.value &&
                      controller.propertiesWithin400m.isNotEmpty
                  ? controller.propertiesWithin400m
                  : controller.searchResults;

              final selectedStay = controller.selectedMapProperty.value;
              final userLat = controller.userLatitude.value ?? 26.1557;
              final userLng = controller.userLongitude.value ?? 91.7088;

              return Stack(
                children: [
                  // Vector Custom Map Painter
                  Positioned.fill(
                    child: CustomPaint(
                      painter: _SearchMapCanvasPainter(
                        isDark: isDark,
                        userLat: userLat,
                        userLng: userLng,
                        showPrivacyCircle: true,
                      ),
                    ),
                  ),

                  // User Current Location Center Pin
                  const Center(
                    child: FractionalTranslation(
                      translation: Offset(0, -0.2),
                      child: _UserLocationPulsePin(),
                    ),
                  ),

                  // Empty State inside map if 400m has no stays
                  if (activeStays.isEmpty)
                    Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                        decoration: BoxDecoration(
                          color: (isDark ? AppColors.surfaceDark : Colors.white).withAlpha(240),
                          borderRadius: AppRadius.radiusLg,
                          boxShadow: AppShadows.md,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.location_off_rounded,
                              color: isDark ? AppColors.textMutedDark : AppColors.textMutedLight,
                              size: 28,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'No stays within 400m of this spot',
                              style: AppTextStyles.bodyMedium(isDark).copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Try expanding search or choosing another location.',
                              style: AppTextStyles.bodySmall(isDark),
                            ),
                            const SizedBox(height: 10),
                            ElevatedButton(
                              onPressed: () {
                                controller.is400mRadiusOnlyMap.value = false;
                                controller.loadAndFilterStays();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: isDark ? AppColors.primaryLight : AppColors.primary,
                                foregroundColor: isDark ? Colors.black : Colors.white,
                                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                                shape: RoundedRectangleBorder(
                                  borderRadius: AppRadius.radiusPill,
                                ),
                              ),
                              child: const Text('Show All Stays on Map', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),
                      ),
                    ),

                  // Geospatial Relative Price Markers
                  ...activeStays.map((stay) {
                    final isSelected = selectedStay?.id == stay.id;
                    final distMeters = controller.calculateDistanceFromUser(stay.latitude, stay.longitude);

                    // Geospatial Projection mapping relative lat/lng onto canvas percentages
                    // Center pin is at (0.5, 0.4). Max canvas radius represents ~600m
                    const double maxSpanDegrees = 0.0055; // ~550 meters
                    final deltaLat = stay.latitude - userLat;
                    final deltaLng = stay.longitude - userLng;

                    final double offsetX = (deltaLng / maxSpanDegrees).clamp(-0.42, 0.42);
                    final double offsetY = (-deltaLat / maxSpanDegrees).clamp(-0.35, 0.35);

                    final double leftPercent = 0.5 + offsetX;
                    final double topPercent = 0.4 + offsetY;

                    return Positioned(
                      left: MediaQuery.of(context).size.width * leftPercent - 35,
                      top: 380 * topPercent - 15,
                      child: GestureDetector(
                        onTap: () => controller.selectMapProperty(stay),
                        child: AnimatedScale(
                          scale: isSelected ? 1.15 : 1.0,
                          duration: const Duration(milliseconds: 200),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? (isDark ? AppColors.primaryLight : AppColors.primary)
                                  : (isDark ? AppColors.surfaceDark : Colors.white),
                              borderRadius: AppRadius.radiusPill,
                              boxShadow: isSelected ? AppShadows.floating : AppShadows.sm,
                              border: Border.all(
                                color: isSelected
                                    ? Colors.white
                                    : (isDark ? AppColors.borderDark : AppColors.borderLight),
                                width: isSelected ? 2.0 : 1.2,
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                if (distMeters <= 400.0) ...[
                                  Container(
                                    width: 6,
                                    height: 6,
                                    decoration: const BoxDecoration(
                                      color: Colors.greenAccent,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                ],
                                Text(
                                  AppFormatters.formatCurrency(
                                    stay.stayType == StayType.room || stay.stayType == StayType.pg
                                        ? stay.displayPricePerMonth
                                        : stay.pricePerNight,
                                  ),
                                  style: AppTextStyles.labelSmall(isDark).copyWith(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 11,
                                    color: isSelected
                                        ? (isDark ? Colors.black : Colors.white)
                                        : (isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }),

                  // Privacy Notice Overlay Tag (Top Left)
                  Positioned(
                    top: 12,
                    left: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: (isDark ? AppColors.surfaceDark : Colors.white).withAlpha(235),
                        borderRadius: AppRadius.radiusPill,
                        boxShadow: AppShadows.sm,
                        border: Border.all(
                          color: isDark ? AppColors.borderDark : AppColors.borderLight,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.shield_outlined,
                            size: 13,
                            color: isDark ? AppColors.primaryLight : AppColors.primary,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            '400m Privacy Radius Circle',
                            style: AppTextStyles.labelSmall(isDark).copyWith(
                              fontWeight: FontWeight.w700,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Bottom Selected Property Mini Card Overlay
                  if (selectedStay != null)
                    Positioned(
                      left: 12,
                      right: 12,
                      bottom: 12,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        child: StayCardWidget(
                          stay: selectedStay,
                          style: StayCardStyle.horizontal,
                          onTap: () => controller.openPropertyDetails(selectedStay),
                        ),
                      ),
                    ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}

/// Pulsing Pin indicator representing User Location on map
class _UserLocationPulsePin extends StatelessWidget {
  const _UserLocationPulsePin();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        color: AppColors.primary.withAlpha(40),
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.primary.withAlpha(120), width: 1.5),
      ),
      child: Center(
        child: Container(
          width: 12,
          height: 12,
          decoration: const BoxDecoration(
            color: AppColors.primary,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 4,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Custom Vector Canvas Painter for Map Background with 400m Privacy Radius Circle
class _SearchMapCanvasPainter extends CustomPainter {
  final bool isDark;
  final double userLat;
  final double userLng;
  final bool showPrivacyCircle;

  _SearchMapCanvasPainter({
    required this.isDark,
    required this.userLat,
    required this.userLng,
    required this.showPrivacyCircle,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // 1. Landmass Background
    final bgPaint = Paint()..color = isDark ? const Color(0xFF1E293B) : const Color(0xFFF1F5F9);
    canvas.drawRect(Offset.zero & size, bgPaint);

    // 2. City River / Lake Curved Water Path
    final waterPaint = Paint()..color = isDark ? const Color(0xFF0F172A) : const Color(0xFFE2E8F0);
    final waterPath = Path()
      ..moveTo(0, size.height * 0.25)
      ..cubicTo(
        size.width * 0.35,
        size.height * 0.15,
        size.width * 0.65,
        size.height * 0.35,
        size.width,
        size.height * 0.28,
      )
      ..lineTo(size.width, size.height * 0.38)
      ..cubicTo(
        size.width * 0.65,
        size.height * 0.45,
        size.width * 0.35,
        size.height * 0.25,
        0,
        size.height * 0.35,
      )
      ..close();
    canvas.drawPath(waterPath, waterPaint);

    // 3. Grid / Road Networks
    final roadPaint = Paint()
      ..color = isDark ? const Color(0xFF334155) : Colors.white
      ..strokeWidth = 3.5
      ..style = PaintingStyle.stroke;

    canvas.drawLine(Offset(0, size.height * 0.18), Offset(size.width, size.height * 0.18), roadPaint);
    canvas.drawLine(Offset(0, size.height * 0.58), Offset(size.width, size.height * 0.58), roadPaint);
    canvas.drawLine(Offset(0, size.height * 0.76), Offset(size.width, size.height * 0.76), roadPaint);

    canvas.drawLine(Offset(size.width * 0.22, 0), Offset(size.width * 0.22, size.height), roadPaint);
    canvas.drawLine(Offset(size.width * 0.50, 0), Offset(size.width * 0.50, size.height), roadPaint);
    canvas.drawLine(Offset(size.width * 0.78, 0), Offset(size.width * 0.78, size.height), roadPaint);

    // 4. 400 Meter Radius Circle centered around User Location (0.5, 0.4)
    if (showPrivacyCircle) {
      final center = Offset(size.width * 0.5, size.height * 0.4);
      const double radiusPx = 80.0; // Scaled ~400 meter radius on map canvas

      final fillPaint = Paint()
        ..color = (isDark ? AppColors.primaryLight : AppColors.primary).withAlpha(30)
        ..style = PaintingStyle.fill;

      final borderPaint = Paint()
        ..color = (isDark ? AppColors.primaryLight : AppColors.primary).withAlpha(140)
        ..strokeWidth = 2.0
        ..style = PaintingStyle.stroke;

      canvas.drawCircle(center, radiusPx, fillPaint);
      canvas.drawCircle(center, radiusPx, borderPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _SearchMapCanvasPainter oldDelegate) {
    return oldDelegate.isDark != isDark ||
        oldDelegate.userLat != userLat ||
        oldDelegate.userLng != userLng ||
        oldDelegate.showPrivacyCircle != showPrivacyCircle;
  }
}

