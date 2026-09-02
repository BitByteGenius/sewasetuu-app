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
import 'package:sewasetu/modules/stay/property/domain/entities/stay_entity.dart';
import 'package:sewasetu/modules/stay/property_details/presentation/widgets/room_options_selector_widget.dart';
import 'package:sewasetu/shared/widgets/app_button.dart';
import 'package:sewasetu/shared/widgets/app_card.dart';
import 'package:sewasetu/shared/widgets/app_counter_stepper.dart';
import 'package:sewasetu/shared/widgets/app_network_image.dart';

/// Complete Multi-step Checkout Page with Price Breakdown, Promo Code and Payment Methods
class BookingCheckoutPage extends StatefulWidget {
  const BookingCheckoutPage({super.key});

  @override
  State<BookingCheckoutPage> createState() => _BookingCheckoutPageState();
}

class _BookingCheckoutPageState extends State<BookingCheckoutPage> {
  late StayEntity stay;
  late RoomOptionItem room;

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
    stay = args['stay'] as StayEntity;
    room = args['room'] as RoomOptionItem;
  }

  int get nightsCount {
    final diff = checkOut.difference(checkIn).inDays;
    return diff > 0 ? diff : 1;
  }

  double get baseAmount => room.pricePerNight * nightsCount;
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

    final bookingController = Get.find<BookingController>();
    final newBooking = BookingReservationEntity(
      id: 'book-${DateTime.now().millisecondsSinceEpoch}',
      bookingCode: '#SS-${(10000 + DateTime.now().microsecond % 90000)}',
      stayId: stay.id,
      stayTitle: stay.title,
      stayCity: stay.city,
      stayAddress: stay.address,
      stayImageUrl: stay.images.isNotEmpty ? stay.images.first : '',
      roomTitle: room.title,
      checkInDate: checkIn,
      checkOutDate: checkOut,
      nightsCount: nightsCount,
      guestsCount: guestsCount,
      nightlyRate: room.pricePerNight,
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
                          '${AppFormatters.formatCurrency(room.pricePerNight)} / night',
                          style: AppTextStyles.labelMedium(isDark).copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            AppSpacing.gapV24,

            // 2. Dates & Guests Selection
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
                  // Dates
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

            // 3. Promo Code Input
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

            // 4. Price Breakdown
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
                  _buildPriceRow(isDark, '${AppFormatters.formatCurrency(room.pricePerNight)} × $nightsCount nights', baseAmount),
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

            // 5. Payment Methods Selector
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

            // 6. Confirm & Pay Button
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
