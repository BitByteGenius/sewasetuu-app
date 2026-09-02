import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sewasetu/app/routes/app_routes.dart';
import 'package:sewasetu/app/theme/app_colors.dart';
import 'package:sewasetu/app/theme/app_radius.dart';
import 'package:sewasetu/app/theme/app_spacing.dart';
import 'package:sewasetu/app/theme/app_text_styles.dart';
import 'package:sewasetu/core/utils/formatters.dart';
import 'package:sewasetu/modules/booking/domain/entities/booking_entity.dart';
import 'package:sewasetu/modules/booking/presentation/controllers/booking_controller.dart';
import 'package:sewasetu/shared/enums/booking_status.dart';
import 'package:sewasetu/shared/widgets/app_badge.dart';
import 'package:sewasetu/shared/widgets/app_card.dart';
import 'package:sewasetu/shared/widgets/app_empty_state.dart';
import 'package:sewasetu/shared/widgets/app_network_image.dart';

/// My Bookings screen with Upcoming, Completed, and Cancelled tabs
class BookingListPage extends GetView<BookingController> {
  const BookingListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'My Reservations',
            style: AppTextStyles.headlineSmall(isDark),
          ),
          bottom: TabBar(
            onTap: controller.switchTab,
            indicatorColor: isDark ? AppColors.primaryLight : AppColors.primary,
            indicatorWeight: 3,
            labelColor: isDark ? AppColors.primaryLight : AppColors.primary,
            unselectedLabelColor: isDark ? AppColors.textMutedDark : AppColors.textMutedLight,
            labelStyle: AppTextStyles.titleSmall(isDark).copyWith(fontWeight: FontWeight.w700),
            tabs: const [
              Tab(text: 'Upcoming'),
              Tab(text: 'Completed'),
              Tab(text: 'Cancelled'),
            ],
          ),
        ),
        body: Obx(() {
          return TabBarView(
            children: [
              _buildBookingsList(context, isDark, controller.upcomingBookings, 'No upcoming reservations', 'Your upcoming stays and bookings will show up here.'),
              _buildBookingsList(context, isDark, controller.completedBookings, 'No completed stays', 'Previous stays and check-outs will be listed here.'),
              _buildBookingsList(context, isDark, controller.cancelledBookings, 'No cancelled bookings', 'Any cancelled bookings will appear here.'),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildBookingsList(
    BuildContext context,
    bool isDark,
    List<BookingReservationEntity> list,
    String emptyTitle,
    String emptySubtitle,
  ) {
    final dateFormatter = DateFormat('dd MMM');

    if (list.isEmpty) {
      return AppEmptyState(
        icon: Icons.calendar_today_outlined,
        title: emptyTitle,
        description: emptySubtitle,
        actionText: 'Explore Stays',
        onAction: () => Get.toNamed(AppRoutes.stayList),
      );
    }

    return ListView.separated(
      padding: AppSpacing.screenPadding,
      itemCount: list.length,
      separatorBuilder: (context, index) => AppSpacing.gapV16,
      itemBuilder: (context, index) {
        final booking = list[index];

        return AppCard(
          padding: AppSpacing.edgeInsetsMd,
          onTap: () => Get.toNamed(AppRoutes.bookingDetails, arguments: booking),
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
      },
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
