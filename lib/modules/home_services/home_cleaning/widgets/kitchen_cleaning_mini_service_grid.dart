import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sewasetu/app/theme/app_colors.dart';
import 'package:sewasetu/shared/widgets/app_network_image.dart';
import '../data/kitchen_cleaning_data.dart';
import '../models/kitchen_cleaning_model.dart';
import 'kitchen_cleaning_item_detail_sheet.dart';

/// 2-Column Grid widget for Mini Services section with compact premium modern cards.
class KitchenCleaningMiniServiceGrid extends StatelessWidget {
  final List<KitchenCleaningServiceItem> items;
  final Function(String serviceId) getItemQuantity;
  final ValueChanged<KitchenCleaningServiceItem> onAdd;
  final ValueChanged<String> onDecrement;

  const KitchenCleaningMiniServiceGrid({
    super.key,
    required this.items,
    required this.getItemQuantity,
    required this.onAdd,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return const SizedBox.shrink();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header Section with count pill
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 10),
          child: Row(
            children: [
              Text(
                'Mini Services',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.3,
                  color: isDark
                      ? AppColors.textPrimaryDark
                      : const Color(0xFF0F172A),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                decoration: BoxDecoration(
                  color: isDark
                      ? AppColors.primaryLight.withValues(alpha: 0.15)
                      : const Color(0xFFCCFBF1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  '${items.length}',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                    color: isDark
                        ? AppColors.primaryLight
                        : const Color(0xFF0F766E),
                  ),
                ),
              ),
            ],
          ),
        ),

        // Grid Builder with compact ratio (0.67-0.70)
        LayoutBuilder(
          builder: (context, constraints) {
            final screenWidth = MediaQuery.of(context).size.width;
            final double childAspectRatio = screenWidth < 360
                ? 0.78
                : (screenWidth < 400 ? 0.82 : 0.85);

            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: items.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: childAspectRatio,
              ),
              itemBuilder: (context, index) {
                final item = items[index];
                return Obx(() {
                  final qty = getItemQuantity(item.id);
                  return _MiniServiceCard(
                    key: ValueKey(item.id),
                    item: item,
                    qty: qty,
                    isDark: isDark,
                    onAdd: onAdd,
                    onDecrement: onDecrement,
                  );
                });
              },
            );
          },
        ),
      ],
    );
  }
}

class _MiniServiceCard extends StatefulWidget {
  final KitchenCleaningServiceItem item;
  final int qty;
  final bool isDark;
  final ValueChanged<KitchenCleaningServiceItem> onAdd;
  final ValueChanged<String> onDecrement;

  const _MiniServiceCard({
    super.key,
    required this.item,
    required this.qty,
    required this.isDark,
    required this.onAdd,
    required this.onDecrement,
  });

  @override
  State<_MiniServiceCard> createState() => _MiniServiceCardState();
}

class _MiniServiceCardState extends State<_MiniServiceCard> {
  bool _isPressed = false;

  void _handleCardTap() {
    HapticFeedback.lightImpact();
    final singleDetailData =
        KitchenCleaningData.getSingleServiceDetailData(widget.item);
    KitchenCleaningItemDetailSheet.show(
      context,
      item: widget.item,
      detailData: singleDetailData,
    );
  }

  void _handleAddPressed() {
    HapticFeedback.lightImpact();
    if (widget.qty > 0) {
      // Service can only be added once. Tapping ADDED removes it.
      widget.onDecrement(widget.item.id);
    } else {
      _handleCardTap();
    }
  }

