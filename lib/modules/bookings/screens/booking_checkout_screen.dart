import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sewasetu/app/routes/app_routes.dart';
import 'package:sewasetu/app/theme/app_colors.dart';
import 'package:sewasetu/app/theme/app_radius.dart';
import 'package:sewasetu/app/theme/app_spacing.dart';
import 'package:sewasetu/app/theme/app_text_styles.dart';
import 'package:sewasetu/core/utils/formatters.dart';
import 'package:sewasetu/modules/bookings/controllers/bookings_controller.dart';
import 'package:sewasetu/modules/bookings/models/booking_model.dart';
import 'package:sewasetu/modules/stay/stay.dart';
import 'package:sewasetu/shared/enums/stay_type.dart';
import 'package:sewasetu/shared/widgets/app_button.dart';
import 'package:sewasetu/shared/widgets/app_card.dart';
import 'package:sewasetu/shared/widgets/app_counter_stepper.dart';
import 'package:sewasetu/shared/widgets/app_network_image.dart';

/// Billing rate selection plan (Per Night vs Per Month)
enum BookingPricingPlan {
  nightly('Per Night', 'Standard daily rate', Icons.bed_rounded),
  monthly('Per Month', 'Long-stay rate', Icons.calendar_month_rounded);

  final String title;
  final String subtitle;
  final IconData icon;

  const BookingPricingPlan(this.title, this.subtitle, this.icon);
}

/// Complete Multi-step Checkout Page with Price Breakdown, Promo Code and Payment Methods
class BookingCheckoutScreen extends StatefulWidget {
  const BookingCheckoutScreen({super.key});

  @override
  State<BookingCheckoutScreen> createState() => _BookingCheckoutScreenState();
}

class _BookingCheckoutScreenState extends State<BookingCheckoutScreen> {
  late PropertyModel stay;
  late RoomOptionItem room;

  BookingPricingPlan selectedPricingPlan = BookingPricingPlan.nightly;
  int monthsCount = 1;

  DateTime checkIn = DateTime.now().add(const Duration(days: 1));
  DateTime checkOut = DateTime.now().add(const Duration(days: 4));
  int guestsCount = 2;
  PaymentMethodType selectedPayment = PaymentMethodType.upi;

  final TextEditingController promoController = TextEditingController();
  double discountAmount = 0.0;
  bool isPromoApplied = false;
  bool isProcessing = false;

  @override
  void initState() {
    super.initState();
    final args = Get.arguments as Map<String, dynamic>? ?? {};
    stay = args['stay'] as PropertyModel;
    room = args['room'] as RoomOptionItem;
    if (stay.stayType == StayType.room) {
      selectedPricingPlan = BookingPricingPlan.monthly;
      checkOut = checkIn.add(Duration(days: 30 * monthsCount));
    } else if (args['pricingPlan'] is BookingPricingPlan) {
      selectedPricingPlan = args['pricingPlan'] as BookingPricingPlan;
      if (selectedPricingPlan == BookingPricingPlan.monthly) {
        checkOut = checkIn.add(Duration(days: 30 * monthsCount));
      }
    }
  }

  int get nightsCount {
    final diff = checkOut.difference(checkIn).inDays;
    return diff > 0 ? diff : 1;
  }

  double get baseAmount {
    if (selectedPricingPlan == BookingPricingPlan.monthly) {
      return room.displayPricePerMonth * monthsCount;
    }
    return room.pricePerNight * nightsCount;
  }

  double get cleaningFee => 250.0;
  double get serviceFee => 180.0;
  double get taxes => (baseAmount + cleaningFee + serviceFee) * 0.12; // 12% GST
  double get totalAmount => (baseAmount + cleaningFee + serviceFee + taxes - discountAmount);

