import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sewasetu/app/theme/app_colors.dart';
import 'package:sewasetu/shared/widgets/app_network_image.dart';
import '../models/kitchen_cleaning_model.dart';
import 'kitchen_cleaning_options_sheet.dart';

/// 2-Column Grid widget for Mini Services section matching reference image 5.
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
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 12),
          child: Text(
            'Mini Services',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: isDark ? AppColors.textPrimaryDark : const Color(0xFF1E293B),
            ),
          ),
        ),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: items.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 14,
            mainAxisSpacing: 16,
            childAspectRatio: 0.72,
          ),
          itemBuilder: (context, index) {
            final item = items[index];
            final qty = getItemQuantity(item.id);
            return _buildMiniCard(context, item, qty, isDark);
          },
        ),
      ],
    );
  }

  Widget _buildMiniCard(
    BuildContext context,
    KitchenCleaningServiceItem item,
    int qty,
    bool isDark,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? AppColors.borderDark : const Color(0xFFE2E8F0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.03),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Image Container with floating Add button
          Stack(
            children: [
              Container(
                height: 120,
                width: double.infinity,
                decoration: const BoxDecoration(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(15)),
                ),
                child: ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(15)),
                  child: AppNetworkImage(
                    imageUrl: item.imageUrl ?? '',
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              // Floating Add Button / Counter at bottom right of image
              Positioned(
                bottom: 8,
                right: 8,
                child: _buildMiniAddButton(context, item, qty, isDark),
              ),
            ],
          ),

          // Bottom Content
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: isDark
                        ? AppColors.textPrimaryDark
                        : const Color(0xFF1E293B),
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),

                Text(
                  '🕒 ${item.duration}',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 11,
                    color: isDark
                        ? AppColors.textMutedDark
                        : const Color(0xFF64748B),
                  ),
                ),
                const SizedBox(height: 4),

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
                const SizedBox(height: 4),

                Text(
                  'View details >',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF4338CA),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMiniAddButton(
    BuildContext context,
    KitchenCleaningServiceItem item,
    int qty,
    bool isDark,
  ) {
    if (qty <= 0) {
      return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: const Color(0xFF0F766E),
          elevation: 2,
          minimumSize: const Size(60, 28),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: const BorderSide(color: Color(0xFF0F766E)),
          ),
        ),
        onPressed: () {
          HapticFeedback.lightImpact();
          if (item.hasOptions) {
            KitchenCleaningOptionsSheet.show(
              context,
              service: item,
              onOptionSelected: (opt) => onAdd(item),
            );
          } else {
            onAdd(item);
          }
        },
        child: Text(
          'Add',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 11.5,
            fontWeight: FontWeight.w900,
          ),
        ),
      );
    }

    return Container(
      height: 28,
      decoration: BoxDecoration(
        color: const Color(0xFF0F766E),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            constraints: const BoxConstraints(minWidth: 24, minHeight: 28),
            padding: EdgeInsets.zero,
            icon: const Icon(Icons.remove, size: 14, color: Colors.white),
            onPressed: () {
              HapticFeedback.lightImpact();
              onDecrement(item.id);
            },
          ),
          Text(
            '$qty',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 12,
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
          ),
          IconButton(
            constraints: const BoxConstraints(minWidth: 24, minHeight: 28),
            padding: EdgeInsets.zero,
            icon: const Icon(Icons.add, size: 14, color: Colors.white),
            onPressed: () {
              HapticFeedback.lightImpact();
              onAdd(item);
            },
          ),
        ],
      ),
    );
  }
}
