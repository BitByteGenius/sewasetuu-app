import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sewasetu/app/theme/app_colors.dart';
import 'package:sewasetu/shared/widgets/app_network_image.dart';
import '../data/kitchen_cleaning_data.dart';
import '../models/kitchen_cleaning_model.dart';
import 'kitchen_cleaning_options_sheet.dart';
import 'kitchen_cleaning_package_detail_sheet.dart';

/// Premium Service item card matching the exact visual layouts shown in reference photos.
class KitchenCleaningServiceCard extends StatelessWidget {
  final KitchenCleaningServiceItem item;
  final int quantity;
  final bool isExpanded;
  final VoidCallback onToggleExpand;
  final ValueChanged<ServiceOptionItem?> onAdd;
  final VoidCallback onDecrement;
  final VoidCallback? onViewDetails;

  const KitchenCleaningServiceCard({
    super.key,
    required this.item,
    required this.quantity,
    required this.isExpanded,
    required this.onToggleExpand,
    required this.onAdd,
    required this.onDecrement,
    this.onViewDetails,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark ? AppColors.borderDark : const Color(0xFFE2E8F0),
          width: 1.1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.25 : 0.03),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Row: Title, Badge, and Add / Quantity Button
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title & Badge
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (item.badgeText != null) ...[
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 3),
                        margin: const EdgeInsets.only(bottom: 6),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFEF3C7),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          item.badgeText!,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 11,
                            fontWeight: FontWeight.w800,
                            color: const Color(0xFF92400E),
                          ),
                        ),
                      ),
                    ],
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            item.title,
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 17,
                              fontWeight: FontWeight.w800,
                              color: isDark
                                  ? AppColors.textPrimaryDark
                                  : const Color(0xFF1E293B),
                            ),
                          ),
                        ),
                        if (item.isEcoSafe) ...[
                          const SizedBox(width: 6),
                          const Icon(
                            Icons.eco_rounded,
                            size: 18,
                            color: Color(0xFF16A34A),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 4),

                    // Rating & Duration
                    Row(
                      children: [
                        const Icon(
                          Icons.star_rounded,
                          size: 15,
                          color: Color(0xFFF59E0B),
                        ),
                        const SizedBox(width: 2),
                        Text(
                          '${item.rating} ',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 12.5,
                            fontWeight: FontWeight.w700,
                            color: isDark
                                ? AppColors.textPrimaryDark
                                : const Color(0xFF334155),
                          ),
                        ),
                        Text(
                          '(${item.ratingCount})',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 12,
                            color: isDark
                                ? AppColors.textMutedDark
                                : const Color(0xFF64748B),
                            decoration: TextDecoration.underline,
                            decorationStyle: TextDecorationStyle.dotted,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          '•  🕒 ${item.duration}',
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

                    // Price
                    Text(
                      item.startsAtText ?? '₹${item.price.toStringAsFixed(0)}',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 17,
                        fontWeight: FontWeight.w900,
                        color: isDark
                            ? AppColors.textPrimaryDark
                            : const Color(0xFF0F172A),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 12),

              // Right side: Image (if appliance service) & Add / Counter Button
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  if (item.imageUrl != null &&
                      item.imageUrl!.isNotEmpty) ...[
                    Stack(
                      children: [
                        Container(
                          width: 86,
                          height: 86,
                          margin: const EdgeInsets.only(bottom: 6),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: isDark
                                  ? AppColors.borderDark
                                  : const Color(0xFFE2E8F0),
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(13),
                            child: AppNetworkImage(
                              imageUrl: item.imageUrl!,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        if (item.isEcoSafe)
                          Positioned(
                            top: 4,
                            right: 4,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 2),
                              decoration: BoxDecoration(
                                color: const Color(0xFF16A34A),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                'ECO-SAFE',
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 8.5,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],

                  // Add / Quantity Counter Button
                  _buildAddButton(context, isDark),
                ],
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Bullet Points Description
          if (item.bulletPoints.isNotEmpty) ...[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: item.bulletPoints.map((bullet) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '•  ',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: isDark
                              ? AppColors.textMutedDark
                              : const Color(0xFF475569),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          bullet,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 12.5,
                            height: 1.35,
                            color: isDark
                                ? AppColors.textPrimaryDark.withValues(alpha: 0.9)
                                : const Color(0xFF334155),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],

          if (item.description != null && item.bulletPoints.isEmpty) ...[
            Text(
              item.description!,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 12.5,
                height: 1.35,
                color: isDark
                    ? AppColors.textPrimaryDark.withValues(alpha: 0.9)
                    : const Color(0xFF334155),
              ),
            ),
          ],

          const SizedBox(height: 6),

          // View details > trigger comparison package sheet or toggle details
          InkWell(
            onTap: () {
              HapticFeedback.selectionClick();
              if (onViewDetails != null) {
                onViewDetails!();
              } else if (item.sectionId == 'occupied' ||
                  item.sectionId == 'empty' ||
                  item.id.contains('occ') ||
                  item.id.contains('emp') ||
                  item.title.toLowerCase().contains('occupied') ||
                  item.title.toLowerCase().contains('empty')) {
                final detailData = KitchenCleaningData.getDetailData(
                    item.id.isNotEmpty ? item.id : item.title);
                KitchenCleaningPackageDetailSheet.show(
                  context,
                  detailData: detailData,
                  onProceed: (selectedPkg) {
                    final opt = ServiceOptionItem(
                      id: selectedPkg.id,
                      name: selectedPkg.title,
                      price: selectedPkg.price,
                    );
                    onAdd(opt);
                  },
                );
              } else {
                onToggleExpand();
              }
            },
            borderRadius: BorderRadius.circular(4),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'View details',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF4338CA), // Deep Indigo
                    ),
                  ),
                  const SizedBox(width: 2),
                  const Icon(
                    Icons.keyboard_arrow_right_rounded,
                    size: 16,
                    color: Color(0xFF4338CA),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddButton(BuildContext context, bool isDark) {
    if (quantity <= 0) {
      return Column(
        children: [
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
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            ),
            onPressed: () {
              HapticFeedback.lightImpact();
              if (item.hasOptions) {
                KitchenCleaningOptionsSheet.show(
                  context,
                  service: item,
                  onOptionSelected: (opt) => onAdd(opt),
                );
              } else {
                onAdd(null);
              }
            },
            child: Text(
              'Add',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 13.5,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          if (item.hasOptions) ...[
            const SizedBox(height: 3),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: isDark ? AppColors.surfaceDark : const Color(0xFFF1F5F9),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                '${item.options.length} options',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: isDark
                      ? AppColors.textMutedDark
                      : const Color(0xFF64748B),
                ),
              ),
            ),
          ],
        ],
      );
    }

    // Counter Control Widget [ - 1 + ]
    return Container(
      height: 36,
      decoration: BoxDecoration(
        color: const Color(0xFF0F766E),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            constraints: const BoxConstraints(minWidth: 32, minHeight: 36),
            padding: EdgeInsets.zero,
            icon: const Icon(Icons.remove, size: 16, color: Colors.white),
            onPressed: () {
              HapticFeedback.lightImpact();
              onDecrement();
            },
          ),
          Text(
            '$quantity',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 13.5,
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
          ),
          IconButton(
            constraints: const BoxConstraints(minWidth: 32, minHeight: 36),
            padding: EdgeInsets.zero,
            icon: const Icon(Icons.add, size: 16, color: Colors.white),
            onPressed: () {
              HapticFeedback.lightImpact();
              onAdd(null);
            },
          ),
        ],
      ),
    );
  }
}
