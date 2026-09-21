import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sewasetu/app/theme/app_colors.dart';
import 'package:sewasetu/shared/widgets/app_network_image.dart';
import '../models/service_subcategory_item.dart';

/// Horizontally scrolling circular subcategory service items with "See All >" header
class ServicesCircularSubcategoriesWidget extends StatelessWidget {
  final String title;
  final List<ServiceSubcategoryItem> items;
  final VoidCallback onSeeAll;
  final ValueChanged<ServiceSubcategoryItem> onItemTap;
  final Color ringColor;

  const ServicesCircularSubcategoriesWidget({
    super.key,
    required this.title,
    required this.items,
    required this.onSeeAll,
    required this.onItemTap,
    this.ringColor = const Color(0xFFF43F5E), // Coral/pink ring as seen in screenshot
  });

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return const SizedBox.shrink();

    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header with "See All >"
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.3,
                    color: isDark ? AppColors.textPrimaryDark : const Color(0xFF0F172A),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              InkWell(
                onTap: onSeeAll,
                borderRadius: BorderRadius.circular(8),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'See All',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: isDark ? AppColors.primaryLight : const Color(0xFF0F766E),
                        ),
                      ),
                      const SizedBox(width: 2),
                      Icon(
                        Icons.chevron_right_rounded,
                        size: 16,
                        color: isDark ? AppColors.primaryLight : const Color(0xFF0F766E),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),

        // Horizontal Circular List
        SizedBox(
          height: 115,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: items.length,
            separatorBuilder: (context, index) => const SizedBox(width: 14),
            itemBuilder: (context, index) {
              final item = items[index];
              return _buildCircularItem(context, item, isDark);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCircularItem(BuildContext context, ServiceSubcategoryItem item, bool isDark) {
    return GestureDetector(
      onTap: () => onItemTap(item),
      child: SizedBox(
        width: 76,
        child: Column(
          children: [
            // Circular image container with accent ring
            Container(
              width: 68,
              height: 68,
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: ringColor.withValues(alpha: isDark ? 0.7 : 0.6),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.06),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: ClipOval(
                child: AppNetworkImage(
                  imageUrl: item.imageUrl,
                  fit: BoxFit.cover,
                  width: 64,
                  height: 64,
                ),
              ),
            ),
            const SizedBox(height: 6),

            // Category Label below circle
            Text(
              item.name,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                height: 1.15,
                color: isDark ? AppColors.textPrimaryDark : const Color(0xFF1E293B),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
