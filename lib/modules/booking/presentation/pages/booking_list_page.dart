import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sewasetu/app/theme/app_colors.dart';
import 'package:sewasetu/app/theme/app_spacing.dart';
import 'package:sewasetu/app/theme/app_text_styles.dart';
import 'package:sewasetu/core/utils/formatters.dart';
import 'package:sewasetu/shared/enums/booking_status.dart';
import 'package:sewasetu/shared/widgets/app_badge.dart';
import 'package:sewasetu/shared/widgets/app_card.dart';
import 'package:sewasetu/shared/widgets/app_network_image.dart';
import 'package:sewasetu/modules/booking/presentation/controllers/booking_controller.dart';

/// Bookings list page displaying active, upcoming and completed reservations.
class BookingListPage extends GetView<BookingController> {
  const BookingListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Reservations',
          style: AppTextStyles.headlineSmall(isDark),
        ),
      ),
      body: Obx(() {
        if (controller.bookings.isEmpty) {
          return const Center(child: Text('No bookings yet'));
        }

        return ListView.separated(
          padding: AppSpacing.screenPadding,
          itemCount: controller.bookings.length,
          separatorBuilder: (context, index) => AppSpacing.gapV16,
          itemBuilder: (context, index) {
            final item = controller.bookings[index];
            return AppCard(
              padding: AppSpacing.edgeInsetsMd,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      AppNetworkImage(
                        imageUrl: item.imageUrl,
                        width: 80,
                        height: 80,
                      ),
                      AppSpacing.gapH12,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  item.id,
                                  style: AppTextStyles.labelSmall(isDark),
                                ),
                                _buildStatusBadge(item.status),
                              ],
                            ),
                            AppSpacing.gapV4,
                            Text(
                              item.title,
                              style: AppTextStyles.titleMedium(isDark).copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            AppSpacing.gapV4,
                            Text(
                              item.dates,
                              style: AppTextStyles.bodySmall(isDark),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  AppSpacing.gapV12,
                  const Divider(height: 1),
                  AppSpacing.gapV8,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total Paid / Due',
                        style: AppTextStyles.bodySmall(isDark),
                      ),
                      Text(
                        AppFormatters.formatCurrency(item.totalAmount),
                        style: AppTextStyles.priceTag(isDark, fontSize: 16),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      }),
    );
  }

  Widget _buildStatusBadge(BookingStatus status) {
    switch (status) {
      case BookingStatus.confirmed:
        return const AppBadge(
          text: 'Confirmed',
          backgroundColor: AppColors.successLight,
          textColor: AppColors.success,
        );
      case BookingStatus.completed:
        return const AppBadge(
          text: 'Completed',
          backgroundColor: AppColors.surfaceVariantLight,
          textColor: AppColors.textSecondaryLight,
        );
      case BookingStatus.ongoing:
        return const AppBadge(
          text: 'Checked-In',
          backgroundColor: AppColors.primaryContainer,
          textColor: AppColors.primary,
        );
      default:
        return AppBadge(text: status.label);
    }
  }
}
