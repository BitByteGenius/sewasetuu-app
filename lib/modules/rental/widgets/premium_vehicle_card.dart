import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_radius.dart';
import '../../../app/theme/app_shadows.dart';
import '../../../app/theme/app_spacing.dart';
import '../models/vehicle_model.dart';
import '../screens/vehicle_details_screen.dart';

/// Larger, visually immersive card designed for the Luxury & Premium Collection showcase.
class PremiumVehicleCard extends StatelessWidget {
  final VehicleModel vehicle;
  final double width;

  const PremiumVehicleCard({
    super.key,
    required this.vehicle,
    this.width = 290.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      margin: const EdgeInsets.only(right: AppSpacing.md, bottom: 4),
      decoration: BoxDecoration(
        color: const Color(0xFF131A26), // Premium automotive deep navy/slate
        borderRadius: AppRadius.radiusXl,
        boxShadow: AppShadows.floating,
        border: Border.all(
          color: const Color(0xFF2A364F),
          width: 1.2,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => Get.to(() => const VehicleDetailsScreen(), arguments: vehicle),
          borderRadius: AppRadius.radiusXl,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // 1. Vehicle Image Container
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(AppRadius.xl)),
                    child: SizedBox(
                      height: 145,
                      width: double.infinity,
                      child: CachedNetworkImage(
                        imageUrl: vehicle.primaryImage,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(color: Colors.black26),
                        errorWidget: (context, url, error) => Container(
                          color: Colors.black26,
                          child: const Icon(Icons.stars, color: Colors.white24, size: 40),
                        ),
                      ),
                    ),
                  ),

                  // Gradient
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    height: 50,
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Color(0xFF131A26),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Top Gold Badge
                  Positioned(
                    top: AppSpacing.sm,
                    left: AppSpacing.sm,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFFD97706), Color(0xFFF59E0B)],
                        ),
                        borderRadius: AppRadius.radiusXs,
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.diamond, size: 11, color: Colors.black),
                          SizedBox(width: 4),
                          Text(
                            'PREMIUM CLASS',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 9,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 0.8,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              // 2. Info Body
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.sm + 2,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          vehicle.brand.toUpperCase(),
                          style: const TextStyle(
                            color: Color(0xFF94A3B8),
                            fontSize: 10,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.8,
                          ),
                        ),
                        Row(
                          children: [
                            const Icon(Icons.star_rounded, size: 15, color: Color(0xFFF59E0B)),
                            const SizedBox(width: 2),
                            Text(
                              vehicle.rating.toStringAsFixed(1),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      vehicle.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${vehicle.transmission} • ${vehicle.fuelType} • ${vehicle.seats} Seats',
                      style: const TextStyle(
                        color: Color(0xFFCBD5E1),
                        fontSize: 11,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sm + 2),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: '₹${vehicle.pricePerDay.toInt()}',
                                    style: const TextStyle(
                                      color: Color(0xFF14B8A6),
                                      fontSize: 17,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  const TextSpan(
                                    text: ' / day',
                                    style: TextStyle(
                                      color: Color(0xFF94A3B8),
                                      fontSize: 11,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: AppColors.primaryLight,
                            borderRadius: AppRadius.radiusFull,
                          ),
                          child: const Text(
                            'Reserve',
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 11,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
