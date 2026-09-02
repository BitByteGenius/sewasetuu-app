import 'package:flutter/material.dart';
import 'package:sewasetu/app/theme/app_colors.dart';
import 'package:sewasetu/app/theme/app_spacing.dart';
import 'package:sewasetu/app/theme/app_text_styles.dart';
import 'package:sewasetu/shared/widgets/app_button.dart';
import 'package:sewasetu/shared/widgets/app_card.dart';
import 'package:sewasetu/shared/widgets/app_network_image.dart';

class TripPackage {
  final String title;
  final String duration;
  final String priceText;
  final String imageUrl;
  final String highlights;

  const TripPackage({
    required this.title,
    required this.duration,
    required this.priceText,
    required this.imageUrl,
    required this.highlights,
  });
}

/// Secondary Module: Curated travel packages and destinations (Goa, Manali, Shillong, etc.).
class TripsScreen extends StatelessWidget {
  const TripsScreen({super.key});

  static const packages = [
    TripPackage(
      title: 'Meghalaya Cascades & Cloud Trail',
      duration: '4 Days / 3 Nights',
      priceText: '₹14,999 / person',
      imageUrl: 'https://images.unsplash.com/photo-1544735716-392fe2489ffa?auto=format&fit=crop&w=600&q=80',
      highlights: 'Shillong • Cherrapunjee • Dawki River • Living Root Bridge',
    ),
    TripPackage(
      title: 'Himalayan Snow Peaks & Solang Adventure',
      duration: '5 Days / 4 Nights',
      priceText: '₹18,500 / person',
      imageUrl: 'https://images.unsplash.com/photo-1605649487212-47bdab064df8?auto=format&fit=crop&w=600&q=80',
      highlights: 'Manali • Rohtang Pass • Solang Valley • Paragliding',
    ),
    TripPackage(
      title: 'Goa Coastal Sun & Island Cruise',
      duration: '4 Days / 3 Nights',
      priceText: '₹12,499 / person',
      imageUrl: 'https://images.unsplash.com/photo-1512343879784-a960bf40e7f2?auto=format&fit=crop&w=600&q=80',
      highlights: 'North & South Goa • Scuba Diving • Sunset Cruise • Beach Resort',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Curated Travel Journeys',
          style: AppTextStyles.headlineSmall(isDark),
        ),
      ),
      body: ListView.separated(
        padding: AppSpacing.screenPadding,
        itemCount: packages.length,
        separatorBuilder: (context, index) => AppSpacing.gapV16,
        itemBuilder: (context, index) {
          final pkg = packages[index];
          return AppCard(
            padding: EdgeInsets.zero,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppNetworkImage(
                  imageUrl: pkg.imageUrl,
                  height: 170,
                  width: double.infinity,
                ),
                Padding(
                  padding: AppSpacing.edgeInsetsLg,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            pkg.duration,
                            style: AppTextStyles.labelSmall(isDark).copyWith(
                              color: isDark ? AppColors.primaryLight : AppColors.primary,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            pkg.priceText,
                            style: AppTextStyles.priceTag(isDark, fontSize: 16),
                          ),
                        ],
                      ),
                      AppSpacing.gapV4,
                      Text(
                        pkg.title,
                        style: AppTextStyles.titleLarge(isDark).copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      AppSpacing.gapV4,
                      Text(
                        pkg.highlights,
                        style: AppTextStyles.bodySmall(isDark),
                      ),
                      AppSpacing.gapV16,
                      AppButton.primary(
                        text: 'Explore Itinerary & Book',
                        width: double.infinity,
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Selected ${pkg.title}')),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

typedef TripsPage = TripsScreen;
