import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sewasetu/shared/widgets/app_network_image.dart';
import '../data/kitchen_cleaning_data.dart';
import '../models/kitchen_cleaning_model.dart';
import 'kitchen_cleaning_item_detail_sheet.dart';
import 'kitchen_cleaning_options_sheet.dart';
import 'kitchen_cleaning_package_detail_sheet.dart';

/// Premium Service item card matching the exact reference screenshot (media_1790958182626.jpg).
/// Left column flows seamlessly from price directly into bullet points and View Details, eliminating vertical gaps.
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

  void _handleViewDetails(BuildContext context) {
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
      final singleDetailData =
          KitchenCleaningData.getSingleServiceDetailData(item);
      KitchenCleaningItemDetailSheet.show(
        context,
        item: item,
        detailData: singleDetailData,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardBgColor = isDark ? const Color(0xFF172033) : Colors.white;
    final cardBorderColor =
        isDark ? const Color(0xFF26334D) : const Color(0xFFE2E8F0);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardBgColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: cardBorderColor,
          width: 1.1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.04),
            blurRadius: 12,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left Column: Badge, Title, Rating/Duration, Price, Bullets & View Details
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Badge Text (e.g. Essential ★)
                if (item.badgeText != null) ...[
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 9, vertical: 3.5),
                    margin: const EdgeInsets.only(bottom: 8),
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

                // Title
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: Text(
                        item.title,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 17.5,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.2,
                          color: isDark
                              ? Colors.white
                              : const Color(0xFF0F172A),
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

                const SizedBox(height: 5),

                // Rating & Duration Row (★ 4.75 (4K+) • 🕒 2 hrs 30 mins)
                Row(
                  children: [
                    const Icon(
                      Icons.star_rounded,
                      size: 16,
                      color: Color(0xFFF59E0B),
                    ),
                    const SizedBox(width: 3),
                    Text(
                      '${item.rating} ',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w700,
                        color: isDark
                            ? Colors.white
                            : const Color(0xFF1E293B),
                      ),
                    ),
                    Text(
                      '(${item.ratingCount})',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 12,
                        color: isDark
                            ? const Color(0xFF94A3B8)
                            : const Color(0xFF64748B),
                        decoration: TextDecoration.underline,
                        decorationStyle: TextDecorationStyle.dotted,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      '•',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 12,
                        color: isDark
                            ? const Color(0xFF64748B)
                            : const Color(0xFF94A3B8),
                      ),
                    ),
                    const SizedBox(width: 6),
                    const Icon(
                      Icons.schedule_rounded,
                      size: 13,
                      color: Color(0xFF94A3B8),
                    ),
                    const SizedBox(width: 3),
                    Text(
                      item.duration,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: isDark
                            ? const Color(0xFF94A3B8)
                            : const Color(0xFF64748B),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                // Price Section (Starts at ₹379 or ₹849)
                _buildPriceWidget(isDark),

                // Bullet Points Summary List (flows directly under price without gaps)
                if (item.bulletPoints.isNotEmpty) ...[
                  const SizedBox(height: 10),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: item.bulletPoints.map((bullet) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '• ',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: isDark
                                    ? const Color(0xFF94A3B8)
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
                                      ? const Color(0xFFCBD5E1)
                                      : const Color(0xFF334155),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ] else if (item.description != null) ...[
                  const SizedBox(height: 8),
                  Text(
                    item.description!,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12.5,
                      height: 1.35,
                      color: isDark
                          ? const Color(0xFFCBD5E1)
                          : const Color(0xFF334155),
                    ),
                  ),
                ],

                const SizedBox(height: 8),

                // View details > Action (flows directly under bullets / price)
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () => _handleViewDetails(context),
                    borderRadius: BorderRadius.circular(4),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 2),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'View details',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 12.5,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF818CF8),
                            ),
                          ),
                          const SizedBox(width: 2),
                          const Icon(
                            Icons.chevron_right_rounded,
                            size: 16,
                            color: Color(0xFF818CF8),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 12),

          // Right Column: Image + Add Button + Options Count
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (item.imageUrl != null &&
                  item.imageUrl!.isNotEmpty) ...[
                Container(
                  width: 90,
                  height: 86,
                  margin: const EdgeInsets.only(bottom: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: isDark
                          ? const Color(0xFF26334D)
                          : const Color(0xFFE2E8F0),
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: AppNetworkImage(
                      imageUrl: item.imageUrl!,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],

              // Add Button / Counter Widget
              _buildAddButton(context, isDark),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPriceWidget(bool isDark) {
    final text = item.startsAtText ?? '₹${item.price.toStringAsFixed(0)}';

    if (text.startsWith('Starts at ')) {
      final pricePart = text.replaceFirst('Starts at ', '');
      return RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Starts at ',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.white : const Color(0xFF334155),
              ),
            ),
            TextSpan(
              text: pricePart,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 18,
                fontWeight: FontWeight.w900,
                color: isDark ? Colors.white : const Color(0xFF0F172A),
              ),
            ),
          ],
        ),
      );
    }

    return Text(
      text,
      style: GoogleFonts.plusJakartaSans(
        fontSize: 18,
        fontWeight: FontWeight.w900,
        color: isDark ? Colors.white : const Color(0xFF0F172A),
      ),
    );
  }

  Widget _buildAddButton(BuildContext context, bool isDark) {
    if (quantity <= 0) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 90,
            height: 36,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFF0F766E),
                backgroundColor: isDark
                    ? const Color(0xFF132338)
                    : const Color(0xFFF0FDF4),
                side: const BorderSide(color: Color(0xFF0F766E), width: 1.2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.zero,
              ),
              onPressed: () {
                HapticFeedback.lightImpact();
                _handleViewDetails(context);
              },
              child: Text(
                'Add',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w800,
                  color: isDark ? const Color(0xFF14B8A6) : const Color(0xFF0F766E),
                ),
              ),
            ),
          ),
          if (item.hasOptions || item.options.isNotEmpty) ...[
            const SizedBox(height: 4),
            Text(
              '${item.options.length} options',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
              ),
            ),
          ],
        ],
      );
    }

    // Counter Control Widget [ -  1  + ]
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 90,
          height: 36,
          decoration: BoxDecoration(
            color: const Color(0xFF0F766E),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF0F766E).withValues(alpha: 0.3),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  HapticFeedback.lightImpact();
                  onDecrement();
                },
                behavior: HitTestBehavior.opaque,
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                  child: Icon(Icons.remove_rounded, size: 16, color: Colors.white),
                ),
              ),
              Text(
                '$quantity',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 14,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                ),
              ),
              GestureDetector(
                onTap: () {
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
                behavior: HitTestBehavior.opaque,
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                  child: Icon(Icons.add_rounded, size: 16, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
        if (item.hasOptions || item.options.isNotEmpty) ...[
          const SizedBox(height: 4),
          Text(
            '${item.options.length} options',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
            ),
          ),
        ],
      ],
    );
  }
}
