import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_radius.dart';
import '../../../app/theme/app_spacing.dart';
import '../controllers/rental_booking_controller.dart';
import '../models/rental_pricing_model.dart';

/// Transparent price breakdown widget with live coupon application.
class RentalPriceBreakdownWidget extends StatefulWidget {
  final RentalPricingModel pricing;

  const RentalPriceBreakdownWidget({
    super.key,
    required this.pricing,
  });

  @override
  State<RentalPriceBreakdownWidget> createState() => _RentalPriceBreakdownWidgetState();
}

class _RentalPriceBreakdownWidgetState extends State<RentalPriceBreakdownWidget> {
  final TextEditingController _couponController = TextEditingController();

  @override
  void dispose() {
    _couponController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bookingCtrl = Get.find<RentalBookingController>();
    final p = widget.pricing;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
        borderRadius: AppRadius.radiusXl,
        border: Border.all(
          color: isDark ? AppColors.borderDark : AppColors.borderLight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'PRICE BREAKDOWN',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.7,
              color: isDark ? AppColors.textMutedDark : AppColors.textSecondaryLight,
            ),
          ),
          const SizedBox(height: AppSpacing.md),

          // Coupon applicator
          Obx(() {
            final hasCoupon = bookingCtrl.appliedCoupon.value.isNotEmpty;

            if (hasCoupon) {
              return Container(
                margin: const EdgeInsets.only(bottom: AppSpacing.md),
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.sm,
                ),
                decoration: BoxDecoration(
                  color: AppColors.successLight,
                  borderRadius: AppRadius.radiusMd,
                  border: Border.all(color: AppColors.success),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.check_circle, size: 16, color: AppColors.success),
                        const SizedBox(width: 8),
                        Text(
                          '${bookingCtrl.appliedCoupon.value} applied (-₹${bookingCtrl.discountAmount.value.toInt()})',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF065F46),
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, size: 16, color: Colors.black54),
                      onPressed: () => bookingCtrl.removeCoupon(),
                      constraints: const BoxConstraints(),
                      padding: EdgeInsets.zero,
                    ),
                  ],
                ),
              );
            }

            return Container(
              margin: const EdgeInsets.only(bottom: AppSpacing.md),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _couponController,
                      textCapitalization: TextCapitalization.characters,
                      decoration: InputDecoration(
                        hintText: 'Enter Promo Code (e.g. FIRSTDRIVE)',
                        hintStyle: TextStyle(
                          fontSize: 12,
                          color: isDark ? AppColors.textMutedDark : AppColors.textMutedLight,
                        ),
                        isDense: true,
                        filled: true,
                        fillColor: isDark ? AppColors.surfaceVariantDark : AppColors.surfaceVariantLight,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                        border: OutlineInputBorder(
                          borderRadius: AppRadius.radiusMd,
                          borderSide: BorderSide.none,
                        ),
                      ),
                      style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  ElevatedButton(
                    onPressed: () {
                      if (_couponController.text.isNotEmpty) {
                        bookingCtrl.applyCoupon(_couponController.text);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      shape: const RoundedRectangleBorder(
                        borderRadius: AppRadius.radiusMd,
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    ),
                    child: const Text('Apply', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700)),
                  ),
                ],
              ),
            );
          }),

          // Line items
          _buildPriceRow(
            isDark,
            'Base Rental (${p.durationDays} ${p.durationDays == 1 ? "day" : "days"})',
            '₹${p.rentalCost.toInt()}',
          ),
          if (p.addonCost > 0)
            _buildPriceRow(
              isDark,
              'Protection & Add-ons',
              '₹${p.addonCost.toInt()}',
            ),
          _buildPriceRow(
            isDark,
            'Delivery & Pickup',
            p.deliveryFee > 0 ? '₹${p.deliveryFee.toInt()}' : 'FREE Hub Pickup',
            p.deliveryFee == 0 ? AppColors.success : null,
          ),
          _buildPriceRow(
            isDark,
            'GST & Taxes (18%)',
            '₹${p.taxAmount.toInt()}',
          ),
          if (p.discountAmount > 0)
            _buildPriceRow(
              isDark,
              'Promo Discount',
              '-₹${p.discountAmount.toInt()}',
              AppColors.success,
            ),
          if (p.securityDeposit > 0)
            _buildPriceRow(
              isDark,
              'Refundable Security Deposit',
              '₹${p.securityDeposit.toInt()}',
              isDark ? AppColors.primaryLight : AppColors.primary,
            ),

          const SizedBox(height: AppSpacing.sm),
          const Divider(height: 1),
          const SizedBox(height: AppSpacing.md),

          // Grand Total
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'TOTAL PAYABLE',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 0.8,
                      color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                    ),
                  ),
                  if (p.refundableDeposit > 0)
                    Text(
                      'Includes ₹${p.refundableDeposit.toInt()} refundable deposit',
                      style: TextStyle(
                        fontSize: 10,
                        color: isDark ? AppColors.textMutedDark : AppColors.textSecondaryLight,
                      ),
                    ),
                ],
              ),
              Text(
                '₹${p.totalPayable.toInt()}',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPriceRow(
    bool isDark,
    String label,
    String amount, [
    Color? color,
  ]) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 13,
              color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
            ),
          ),
          Text(
            amount,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: color ?? (isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight),
            ),
          ),
        ],
      ),
    );
  }
}