  @override
  Widget build(BuildContext context) {
    final item = widget.item;
    final qty = widget.qty;
    final isDark = widget.isDark;
    final isSelected = qty > 0;

    return AnimatedScale(
      scale: _isPressed ? 0.97 : 1.0,
      duration: const Duration(milliseconds: 120),
      curve: Curves.easeOutCubic,
      child: Container(
        decoration: BoxDecoration(
          color: isDark ? AppColors.surfaceDark : Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF0F766E)
                : (isDark ? AppColors.borderDark : const Color(0xFFE2E8F0)),
            width: isSelected ? 1.5 : 1.0,
          ),
          boxShadow: [
            BoxShadow(
              color: isDark
                  ? Colors.black.withValues(alpha: 0.25)
                  : const Color(0xFF0F172A).withValues(alpha: 0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTapDown: (_) => setState(() => _isPressed = true),
            onTapUp: (_) => setState(() => _isPressed = false),
            onTapCancel: () => setState(() => _isPressed = false),
            onTap: _handleCardTap,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Image Container (compact height: 90)
                Stack(
                  children: [
                    Container(
                      height: 90,
                      width: double.infinity,
                      color: isDark
                          ? AppColors.surfaceVariantDark
                          : const Color(0xFFF1F5F9),
                      child: AppNetworkImage(
                        imageUrl: item.imageUrl ?? '',
                        fit: BoxFit.cover,
                      ),
                    ),

                    // Subtle Dark Gradient Overlay at bottom of image for contrast
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withValues(alpha: 0.05),
                              Colors.black.withValues(alpha: 0.25),
                            ],
                            stops: const [0.4, 0.7, 1.0],
                          ),
                        ),
                      ),
                    ),

                    // Top Left Eco Badge or Tag if present
                    if (item.isEcoSafe || item.badgeText != null)
                      Positioned(
                        top: 6,
                        left: 6,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 2),
                          decoration: BoxDecoration(
                            color: item.isEcoSafe
                                ? const Color(0xFF16A34A)
                                : const Color(0xFFFEF3C7),
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.1),
                                blurRadius: 4,
                              ),
                            ],
                          ),
                          child: Text(
                            item.badgeText ?? 'ECO',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 9,
                              fontWeight: FontWeight.w800,
                              color: item.isEcoSafe
                                  ? Colors.white
                                  : const Color(0xFF92400E),
                            ),
                          ),
                        ),
                      ),

                    // Floating Add / Added Button at bottom right of image
                    Positioned(
                      bottom: 6,
                      right: 6,
                      child: _buildMiniAddButton(context, item, isSelected, isDark),
                    ),
                  ],
                ),

                // Bottom Content section filling remaining space
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(9, 7, 9, 7),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Service Title (max 2 lines)
                        Text(
                          item.title,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 12.5,
                            fontWeight: FontWeight.w700,
                            height: 1.2,
                            color: isDark
                                ? AppColors.textPrimaryDark
                                : const Color(0xFF1E293B),
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 3),

                        // Duration info
                        Row(
                          children: [
                            const Icon(
                              Icons.schedule_rounded,
                              size: 11,
                              color: Color(0xFF0F766E),
                            ),
                            const SizedBox(width: 3),
                            Expanded(
                              child: Text(
                                item.duration,
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 10.5,
                                  fontWeight: FontWeight.w600,
                                  color: isDark
                                      ? AppColors.textMutedDark
                                      : const Color(0xFF64748B),
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),

                        // Dynamic Flexible Spacer pushing price and details to bottom
                        const Spacer(),

                        // Subtle Divider before price section
                        Container(
                          height: 1,
                          margin: const EdgeInsets.only(bottom: 4),
                          color: isDark
                              ? AppColors.borderDark.withValues(alpha: 0.5)
                              : const Color(0xFFF1F5F9),
                        ),

                        // Price & View Details Row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              '₹${item.price.toStringAsFixed(0)}',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 14,
                                fontWeight: FontWeight.w900,
                                color: isDark
                                    ? AppColors.textPrimaryDark
                                    : const Color(0xFF0F172A),
                              ),
                            ),

                            InkWell(
                              borderRadius: BorderRadius.circular(4),
                              onTap: _handleCardTap,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 2, vertical: 2),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'View details',
                                      style: GoogleFonts.plusJakartaSans(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w700,
                                        color: const Color(0xFF4338CA),
                                      ),
                                    ),
                                    const Icon(
                                      Icons.chevron_right_rounded,
                                      size: 12,
                                      color: Color(0xFF4338CA),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMiniAddButton(
    BuildContext context,
    KitchenCleaningServiceItem item,
    bool isSelected,
    bool isDark,
  ) {
    if (!isSelected) {
      return Container(
        height: 26,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(7),
          border: Border.all(color: const Color(0xFF0F766E), width: 1.2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.12),
              blurRadius: 3,
              offset: const Offset(0, 1.5),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(6),
            onTap: _handleAddPressed,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 9),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'ADD',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 10.5,
                      fontWeight: FontWeight.w900,
                      color: const Color(0xFF0F766E),
                      letterSpacing: 0.3,
                    ),
                  ),
                  const SizedBox(width: 2),
                  const Icon(
                    Icons.add_rounded,
                    size: 12,
                    color: Color(0xFF0F766E),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    // Selected state: Service added once -> Display "ADDED ✓"
    return Container(
      height: 26,
      decoration: BoxDecoration(
        color: const Color(0xFF0F766E),
        borderRadius: BorderRadius.circular(7),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0F766E).withValues(alpha: 0.3),
            blurRadius: 5,
            offset: const Offset(0, 1.5),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(6),
          onTap: _handleAddPressed,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 7),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.check_rounded,
                  size: 13,
                  color: Colors.white,
                ),
                const SizedBox(width: 2),
                Text(
                  'ADDED',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 10,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    letterSpacing: 0.3,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