  void applyPromo() {
    if (promoController.text.trim().toUpperCase() == 'WELCOME500') {
      setState(() {
        discountAmount = 500.0;
        isPromoApplied = true;
      });
      Get.snackbar('Promo Applied', '₹500 discount applied to your stay!', snackPosition: SnackPosition.BOTTOM);
    } else {
      Get.snackbar('Invalid Promo', 'Code not recognized. Try WELCOME500', snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> confirmAndPay() async {
    setState(() => isProcessing = true);
    await Future.delayed(const Duration(milliseconds: 900));

    final isMonthly = selectedPricingPlan == BookingPricingPlan.monthly;
    final rateToRecord = isMonthly ? room.displayPricePerMonth : room.pricePerNight;
    final totalNights = isMonthly ? monthsCount * 30 : nightsCount;
    final roomName = isMonthly ? '${room.title} (Monthly Plan)' : room.title;

    final bookingController = Get.find<BookingsController>();
    final newBooking = BookingModel(
      id: 'book-${DateTime.now().millisecondsSinceEpoch}',
      bookingCode: '#SS-${(10000 + DateTime.now().microsecond % 90000)}',
      stayId: stay.id,
      stayTitle: stay.title,
      stayCity: stay.city,
      stayAddress: stay.address,
      stayImageUrl: stay.images.isNotEmpty ? stay.images.first : '',
      roomTitle: roomName,
      checkInDate: checkIn,
      checkOutDate: checkOut,
      nightsCount: totalNights,
      guestsCount: guestsCount,
      nightlyRate: rateToRecord,
      cleaningFee: cleaningFee,
      serviceFee: serviceFee,
      taxes: taxes,
      discount: discountAmount,
      totalAmount: totalAmount,
      paymentMethod: selectedPayment,
      isPaid: selectedPayment != PaymentMethodType.payAtProperty,
      hostName: stay.host.name,
      hostPhone: '+91 98765 43210',
    );

    bookingController.addBooking(newBooking);
    setState(() => isProcessing = false);

    Get.offNamed(
      AppRoutes.bookingConfirmation,
      arguments: newBooking,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final dateFormatter = DateFormat('EEE, dd MMM yyyy');

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Confirm & Pay',
          style: AppTextStyles.headlineSmall(isDark),
        ),
      ),
      body: SingleChildScrollView(
        padding: AppSpacing.screenPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Property & Selected Room Card
            AppCard(
              padding: AppSpacing.edgeInsetsMd,
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: AppRadius.radiusMd,
                    child: AppNetworkImage(
                      imageUrl: stay.images.isNotEmpty ? stay.images.first : '',
                      width: 84,
                      height: 84,
                    ),
                  ),
                  AppSpacing.gapH12,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          stay.stayType.label,
                          style: AppTextStyles.labelSmall(isDark).copyWith(
                            color: isDark ? AppColors.primaryLight : AppColors.primary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        AppSpacing.gapV4,
                        Text(
                          stay.title,
                          style: AppTextStyles.titleMedium(isDark).copyWith(
                            fontWeight: FontWeight.w800,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        AppSpacing.gapV4,
                        Text(
                          room.title,
                          style: AppTextStyles.bodySmall(isDark),
                        ),
                        AppSpacing.gapV4,
                        Text(
                          selectedPricingPlan == BookingPricingPlan.monthly
                              ? '${AppFormatters.formatCurrency(room.displayPricePerMonth)} / month'
                              : '${AppFormatters.formatCurrency(room.pricePerNight)} / night',
                          style: AppTextStyles.labelMedium(isDark).copyWith(
                            fontWeight: FontWeight.w700,
                            color: isDark ? AppColors.primaryLight : AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            AppSpacing.gapV24,

            // 2. Pricing Option Selector Card (Per Night vs Per Month)
            Text(
              'Pricing Option',
              style: AppTextStyles.headlineSmall(isDark).copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
            AppSpacing.gapV4,
            Text(
              'Select whether you want to book on a nightly or monthly rate plan',
              style: AppTextStyles.bodySmall(isDark),
            ),
            AppSpacing.gapV12,
            Row(
              children: BookingPricingPlan.values.map((plan) {
                final isSelected = selectedPricingPlan == plan;
                final isMonthly = plan == BookingPricingPlan.monthly;
                final rateLabel = isMonthly
                    ? '${AppFormatters.formatCurrency(room.displayPricePerMonth)} / mo'
                    : '${AppFormatters.formatCurrency(room.pricePerNight)} / night';

                return Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                      right: plan == BookingPricingPlan.nightly ? 6.0 : 0.0,
                      left: plan == BookingPricingPlan.monthly ? 6.0 : 0.0,
                    ),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          selectedPricingPlan = plan;
                          if (plan == BookingPricingPlan.monthly) {
                            checkOut = checkIn.add(Duration(days: 30 * monthsCount));
                          }
                        });
                      },
                      borderRadius: AppRadius.radiusMd,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: isDark
                              ? (isSelected ? AppColors.primaryContainerDark.withAlpha(50) : AppColors.surfaceDark)
                              : (isSelected ? AppColors.primaryContainer.withAlpha(60) : Colors.white),
                          borderRadius: AppRadius.radiusMd,
                          border: Border.all(
                            color: isSelected
                                ? (isDark ? AppColors.primaryLight : AppColors.primary)
                                : (isDark ? AppColors.borderDark : AppColors.borderLight),
                            width: isSelected ? 2 : 1,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(
                                  plan.icon,
                                  size: 20,
                                  color: isSelected
                                      ? (isDark ? AppColors.primaryLight : AppColors.primary)
                                      : (isDark ? AppColors.textMutedDark : AppColors.textMutedLight),
                                ),
                                Icon(
                                  isSelected ? Icons.radio_button_checked_rounded : Icons.radio_button_off_rounded,
                                  size: 18,
                                  color: isSelected
                                      ? (isDark ? AppColors.primaryLight : AppColors.primary)
                                      : (isDark ? AppColors.textMutedDark : AppColors.textMutedLight),
                                ),
                              ],
                            ),
                            AppSpacing.gapV8,
                            Text(
                              plan.title,
                              style: AppTextStyles.titleSmall(isDark).copyWith(
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              rateLabel,
                              style: AppTextStyles.labelMedium(isDark).copyWith(
                                fontWeight: FontWeight.w700,
                                color: isDark ? AppColors.primaryLight : AppColors.primary,
                              ),
                            ),
                            // if (isMonthly) ...[
                            //   const SizedBox(height: 4),
                            //   Container(
                            //     padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            //     decoration: BoxDecoration(
                            //       color: AppColors.success.withAlpha(30),
                            //       borderRadius: AppRadius.radiusSm,
                            //     ),
                            //     child: Text(
                            //       'Save ~15%',
                            //       style: AppTextStyles.labelSmall(isDark).copyWith(
                            //         fontSize: 10,
                            //         color: AppColors.success,
                            //         fontWeight: FontWeight.w700,
                            //       ),
                            //     ),
                            //   ),
                            // ],
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            AppSpacing.gapV24,

            // 3. Dates & Guests Selection
            Text(
              'Reservation Details',
              style: AppTextStyles.headlineSmall(isDark).copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
            AppSpacing.gapV12,
            AppCard(
              padding: AppSpacing.edgeInsetsMd,
              child: Column(
                children: [
                  if (selectedPricingPlan == BookingPricingPlan.monthly) ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Rental Duration', style: AppTextStyles.titleSmall(isDark)),
                            const SizedBox(height: 2),
                            Text(
                              '${dateFormatter.format(checkIn)} – ${dateFormatter.format(checkOut)}',
                              style: AppTextStyles.bodySmall(isDark),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove_circle_outline, size: 22),
                              onPressed: monthsCount > 1
                                  ? () {
                                      setState(() {
                                        monthsCount--;
                                        checkOut = checkIn.add(Duration(days: 30 * monthsCount));
                                      });
                                    }
                                  : null,
                            ),
                            Text(
                              '$monthsCount mo',
                              style: AppTextStyles.titleMedium(isDark).copyWith(fontWeight: FontWeight.w800),
                            ),
                            IconButton(
                              icon: const Icon(Icons.add_circle_outline, size: 22),
                              onPressed: monthsCount < 12
                                  ? () {
                                      setState(() {
                                        monthsCount++;
                                        checkOut = checkIn.add(Duration(days: 30 * monthsCount));
                                      });
                                    }
                                  : null,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ] else ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Dates ($nightsCount nights)', style: AppTextStyles.titleSmall(isDark)),
                            const SizedBox(height: 2),
                            Text(
                              '${dateFormatter.format(checkIn)} – ${dateFormatter.format(checkOut)}',
                              style: AppTextStyles.bodySmall(isDark),
                            ),
                          ],
                        ),
                        TextButton(
                          onPressed: () async {
                            final picked = await showDateRangePicker(
                              context: context,
                              firstDate: DateTime.now(),
                              lastDate: DateTime.now().add(const Duration(days: 365)),
                              initialDateRange: DateTimeRange(start: checkIn, end: checkOut),
                            );
                            if (picked != null) {
                              setState(() {
                                checkIn = picked.start;
                                checkOut = picked.end;
                              });
                            }
                          },
                          child: const Text('Change'),
                        ),
                      ],
                    ),
                  ],
                  const Divider(),
                  // Guests
                  AppCounterStepper(
                    label: 'Guests',
                    subtitle: 'Max guests for this room',
                    value: guestsCount,
                    min: 1,
                    max: 6,
                    onChanged: (val) => setState(() => guestsCount = val),
                  ),
                ],
              ),
            ),
            AppSpacing.gapV24,

            // 4. Promo Code Input
            Text(
              'Coupons & Discounts',
              style: AppTextStyles.headlineSmall(isDark).copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
            AppSpacing.gapV12,
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: promoController,
                    textCapitalization: TextCapitalization.characters,
                    decoration: InputDecoration(
                      hintText: 'Enter code (e.g. WELCOME500)',
                      filled: true,
                      fillColor: isDark ? AppColors.surfaceVariantDark : AppColors.surfaceVariantLight,
                      border: OutlineInputBorder(
                        borderRadius: AppRadius.radiusMd,
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: isPromoApplied ? null : applyPromo,
                  child: Text(isPromoApplied ? 'Applied ✓' : 'Apply'),
                ),
              ],
            ),
            AppSpacing.gapV24,

            // 5. Price Breakdown
            Text(
              'Price Breakdown',
              style: AppTextStyles.headlineSmall(isDark).copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
            AppSpacing.gapV12,
            AppCard(
              padding: AppSpacing.edgeInsetsMd,
              child: Column(
                children: [
                  _buildPriceRow(
                    isDark,
                    selectedPricingPlan == BookingPricingPlan.monthly
                        ? '${AppFormatters.formatCurrency(room.displayPricePerMonth)} × $monthsCount month${monthsCount > 1 ? 's' : ''}'
                        : '${AppFormatters.formatCurrency(room.pricePerNight)} × $nightsCount night${nightsCount > 1 ? 's' : ''}',
                    baseAmount,
                  ),
                  AppSpacing.gapV8,
                  _buildPriceRow(isDark, 'Cleaning fee', cleaningFee),
                  AppSpacing.gapV8,
                  _buildPriceRow(isDark, 'SewaSetu service fee', serviceFee),
                  AppSpacing.gapV8,
                  _buildPriceRow(isDark, 'Taxes & GST (12%)', taxes),
                  if (isPromoApplied) ...[
                    AppSpacing.gapV8,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Promo Discount (WELCOME500)', style: AppTextStyles.bodyMedium(isDark).copyWith(color: AppColors.success)),
                        Text('- ${AppFormatters.formatCurrency(discountAmount)}', style: AppTextStyles.bodyMedium(isDark).copyWith(color: AppColors.success, fontWeight: FontWeight.w700)),
                      ],
                    ),
                  ],
                  AppSpacing.gapV12,
                  const Divider(height: 1),
                  AppSpacing.gapV12,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total Payable',
                        style: AppTextStyles.titleMedium(isDark).copyWith(fontWeight: FontWeight.w800),
                      ),
                      Text(
                        AppFormatters.formatCurrency(totalAmount),
                        style: AppTextStyles.priceTag(isDark, fontSize: 18),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            AppSpacing.gapV24,

            // 6. Payment Methods Selector
            Text(
              'Payment Method',
              style: AppTextStyles.headlineSmall(isDark).copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
            AppSpacing.gapV12,
            Column(
              children: PaymentMethodType.values.map((method) {
                final isSelected = selectedPayment == method;

                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: InkWell(
                    onTap: () => setState(() => selectedPayment = method),
                    borderRadius: AppRadius.radiusMd,
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: isDark ? AppColors.surfaceDark : Colors.white,
                        borderRadius: AppRadius.radiusMd,
                        border: Border.all(
                          color: isSelected
                              ? (isDark ? AppColors.primaryLight : AppColors.primary)
                              : (isDark ? AppColors.borderDark : AppColors.borderLight),
                          width: isSelected ? 2 : 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Text(method.icon, style: const TextStyle(fontSize: 20)),
                          AppSpacing.gapH12,
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  method.title,
                                  style: AppTextStyles.titleSmall(isDark).copyWith(
                                    fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
                                  ),
                                ),
                                Text(method.subtitle, style: AppTextStyles.bodySmall(isDark)),
                              ],
                            ),
                          ),
                          Icon(
                            isSelected ? Icons.radio_button_checked_rounded : Icons.radio_button_off_rounded,
                            color: isSelected
                                ? (isDark ? AppColors.primaryLight : AppColors.primary)
                                : (isDark ? AppColors.textMutedDark : AppColors.textMutedLight),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            AppSpacing.gapV32,

            // 7. Confirm & Pay Button
            AppButton.primary(
              text: 'Confirm & Pay ${AppFormatters.formatCurrency(totalAmount)}',
              width: double.infinity,
              isLoading: isProcessing,
              onPressed: confirmAndPay,
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

typedef BookingCheckoutPage = BookingCheckoutScreen;
