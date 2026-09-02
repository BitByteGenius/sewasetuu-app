import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sewasetu/app/theme/app_colors.dart';
import 'package:sewasetu/app/theme/app_radius.dart';
import 'package:sewasetu/app/theme/app_spacing.dart';
import 'package:sewasetu/app/theme/app_text_styles.dart';
import 'package:sewasetu/shared/widgets/app_card.dart';

class CouponItem {
  final String code;
  final String title;
  final String description;
  final String validUntil;
  final String discountTag;

  const CouponItem({
    required this.code,
    required this.title,
    required this.description,
    required this.validUntil,
    required this.discountTag,
  });
}

/// Active coupons and promo discount codes page
class CouponsScreen extends StatelessWidget {
  const CouponsScreen({super.key});

  static const List<CouponItem> coupons = [
    CouponItem(
      code: 'WELCOME500',
      title: 'Flat ₹500 OFF on First Booking',
      description: 'Applicable on any Homestay, Hotel or PG with min stay of 2 nights.',
      validUntil: 'Valid until 31 Oct 2026',
      discountTag: '₹500 OFF',
    ),
    CouponItem(
      code: 'STAYCATION15',
      title: '15% OFF on Weekend Getaways',
      description: 'Get 15% discount up to ₹1,200 on stays booked in Shillong & Manali.',
      validUntil: 'Valid until 15 Nov 2026',
      discountTag: '15% OFF',
    ),
    CouponItem(
      code: 'MONTHLYSAVE',
      title: '₹2,000 OFF on Monthly PG Subscriptions',
      description: 'Valid for students and working professionals booking 30+ days stays.',
      validUntil: 'Valid until 31 Dec 2026',
      discountTag: '₹2,000 OFF',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Coupons & Offers',
          style: AppTextStyles.headlineSmall(isDark),
        ),
      ),
      body: ListView.separated(
        padding: AppSpacing.screenPadding,
        itemCount: coupons.length,
        separatorBuilder: (context, index) => AppSpacing.gapV16,
        itemBuilder: (context, index) {
          final coupon = coupons[index];

          return AppCard(
            padding: AppSpacing.edgeInsetsLg,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: isDark ? AppColors.primaryContainerDark : AppColors.primaryContainer,
                        borderRadius: AppRadius.radiusPill,
                      ),
                      child: Text(
                        coupon.discountTag,
                        style: AppTextStyles.labelSmall(isDark).copyWith(
                          color: isDark ? AppColors.primaryLight : AppColors.primary,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    Text(
                      coupon.validUntil,
                      style: AppTextStyles.bodySmall(isDark).copyWith(
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
                AppSpacing.gapV12,
                Text(
                  coupon.title,
                  style: AppTextStyles.titleMedium(isDark).copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                AppSpacing.gapV4,
                Text(
                  coupon.description,
                  style: AppTextStyles.bodySmall(isDark),
                ),
                AppSpacing.gapV16,
                const Divider(height: 1),
                AppSpacing.gapV12,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: isDark ? AppColors.surfaceVariantDark : AppColors.surfaceVariantLight,
                        borderRadius: AppRadius.radiusMd,
                        border: Border.all(
                          color: isDark ? AppColors.borderDark : AppColors.borderLight,
                          style: BorderStyle.solid,
                        ),
                      ),
                      child: Text(
                        coupon.code,
                        style: AppTextStyles.titleSmall(isDark).copyWith(
                          letterSpacing: 1.2,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    TextButton.icon(
                      icon: const Icon(Icons.copy_rounded, size: 16),
                      label: const Text('Copy Code'),
                      onPressed: () {
                        Get.snackbar('Copied', 'Coupon code ${coupon.code} copied to clipboard', snackPosition: SnackPosition.BOTTOM);
                      },
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

typedef CouponsPage = CouponsScreen;
