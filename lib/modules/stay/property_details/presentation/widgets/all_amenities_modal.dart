import 'package:flutter/material.dart';
import 'package:sewasetu/app/theme/app_colors.dart';
import 'package:sewasetu/app/theme/app_spacing.dart';
import 'package:sewasetu/app/theme/app_text_styles.dart';
import 'package:sewasetu/shared/widgets/app_bottom_sheet.dart';

/// Full categorized amenities modal
class AllAmenitiesModal extends StatelessWidget {
  final List<String> amenities;

  const AllAmenitiesModal({
    super.key,
    required this.amenities,
  });

  static Future<void> show(BuildContext context, {required List<String> amenities}) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => AllAmenitiesModal(amenities: amenities),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return AppBottomSheet(
      title: 'What this place offers',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCategory(isDark, 'Scenic & Environment', [
            'Mountain View / Forest Scenery',
            'Private Balcony or Sit-out',
            'Garden & Bonfire Area',
          ]),
          _buildCategory(isDark, 'Bathroom & Hygiene', [
            'Hot Water Geyser 24x7',
            'Fresh Towels & Organic Toiletries',
            'Attached Private Bathroom',
          ]),
          _buildCategory(isDark, 'Bedroom & Laundry', [
            'Clean Cotton Bedding & Blankets',
            'Wardrobe & Clothes Storage',
            'Daily Housekeeping Service',
            'Laundry / Washing Machine Access',
          ]),
          _buildCategory(isDark, 'Internet & Entertainment', [
            'Fast Wi-Fi (100+ Mbps)',
            'Dedicated Work Desk & Ergonomic Chair',
            'Smart TV with OTT Subscriptions',
          ]),
          _buildCategory(isDark, 'Safety & Security', [
            '24/7 CCTV in Common Areas',
            'First Aid Kit On-site',
            'Fire Extinguisher',
            'Biometric / Card Access Gate',
          ]),
        ],
      ),
    );
  }

  Widget _buildCategory(bool isDark, String title, List<String> items) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTextStyles.titleMedium(isDark).copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
          AppSpacing.gapV8,
          ...items.map((item) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Row(
                children: [
                  Icon(
                    Icons.check_circle_outline_rounded,
                    size: 18,
                    color: isDark ? AppColors.primaryLight : AppColors.primary,
                  ),
                  AppSpacing.gapH12,
                  Expanded(
                    child: Text(
                      item,
                      style: AppTextStyles.bodyMedium(isDark),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
