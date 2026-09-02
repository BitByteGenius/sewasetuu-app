import 'package:flutter/material.dart';
import 'package:sewasetu/app/theme/app_colors.dart';
import 'package:sewasetu/app/theme/app_radius.dart';
import 'package:sewasetu/app/theme/app_spacing.dart';
import 'package:sewasetu/app/theme/app_text_styles.dart';

class DestinationItem {
  final String name;
  final String state;
  final String imageUrl;
  final int availableStays;

  const DestinationItem({
    required this.name,
    required this.state,
    required this.imageUrl,
    required this.availableStays,
  });
}

/// Popular destinations card carousel for travel and staycations.
class PopularDestinationsWidget extends StatelessWidget {
  final ValueChanged<String> onSelectDestination;

  const PopularDestinationsWidget({
    super.key,
    required this.onSelectDestination,
  });

  static const List<DestinationItem> destinations = [
    DestinationItem(
      name: 'Shillong',
      state: 'Meghalaya',
      imageUrl: 'https://images.unsplash.com/photo-1544735716-392fe2489ffa?auto=format&fit=crop&w=600&q=80',
      availableStays: 48,
    ),
    DestinationItem(
      name: 'Goa',
      state: 'India',
      imageUrl: 'https://images.unsplash.com/photo-1512343879784-a960bf40e7f2?auto=format&fit=crop&w=600&q=80',
      availableStays: 120,
    ),
    DestinationItem(
      name: 'Manali',
      state: 'Himachal Pradesh',
      imageUrl: 'https://images.unsplash.com/photo-1605649487212-47bdab064df8?auto=format&fit=crop&w=600&q=80',
      availableStays: 85,
    ),
    DestinationItem(
      name: 'Guwahati',
      state: 'Assam',
      imageUrl: 'https://images.unsplash.com/photo-1571536802807-30451e3955d8?auto=format&fit=crop&w=600&q=80',
      availableStays: 160,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: AppSpacing.horizontalLg,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Top Travel & Stay Destinations',
                style: AppTextStyles.headlineSmall(isDark).copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
              Text(
                'Explore popular getaway destinations with certified stays',
                style: AppTextStyles.bodySmall(isDark),
              ),
            ],
          ),
        ),
        AppSpacing.gapV12,
        SizedBox(
          height: 160,
          child: ListView.separated(
            padding: AppSpacing.horizontalLg,
            scrollDirection: Axis.horizontal,
            itemCount: destinations.length,
            separatorBuilder: (context, index) => AppSpacing.gapH12,
            itemBuilder: (context, index) {
              final item = destinations[index];
              return GestureDetector(
                onTap: () => onSelectDestination(item.name),
                child: ClipRRect(
                  borderRadius: AppRadius.radiusLg,
                  child: Container(
                    width: 140,
                    height: 160,
                    decoration: BoxDecoration(
                      color: isDark ? AppColors.surfaceVariantDark : AppColors.surfaceVariantLight,
                    ),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.network(
                          item.imageUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Container(
                            color: isDark ? AppColors.surfaceVariantDark : AppColors.primaryContainer,
                            child: const Center(child: Icon(Icons.landscape_rounded)),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Colors.black.withAlpha(200),
                              ],
                            ),
                          ),
                          padding: const EdgeInsets.all(12),
                          alignment: Alignment.bottomLeft,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.name,
                                style: AppTextStyles.titleMedium(true).copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              Text(
                                '${item.availableStays} Stays',
                                style: AppTextStyles.labelSmall(true).copyWith(
                                  color: AppColors.secondary,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
