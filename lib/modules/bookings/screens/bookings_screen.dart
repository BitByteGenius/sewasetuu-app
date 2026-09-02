import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sewasetu/app/routes/app_routes.dart';
import 'package:sewasetu/app/theme/app_colors.dart';
import 'package:sewasetu/app/theme/app_spacing.dart';
import 'package:sewasetu/app/theme/app_text_styles.dart';
import 'package:sewasetu/modules/bookings/bindings/bookings_binding.dart';
import 'package:sewasetu/modules/bookings/controllers/bookings_controller.dart';
import 'package:sewasetu/modules/bookings/models/booking_model.dart';
import 'package:sewasetu/modules/bookings/widgets/booking_card.dart';
import 'package:sewasetu/shared/widgets/app_empty_state.dart';

/// My Bookings screen with Upcoming, Completed, and Cancelled tabs
class BookingsScreen extends GetView<BookingsController> {
  const BookingsScreen({super.key});

  @override
  BookingsController get controller {
    if (!Get.isRegistered<BookingsController>()) {
      BookingsBinding().dependencies();
    }
    return super.controller;
  }

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
    List<BookingModel> list,
    String emptyTitle,
    String emptySubtitle,
  ) {
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

        return BookingCardWidget(
          booking: booking,
          onTap: () => Get.toNamed(AppRoutes.bookingDetails, arguments: booking),
        );
      },
    );
  }
}

typedef BookingListPage = BookingsScreen;
