import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sewasetu/app/routes/app_routes.dart';
import 'package:sewasetu/app/theme/app_colors.dart';
import 'package:sewasetu/app/theme/app_radius.dart';
import 'package:sewasetu/app/theme/app_spacing.dart';
import 'package:sewasetu/app/theme/app_text_styles.dart';
import 'package:sewasetu/core/utils/formatters.dart';
import 'package:sewasetu/modules/bookings/models/booking_model.dart';
import 'package:sewasetu/shared/widgets/app_button.dart';
import 'package:sewasetu/shared/widgets/app_card.dart';

/// Celebratory Booking Confirmation Screen with animated badge and voucher details
class BookingConfirmationScreen extends StatelessWidget {
  const BookingConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final booking = Get.arguments as BookingModel;
    final dateFormatter = DateFormat('EEE, dd MMM yyyy');

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: AppSpacing.screenPadding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AppSpacing.gapV32,
              // Animated Success Emblem
              TweenAnimationBuilder<double>(
                tween: Tween(begin: 0.0, end: 1.0),
                duration: const Duration(milliseconds: 600),
                curve: Curves.elasticOut,
                builder: (context, val, child) {
                  return Transform.scale(
                    scale: val,
                    child: Container(
                      width: 90,
                      height: 90,
                      decoration: BoxDecoration(
                        color: AppColors.successLight,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.success.withAlpha(50),
                            blurRadius: 20,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.check_circle_rounded,
                          size: 52,
                          color: AppColors.success,
                        ),
                      ),
                    ),
                  );
                },
              ),
              AppSpacing.gapV24,

              Text(
                'Reservation Confirmed!',
                style: AppTextStyles.displaySmall(isDark).copyWith(
                  fontWeight: FontWeight.w900,
                ),
                textAlign: TextAlign.center,
              ),
              AppSpacing.gapV8,
              Text(
                'Your booking has been approved. A confirmation SMS and email voucher have been sent to your registered contact.',
                style: AppTextStyles.bodyMedium(isDark).copyWith(
                  color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
              AppSpacing.gapV24,

              // Booking Voucher Summary Card
              AppCard(
                padding: AppSpacing.edgeInsetsLg,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Booking Reference', style: AppTextStyles.labelSmall(isDark)),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: isDark ? AppColors.primaryContainerDark : AppColors.primaryContainer,
                            borderRadius: AppRadius.radiusPill,
                          ),
                          child: Text(
                            booking.bookingCode,
                            style: AppTextStyles.labelMedium(isDark).copyWith(
                              color: isDark ? AppColors.primaryLight : AppColors.primary,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Divider(height: 24),
                  _buildRow(isDark, 'Accommodation', booking.stayTitle),
                  AppSpacing.gapV8,
                  _buildRow(isDark, 'Room Unit', booking.roomTitle),
                  AppSpacing.gapV8,
                  _buildRow(isDark, 'Check-In', dateFormatter.format(booking.checkInDate)),
                  AppSpacing.gapV8,
                  _buildRow(isDark, 'Check-Out', dateFormatter.format(booking.checkOutDate)),
                  AppSpacing.gapV8,
                  _buildRow(isDark, 'Total Paid', AppFormatters.formatCurrency(booking.totalAmount)),
                ],
              ),
            ),
            AppSpacing.gapV32,

            // Action Buttons
            AppButton.primary(
              text: 'View Booking Details & Voucher',
              width: double.infinity,
              onPressed: () {
                Get.offNamed(AppRoutes.bookingDetails, arguments: booking);
              },
            ),
            AppSpacing.gapV12,
            AppButton.outline(
              text: 'Return to Home',
              width: double.infinity,
              onPressed: () => Get.offAllNamed(AppRoutes.main),
            ),
          ],
        ),
      ),
    ),
  );
}

  Widget _buildRow(bool isDark, String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: AppTextStyles.bodyMedium(isDark)),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: AppTextStyles.bodyMedium(isDark).copyWith(fontWeight: FontWeight.w700),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

typedef BookingConfirmationPage = BookingConfirmationScreen;
