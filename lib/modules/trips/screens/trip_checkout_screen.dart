import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_radius.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_bar/app_bar.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/app_card.dart';
import '../../../../shared/widgets/app_network_image.dart';
import '../../../../shared/widgets/app_text_field.dart';
import '../controllers/trip_details_controller.dart';
import '../widgets/trip_price_summary.dart';

/// Checkout and booking finalization screen for trip packages
class TripCheckoutScreen extends StatefulWidget {
  final TripDetailsController detailsController;

  const TripCheckoutScreen({
    super.key,
    required this.detailsController,
  });

  @override
  State<TripCheckoutScreen> createState() => _TripCheckoutScreenState();
}

class _TripCheckoutScreenState extends State<TripCheckoutScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameCtrl = TextEditingController(text: 'Gulshan Kumar');
  final _phoneCtrl = TextEditingController(text: '9876543210');
  final _emailCtrl = TextEditingController(text: 'gulshan@example.com');
  final _notesCtrl = TextEditingController();

  bool _payDepositOnly = true;
  String _selectedPaymentMethod = 'UPI (Google Pay, PhonePe, Paytm)';
  bool _isBooking = false;

  final List<String> _paymentMethods = const [
    'UPI (Google Pay, PhonePe, Paytm)',
    'Credit / Debit Card',
    'Net Banking',
  ];

  @override
  void dispose() {
    _nameCtrl.dispose();
    _phoneCtrl.dispose();
    _emailCtrl.dispose();
    _notesCtrl.dispose();
    super.dispose();
  }

  Future<void> _processBooking() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isBooking = true;
    });

    await Future.delayed(const Duration(milliseconds: 1200));

    setState(() {
      _isBooking = false;
    });

    final randomBookingId = 10000 + Random().nextInt(90000);
    _showSuccessDialog('#SW-TRIP-$randomBookingId');
  }

  void _showSuccessDialog(String bookingRef) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final package = widget.detailsController.package;
    final dateStr = widget.detailsController.selectedDate.value != null
        ? DateFormat('EEE, dd MMM yyyy')
            .format(widget.detailsController.selectedDate.value!)
        : 'Confirmed';

    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: AppRadius.radiusLg),
        backgroundColor:
            isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: const BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check_rounded,
                    color: Colors.white, size: 36),
              ),
              AppSpacing.gapV16,
              Text(
                'Trip Booking Confirmed!',
                style: AppTextStyles.titleLarge(isDark).copyWith(
                  fontWeight: FontWeight.w900,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 6),
              Text(
                'Booking Reference: $bookingRef',
                style: const TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w800,
                  fontSize: 13,
                ),
              ),
              const Divider(height: 24),
              Text(
                package.title,
                style: AppTextStyles.titleSmall(isDark).copyWith(
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                'Departure: $dateStr',
                style: AppTextStyles.bodySmall(isDark),
              ),
              Text(
                widget.detailsController.travelers.value.travelerSummary,
                style: AppTextStyles.bodySmall(isDark).copyWith(
                  color: isDark
                      ? AppColors.textMutedDark
                      : AppColors.textMutedLight,
                ),
              ),
              AppSpacing.gapV24,
              AppButton.primary(
                text: 'Done & Return to Travel Home',
                width: double.infinity,
                onPressed: () {
                  Get.back(); // close dialog
                  Get.back(); // return to package details
                  Get.back(); // return to trips home
                },
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final package = widget.detailsController.package;
    final travelers = widget.detailsController.travelers.value;
    final dateStr = widget.detailsController.selectedDate.value != null
        ? DateFormat('EEE, dd MMM yyyy')
            .format(widget.detailsController.selectedDate.value!)
        : 'Select Date';

    final payableNow = _payDepositOnly
        ? widget.detailsController.bookingDeposit
        : widget.detailsController.grandTotal;

    return Scaffold(
      appBar: const SewaAppBar(
        titleText: 'Confirm & Review Booking',
        showBackButton: true,
      ),
      body: SingleChildScrollView(
        padding: AppSpacing.screenPadding,
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Package Summary Card
              AppCard(
                padding: const EdgeInsets.all(12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: SizedBox(
                        width: 80,
                        height: 80,
                        child: AppNetworkImage(
                          imageUrl: package.coverImage,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            package.title,
                            style: AppTextStyles.titleSmall(isDark).copyWith(
                              fontWeight: FontWeight.w800,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(Icons.event_rounded,
                                  size: 13, color: AppColors.primary),
                              const SizedBox(width: 4),
                              Text(
                                dateStr,
                                style: TextStyle(
                                  fontSize: 11.5,
                                  fontWeight: FontWeight.w700,
                                  color: isDark
                                      ? AppColors.primaryLight
                                      : AppColors.primary,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 2),
                          Text(
                            travelers.travelerSummary,
                            style: AppTextStyles.bodySmall(isDark).copyWith(
                              fontSize: 11,
                              color: isDark
                                  ? AppColors.textMutedDark
                                  : AppColors.textSecondaryLight,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              AppSpacing.gapV20,

              // 2. Lead Traveler Details Header
              Text(
                'Lead Traveler Information',
                style: AppTextStyles.titleMedium(isDark).copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
              AppSpacing.gapV12,

              AppTextField(
                controller: _nameCtrl,
                label: 'Full Name *',
                hint: 'As on Govt. ID card',
                prefixIcon: const Icon(Icons.person_outline_rounded, size: 20),
                validator: (val) {
                  if (val == null || val.trim().isEmpty) {
                    return 'Please enter traveler full name';
                  }
                  return null;
                },
              ),
              AppSpacing.gapV12,

              AppTextField(
                controller: _phoneCtrl,
                label: 'Mobile Number *',
                hint: '10-digit phone number',
                keyboardType: TextInputType.phone,
                prefixIcon: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  alignment: Alignment.centerLeft,
                  width: 55,
                  child: Text(
                    '+91',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: isDark ? Colors.white70 : Colors.black87,
                    ),
                  ),
                ),
                validator: (val) {
                  if (val == null || val.trim().isEmpty) {
                    return 'Please enter phone number';
                  }
                  return null;
                },
              ),
              AppSpacing.gapV12,

              AppTextField(
                controller: _emailCtrl,
                label: 'Email Address *',
                hint: 'To receive tickets & itinerary voucher',
                keyboardType: TextInputType.emailAddress,
                prefixIcon: const Icon(Icons.email_outlined, size: 20),
                validator: (val) {
                  if (val == null || !val.contains('@')) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              AppSpacing.gapV12,

              AppTextField(
                controller: _notesCtrl,
                label: 'Special Requests / Dietary Needs (Optional)',
                hint: 'e.g. Vegetarian meals, ground floor room, early check-in',
                maxLines: 2,
                prefixIcon:
                    const Icon(Icons.rate_review_outlined, size: 20),
              ),
              AppSpacing.gapV20,

              // 3. Payment Option (25% Deposit vs Full Payment)
              Text(
                'Payment Schedule Choice',
                style: AppTextStyles.titleMedium(isDark).copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
              AppSpacing.gapV12,

              AppCard(
                padding: const EdgeInsets.all(4),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          _payDepositOnly = true;
                        });
                      },
                      borderRadius: BorderRadius.circular(8),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              _payDepositOnly
                                  ? Icons.radio_button_checked_rounded
                                  : Icons.radio_button_unchecked_rounded,
                              color: _payDepositOnly
                                  ? (isDark
                                      ? AppColors.primaryLight
                                      : AppColors.primary)
                                  : (isDark
                                      ? AppColors.textMutedDark
                                      : AppColors.textMutedLight),
                              size: 20,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Pay 25% Deposit Now (₹${widget.detailsController.bookingDeposit.toStringAsFixed(0)})',
                                    style: const TextStyle(
                                      fontSize: 13.5,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    'Pay remaining balance ₹${(widget.detailsController.grandTotal - widget.detailsController.bookingDeposit).toStringAsFixed(0)} on arrival',
                                    style: TextStyle(
                                      fontSize: 11.5,
                                      color: isDark
                                          ? AppColors.textMutedDark
                                          : AppColors.textMutedLight,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Divider(height: 1),
                    InkWell(
                      onTap: () {
                        setState(() {
                          _payDepositOnly = false;
                        });
                      },
                      borderRadius: BorderRadius.circular(8),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              !_payDepositOnly
                                  ? Icons.radio_button_checked_rounded
                                  : Icons.radio_button_unchecked_rounded,
                              color: !_payDepositOnly
                                  ? (isDark
                                      ? AppColors.primaryLight
                                      : AppColors.primary)
                                  : (isDark
                                      ? AppColors.textMutedDark
                                      : AppColors.textMutedLight),
                              size: 20,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Pay Full Amount (₹${widget.detailsController.grandTotal.toStringAsFixed(0)})',
                                    style: const TextStyle(
                                      fontSize: 13.5,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    'Complete payments now with zero pending dues on trip',
                                    style: TextStyle(
                                      fontSize: 11.5,
                                      color: isDark
                                          ? AppColors.textMutedDark
                                          : AppColors.textMutedLight,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              AppSpacing.gapV20,

              // 4. Payment Method Selection
              Text(
                'Payment Method',
                style: AppTextStyles.titleMedium(isDark).copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
              AppSpacing.gapV12,

              AppCard(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: _paymentMethods.map((method) {
                    final isSelected = _selectedPaymentMethod == method;
                    return InkWell(
                      onTap: () {
                        setState(() {
                          _selectedPaymentMethod = method;
                        });
                      },
                      borderRadius: BorderRadius.circular(8),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        child: Row(
                          children: [
                            Icon(
                              isSelected
                                  ? Icons.radio_button_checked
                                  : Icons.radio_button_unchecked,
                              color: isSelected
                                  ? (isDark
                                      ? AppColors.primaryLight
                                      : AppColors.primary)
                                  : Colors.grey,
                              size: 20,
                            ),
                            const SizedBox(width: 12),
                            Text(
                              method,
                              style: TextStyle(
                                fontSize: 13.5,
                                fontWeight: isSelected
                                    ? FontWeight.w700
                                    : FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              AppSpacing.gapV20,

              // 5. Price Breakdown Summary
              TripPriceSummary(controller: widget.detailsController),
              const SizedBox(height: 36),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(20),
              blurRadius: 10,
              offset: const Offset(0, -3),
            ),
          ],
          border: Border(
            top: BorderSide(
              color: isDark ? AppColors.borderDark : AppColors.borderLight,
            ),
          ),
        ),
        child: SafeArea(
          child: Row(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _payDepositOnly ? 'PAYABLE NOW (25%)' : 'TOTAL PAYABLE',
                    style: AppTextStyles.labelSmall(isDark).copyWith(
                      letterSpacing: 0.6,
                    ),
                  ),
                  Text(
                    '₹${payableNow.toStringAsFixed(0)}',
                    style: AppTextStyles.priceTag(isDark, fontSize: 19),
                  ),
                ],
              ),
              const SizedBox(width: 20),
              Expanded(
                child: AppButton.primary(
                  text: 'Confirm & Book',
                  icon: const Icon(Icons.check_circle_outline_rounded, size: 18),
                  isLoading: _isBooking,
                  onPressed: _processBooking,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
