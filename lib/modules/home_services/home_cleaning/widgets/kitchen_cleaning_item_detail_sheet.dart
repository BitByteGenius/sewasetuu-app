import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sewasetu/app/theme/app_colors.dart';

import '../controller/kitchen_cleaning_controller.dart';
import '../models/kitchen_cleaning_model.dart';

/// Premium detail sheet for single services (Fridge, Chimney, Microwave, Mini Services)
/// matching exact layout in reference photo.
class KitchenCleaningItemDetailSheet extends StatefulWidget {
  final KitchenCleaningServiceItem item;
  final KitchenSingleServiceDetailData detailData;

  const KitchenCleaningItemDetailSheet({
    super.key,
    required this.item,
    required this.detailData,
  });

  /// Static helper to launch this sheet modally
  static Future<void> show(
    BuildContext context, {
    required KitchenCleaningServiceItem item,
    required KitchenSingleServiceDetailData detailData,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (context) => KitchenCleaningItemDetailSheet(
        item: item,
        detailData: detailData,
      ),
    );
  }

  @override
  State<KitchenCleaningItemDetailSheet> createState() =>
      _KitchenCleaningItemDetailSheetState();
}

class _KitchenCleaningItemDetailSheetState
    extends State<KitchenCleaningItemDetailSheet> {
  // Local quantity map for variants in this sheet
  final Map<String, int> _variantQuantities = {};

  KitchenCleaningController get _controller =>
      Get.isRegistered<KitchenCleaningController>()
          ? Get.find<KitchenCleaningController>()
          : Get.put(KitchenCleaningController());

  @override
  void initState() {
    super.initState();
    // Initialize quantities from controller cart
    for (var variant in widget.detailData.variants) {
      final cartItem = _controller.cartItems.firstWhereOrNull(
        (i) => i.service.id == widget.item.id && i.selectedOption?.id == variant.id,
      );
      if (cartItem != null) {
        _variantQuantities[variant.id] = cartItem.quantity;
      }
    }
  }

  void _incrementVariant(KitchenServiceVariant variant) {
    HapticFeedback.lightImpact();
    setState(() {
      final current = _variantQuantities[variant.id] ?? 0;
      _variantQuantities[variant.id] = current + 1;
    });

    final option = ServiceOptionItem(
      id: variant.id,
      name: variant.name,
      price: variant.price,
    );
    _controller.addItem(widget.item, option);
  }

  void _decrementVariant(KitchenServiceVariant variant) {
    HapticFeedback.lightImpact();
    setState(() {
      final current = _variantQuantities[variant.id] ?? 0;
      if (current > 1) {
        _variantQuantities[variant.id] = current - 1;
      } else {
        _variantQuantities.remove(variant.id);
      }
    });
    _controller.decrementItem(widget.item.id);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final size = MediaQuery.of(context).size;
    final data = widget.detailData;

    return Container(
      constraints: BoxConstraints(
        maxHeight: size.height * 0.90,
      ),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        children: [
          // Drag Handle
          Center(
            child: Container(
              margin: const EdgeInsets.only(top: 10, bottom: 12),
              width: 38,
              height: 4.5,
              decoration: BoxDecoration(
                color: isDark ? AppColors.borderDark : const Color(0xFFCBD5E1),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),

          // Scrollable Body Content
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 1. Service Title & Rating Subtitle
                  Text(
                    data.title,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: isDark
                          ? AppColors.textPrimaryDark
                          : const Color(0xFF0F172A),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(
                        Icons.star_rounded,
                        size: 16,
                        color: Color(0xFFF59E0B),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${data.rating} ',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: isDark
                              ? AppColors.textPrimaryDark
                              : const Color(0xFF334155),
                        ),
                      ),
                      Text(
                        '(${data.ratingCount} ratings)',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 12.5,
                          color: isDark
                              ? AppColors.textMutedDark
                              : const Color(0xFF64748B),
                          decoration: TextDecoration.underline,
                          decorationStyle: TextDecorationStyle.dotted,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // 2. Variants List (Single door, Double door, Side by side)
                  if (data.variants.isNotEmpty)
                    Column(
                      children: data.variants.map((variant) {
                        return _buildVariantRow(context, isDark, variant);
                      }).toList(),
                    ),

                  const SizedBox(height: 24),

                  // 3. Service Includes Section
                  if (data.includes.isNotEmpty) ...[
                    Text(
                      'Service includes',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: isDark
                            ? AppColors.textPrimaryDark
                            : const Color(0xFF0F172A),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Column(
                      children: data.includes.map((point) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '• ',
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w900,
                                  color: isDark
                                      ? AppColors.textMutedDark
                                      : const Color(0xFF64748B),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  point,
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 13,
                                    height: 1.4,
                                    color: isDark
                                        ? AppColors.textSecondaryDark
                                        : const Color(0xFF334155),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 20),
                  ],

                  // 4. Service Does Not Include Section
                  if (data.excludes.isNotEmpty) ...[
                    Text(
                      'Service does not includes',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: isDark
                            ? AppColors.textPrimaryDark
                            : const Color(0xFF0F172A),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Column(
                      children: data.excludes.map((point) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '• ',
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w900,
                                  color: isDark
                                      ? AppColors.textMutedDark
                                      : const Color(0xFF64748B),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  point,
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 13,
                                    height: 1.4,
                                    color: isDark
                                        ? AppColors.textSecondaryDark
                                        : const Color(0xFF334155),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 20),
                  ],

                  // 5. Ratings & Reviews Breakdown Card
                  _buildRatingsAndReviewsCard(context, isDark, data),

                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),

          // Sticky Bottom Action Bar
          _buildStickyBottomBar(context, isDark),
        ],
      ),
    );
  }

  Widget _buildVariantRow(
      BuildContext context, bool isDark, KitchenServiceVariant variant) {
    final qty = _variantQuantities[variant.id] ?? 0;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: isDark
                ? AppColors.borderDark
                : const Color(0xFFF1F5F9),
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left: Variant Title, Duration, Price
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  variant.name,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: isDark
                        ? AppColors.textPrimaryDark
                        : const Color(0xFF1E293B),
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(
                      Icons.schedule_rounded,
                      size: 13,
                      color: Color(0xFF64748B),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      variant.duration,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: isDark
                            ? AppColors.textMutedDark
                            : const Color(0xFF64748B),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  '₹${variant.price.toStringAsFixed(0)}',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                    color: isDark
                        ? AppColors.textPrimaryDark
                        : const Color(0xFF0F172A),
                  ),
                ),
              ],
            ),
          ),

          // Right: Add Button or [- Qty +] Counter
          if (qty <= 0)
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFF0F766E),
                backgroundColor: isDark
                    ? AppColors.primaryLight.withValues(alpha: 0.1)
                    : const Color(0xFFF0FDF4),
                side: const BorderSide(color: Color(0xFF0F766E), width: 1.2),
                minimumSize: const Size(80, 36),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
              ),
              onPressed: () => _incrementVariant(variant),
              child: Text(
                'Add',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w800,
                ),
              ),
            )
          else
            Container(
              height: 36,
              decoration: BoxDecoration(
                color: const Color(0xFF0F766E),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    constraints:
                        const BoxConstraints(minWidth: 32, minHeight: 36),
                    padding: EdgeInsets.zero,
                    icon:
                        const Icon(Icons.remove, size: 16, color: Colors.white),
                    onPressed: () => _decrementVariant(variant),
                  ),
                  Text(
                    '$qty',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 13.5,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                  IconButton(
                    constraints:
                        const BoxConstraints(minWidth: 32, minHeight: 36),
                    padding: EdgeInsets.zero,
                    icon: const Icon(Icons.add, size: 16, color: Colors.white),
                    onPressed: () => _incrementVariant(variant),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildRatingsAndReviewsCard(
      BuildContext context, bool isDark, KitchenSingleServiceDetailData data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Ratings & Reviews',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 16,
            fontWeight: FontWeight.w800,
            color: isDark
                ? AppColors.textPrimaryDark
                : const Color(0xFF0F172A),
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isDark
                ? AppColors.surfaceVariantDark.withValues(alpha: 0.4)
                : const Color(0xFFF8FAFC),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isDark ? AppColors.borderDark : const Color(0xFFE2E8F0),
            ),
          ),
          child: Row(
            children: [
              // Large Rating Number
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${data.rating}',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 36,
                      fontWeight: FontWeight.w900,
                      color: isDark
                          ? AppColors.textPrimaryDark
                          : const Color(0xFF0F172A),
                    ),
                  ),
                ],
              ),

              const SizedBox(width: 20),

              // Star Count Bars
              Expanded(
                child: Column(
                  children: [
                    _buildStarBar(isDark, starNum: 5, fillPercent: 0.85, countStr: '20299'),
                    _buildStarBar(isDark, starNum: 4, fillPercent: 0.15, countStr: '636'),
                    _buildStarBar(isDark, starNum: 3, fillPercent: 0.08, countStr: '348'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStarBar(
    bool isDark, {
    required int starNum,
    required double fillPercent,
    required String countStr,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Icon(
            Icons.star_outline_rounded,
            size: 13,
            color: isDark ? AppColors.textMutedDark : const Color(0xFF64748B),
          ),
          const SizedBox(width: 4),
          Text(
            '$starNum',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: isDark ? AppColors.textMutedDark : const Color(0xFF64748B),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: fillPercent,
                minHeight: 6,
                backgroundColor: isDark
                    ? const Color(0xFF334155)
                    : const Color(0xFFE2E8F0),
                valueColor: const AlwaysStoppedAnimation<Color>(
                  Color(0xFF1E293B),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          SizedBox(
            width: 42,
            child: Text(
              countStr,
              textAlign: TextAlign.end,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: isDark ? AppColors.textMutedDark : const Color(0xFF64748B),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStickyBottomBar(BuildContext context, bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          width: double.infinity,
          height: 46,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                width: 130,
                height: 44,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0F766E), // Teal Accent
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 0,
                  ),
                  onPressed: () {
                    HapticFeedback.lightImpact();
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Proceed',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 14.5,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
