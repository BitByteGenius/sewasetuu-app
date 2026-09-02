import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sewasetu/app/theme/app_colors.dart';
import 'package:sewasetu/app/theme/app_radius.dart';
import 'package:sewasetu/app/theme/app_spacing.dart';
import 'package:sewasetu/app/theme/app_text_styles.dart';
import 'package:sewasetu/core/utils/formatters.dart';
import 'package:sewasetu/modules/bookings/models/booking_model.dart';
import 'package:sewasetu/shared/enums/booking_status.dart';
import 'package:sewasetu/shared/widgets/app_badge.dart';
import 'package:sewasetu/shared/widgets/app_card.dart';
import 'package:sewasetu/shared/widgets/app_network_image.dart';

/// Reservation Card widget displaying reservation summary and status
class BookingCardWidget extends StatelessWidget {
  final BookingModel booking;
  final VoidCallback onTap;

  const BookingCardWidget({
    super.key,
    required this.booking,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final dateFormatter = DateFormat('dd MMM');

    return AppCard(
      padding: AppSpacing.edgeInsetsMd,
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: AppRadius.radiusMd,
                child: AppNetworkImage(
                  imageUrl: booking.stayImageUrl,
                  width: 80,
                  height: 80,
                ),
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
                          booking.bookingCode,
                          style: AppTextStyles.labelSmall(isDark).copyWith(
                            color: isDark ? AppColors.primaryLight : AppColors.primary,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        _buildStatusBadge(booking.status),
                      ],
                    ),
                    AppSpacing.gapV4,
                    Text(
                      booking.stayTitle,
                      style: AppTextStyles.titleMedium(isDark).copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    AppSpacing.gapV4,
                    Text(
                      booking.roomTitle,
                      style: AppTextStyles.bodySmall(isDark),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    AppSpacing.gapV4,
                    // 400m approximate location badge
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          size: 13,
                          color: isDark ? AppColors.textMutedDark : AppColors.textMutedLight,
                        ),
                        const SizedBox(width: 2),
                        Expanded(
                          child: Text(
                            '${booking.stayCity} (Approx. 400m circle)',
                            style: AppTextStyles.labelSmall(isDark).copyWith(
                              color: isDark ? AppColors.textMutedDark : AppColors.textMutedLight,
                              fontSize: 10,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
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
                '${dateFormatter.format(booking.checkInDate)} – ${dateFormatter.format(booking.checkOutDate)} (${booking.nightsCount} nights)',
                style: AppTextStyles.bodySmall(isDark).copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                AppFormatters.formatCurrency(booking.totalAmount),
                style: AppTextStyles.priceTag(isDark, fontSize: 16),
              ),
            ],
          ),
        ],
      ),
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
      case BookingStatus.cancelled:
        return const AppBadge(
          text: 'Cancelled',
          backgroundColor: Color(0xFFFEE2E2),
          textColor: AppColors.error,
        );
      default:
        return AppBadge(text: status.label);
    }
  }
}
