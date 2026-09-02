import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sewasetu/app/theme/app_colors.dart';
import 'package:sewasetu/app/theme/app_radius.dart';
import 'package:sewasetu/app/theme/app_spacing.dart';
import 'package:sewasetu/app/theme/app_text_styles.dart';
import 'package:sewasetu/core/utils/formatters.dart';
import 'package:sewasetu/modules/bookings/models/booking_model.dart';
import 'package:sewasetu/modules/stay/widgets/location_map_preview_widget.dart';
import 'package:sewasetu/shared/widgets/app_badge.dart';
import 'package:sewasetu/shared/widgets/app_button.dart';
import 'package:sewasetu/shared/widgets/app_card.dart';
import 'package:sewasetu/shared/widgets/app_network_image.dart';

/// Detailed booking screen with digital QR voucher and cancellation policies
class BookingDetailsScreen extends StatelessWidget {
  const BookingDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final booking = Get.arguments as BookingModel;
    final dateFormatter = DateFormat('EEE, dd MMM yyyy');

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Booking Voucher',
          style: AppTextStyles.headlineSmall(isDark),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.share_outlined),
            onPressed: () {
              Get.snackbar('Share', 'Booking reference ${booking.bookingCode} copied to clipboard', snackPosition: SnackPosition.BOTTOM);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: AppSpacing.screenPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Digital Check-in Pass Card
            AppCard(
              padding: AppSpacing.edgeInsetsLg,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('PASS CODE', style: AppTextStyles.labelSmall(isDark)),
                          Text(
                            booking.bookingCode,
                            style: AppTextStyles.headlineSmall(isDark).copyWith(
                              color: isDark ? AppColors.primaryLight : AppColors.primary,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ],
                      ),
                      const AppBadge(
                        text: 'Confirmed',
                        backgroundColor: AppColors.successLight,
                        textColor: AppColors.success,
                      ),
                    ],
                  ),
                  const Divider(height: 24),
                  // QR Code Simulation
                  Container(
                    width: 140,
                    height: 140,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: AppRadius.radiusMd,
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.qr_code_2_rounded, size: 90, color: Colors.black),
                          Text('Scan at Front Desk', style: TextStyle(fontSize: 10, color: Colors.black87, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Present this QR voucher upon check-in',
                    style: AppTextStyles.bodySmall(isDark),
                  ),
                ],
              ),
            ),
            AppSpacing.gapV24,

            // Accommodation Info
            Text(
              'Stay Details',
              style: AppTextStyles.headlineSmall(isDark).copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
            AppSpacing.gapV12,
            AppCard(
              padding: AppSpacing.edgeInsetsMd,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: AppRadius.radiusMd,
                        child: AppNetworkImage(
                          imageUrl: booking.stayImageUrl,
                          width: 72,
                          height: 72,
                        ),
                      ),
                      AppSpacing.gapH12,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              booking.stayTitle,
                              style: AppTextStyles.titleMedium(isDark).copyWith(
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            AppSpacing.gapV4,
                            Text(booking.roomTitle, style: AppTextStyles.bodySmall(isDark)),
                            Text(booking.stayCity, style: AppTextStyles.bodySmall(isDark)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Divider(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('CHECK-IN', style: AppTextStyles.labelSmall(isDark)),
                          Text(dateFormatter.format(booking.checkInDate), style: AppTextStyles.titleSmall(isDark)),
                          Text('From 12:00 PM', style: AppTextStyles.bodySmall(isDark)),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text('CHECK-OUT', style: AppTextStyles.labelSmall(isDark)),
                          Text(dateFormatter.format(booking.checkOutDate), style: AppTextStyles.titleSmall(isDark)),
                          Text('Until 11:00 AM', style: AppTextStyles.bodySmall(isDark)),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            AppSpacing.gapV24,

            // Location Map with 400m privacy circle
            Text(
              'Location & Directions',
              style: AppTextStyles.headlineSmall(isDark).copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
            AppSpacing.gapV12,
            LocationMapPreviewWidget(
              address: booking.stayAddress,
              city: booking.stayCity,
              distanceText: 'Exact directions unlocked 2 hours before check-in',
            ),
            AppSpacing.gapV24,

            // Host Card
            Text(
              'Your Host',
              style: AppTextStyles.headlineSmall(isDark).copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
            AppSpacing.gapV12,
            AppCard(
              padding: AppSpacing.edgeInsetsMd,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(booking.hostName, style: AppTextStyles.titleMedium(isDark).copyWith(fontWeight: FontWeight.w700)),
                      Text(booking.hostPhone, style: AppTextStyles.bodySmall(isDark)),
                    ],
                  ),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.phone_rounded, size: 16),
                    label: const Text('Call Host'),
                    onPressed: () {
                      Get.snackbar('Calling Host', 'Dialing ${booking.hostPhone}...');
                    },
                  ),
                ],
              ),
            ),
            AppSpacing.gapV24,

            // Payment Receipt
            Text(
              'Payment Summary',
              style: AppTextStyles.headlineSmall(isDark).copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
            AppSpacing.gapV12,
            AppCard(
              padding: AppSpacing.edgeInsetsMd,
              child: Column(
                children: [
                  _buildPriceRow(isDark, 'Base Rate (${booking.nightsCount} nights)', booking.nightlyRate * booking.nightsCount),
                  AppSpacing.gapV8,
                  _buildPriceRow(isDark, 'Cleaning Fee', booking.cleaningFee),
                  AppSpacing.gapV8,
                  _buildPriceRow(isDark, 'Service Fee', booking.serviceFee),
                  AppSpacing.gapV8,
                  _buildPriceRow(isDark, 'Taxes & GST', booking.taxes),
                  if (booking.discount > 0) ...[
                    AppSpacing.gapV8,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Discount Applied', style: AppTextStyles.bodyMedium(isDark).copyWith(color: AppColors.success)),
                        Text('- ${AppFormatters.formatCurrency(booking.discount)}', style: AppTextStyles.bodyMedium(isDark).copyWith(color: AppColors.success)),
                      ],
                    ),
                  ],
                  const Divider(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total Paid', style: AppTextStyles.titleMedium(isDark).copyWith(fontWeight: FontWeight.w800)),
                      Text(AppFormatters.formatCurrency(booking.totalAmount), style: AppTextStyles.priceTag(isDark, fontSize: 18)),
                    ],
                  ),
                ],
              ),
            ),
            AppSpacing.gapV32,

            // Actions: Download Invoice & Cancel
            Row(
              children: [
                Expanded(
                  child: AppButton.outline(
                    text: 'Download Invoice',
                    onPressed: () {
                      Get.snackbar('Invoice Downloaded', 'PDF invoice saved to your downloads');
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: AppButton.outline(
                    text: 'Cancel Booking',
                    textColor: AppColors.error,
                    borderColor: AppColors.error,
                    onPressed: () {
                      Get.defaultDialog(
                        title: 'Cancel Reservation?',
                        middleText: 'Are you sure you want to cancel this booking? Free cancellation applies up to 24 hours before check-in.',
                        textConfirm: 'Yes, Cancel',
                        textCancel: 'Keep Booking',
                        confirmTextColor: Colors.white,
                        buttonColor: AppColors.error,
                        onConfirm: () {
                          Get.back();
                          Get.back();
                          Get.snackbar('Booking Cancelled', 'Refund will be initiated to your original payment method in 3-5 business days.');
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
            AppSpacing.gapV24,
          ],
        ),
      ),
    );
  }

  Widget _buildPriceRow(bool isDark, String label, double amount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: AppTextStyles.bodyMedium(isDark)),
        Text(AppFormatters.formatCurrency(amount), style: AppTextStyles.bodyMedium(isDark).copyWith(fontWeight: FontWeight.w600)),
      ],
    );
  }
}

typedef BookingDetailsPage = BookingDetailsScreen;
