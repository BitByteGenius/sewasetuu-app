import 'package:flutter/material.dart';
import '../../../../app/theme/app_radius.dart';
import '../../../../shared/widgets/app_card.dart';

/// Skeleton loader matching the dimensions of TripPackageCard
class TripLoadingCard extends StatelessWidget {
  const TripLoadingCard({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final shimmerColor = isDark ? Colors.white10 : Colors.black.withAlpha(15);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: AppCard(
        padding: EdgeInsets.zero,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 170,
              width: double.infinity,
              color: shimmerColor,
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 14,
                    width: 120,
                    decoration: BoxDecoration(
                      color: shimmerColor,
                      borderRadius: AppRadius.radiusSm,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    height: 18,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: shimmerColor,
                      borderRadius: AppRadius.radiusSm,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    height: 18,
                    width: 220,
                    decoration: BoxDecoration(
                      color: shimmerColor,
                      borderRadius: AppRadius.radiusSm,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 22,
                        width: 90,
                        decoration: BoxDecoration(
                          color: shimmerColor,
                          borderRadius: AppRadius.radiusSm,
                        ),
                      ),
                      Container(
                        height: 36,
                        width: 100,
                        decoration: BoxDecoration(
                          color: shimmerColor,
                          borderRadius: BorderRadius.circular(8),
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
    );
  }
}
