import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sewasetu/app/theme/app_colors.dart';
import 'package:sewasetu/shared/widgets/app_network_image.dart';
import '../models/service_category_item.dart';

/// 4x2 Grid of primary service category cards matching the reference header layout
class ServicesHeaderCategoriesWidget extends StatelessWidget {
  final List<ServiceCategoryItem> categories;
  final ValueChanged<String> onCategoryTap;

  const ServicesHeaderCategoriesWidget({
    super.key,
    required this.categories,
    required this.onCategoryTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Section Title: Home Services
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              'Home Services',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: isDark
                    ? AppColors.textPrimaryDark
                    : const Color(0xFF0F172A),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: categories.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: 0.74,
                mainAxisSpacing: 10,
                crossAxisSpacing: 8,
              ),
              itemBuilder: (context, index) {
                final item = categories[index];
                return _buildCategoryCard(context, item, isDark);
              },
            ),
          )
        ]);
  }

  Widget _buildCategoryCard(
      BuildContext context, ServiceCategoryItem item, bool isDark) {
    return GestureDetector(
      onTap: () => onCategoryTap(item.title.replaceAll('\n', ' ')),
      child: Container(
        decoration: BoxDecoration(
          color: isDark ? AppColors.surfaceDark : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isDark ? AppColors.borderDark : const Color(0xFFE2E8F0),
            width: 1.1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: isDark ? 0.25 : 0.04),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            // Top: Category Title
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
                child: Center(
                  child: Text(
                    item.title,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      height: 1.15,
                      color: isDark
                          ? AppColors.textPrimaryDark
                          : const Color(0xFF1E293B),
                    ),
                  ),
                ),
              ),
            ),

            // Bottom: Image or Instant Services Graphic
            Expanded(
              flex: 6,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
                child: item.isInstant
                    ? _buildInstantServiceGraphic(isDark)
                    : Stack(
                        fit: StackFit.expand,
                        children: [
                          AppNetworkImage(
                            imageUrl: item.imageUrl,
                            fit: BoxFit.cover,
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(15),
                              bottomRight: Radius.circular(15),
                            ),
                          ),
                          // Subtle top gradient shadow
                          DecoratedBox(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  (isDark
                                          ? AppColors.surfaceDark
                                          : Colors.white)
                                      .withValues(alpha: 0.15),
                                  Colors.transparent,
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInstantServiceGraphic(bool isDark) {
    return Container(
      width: double.infinity,
      color: isDark
          ? const Color(0xFF1E1B4B).withValues(alpha: 0.5)
          : const Color(0xFFF5F3FF),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Clock ticks subtle background
          Positioned(
            bottom: -8,
            child: Icon(
              Icons.schedule_rounded,
              size: 44,
              color: const Color(0xFF8B5CF6)
                  .withValues(alpha: isDark ? 0.18 : 0.12),
            ),
          ),
          // Purple lightning & 15 mins badge
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.bolt_rounded,
                color: Color(0xFF6D28D9),
                size: 20,
              ),
              const SizedBox(width: 2),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '15',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      height: 1.0,
                      color: const Color(0xFF5B21B6),
                    ),
                  ),
                  Text(
                    'mins',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 9,
                      fontWeight: FontWeight.w800,
                      height: 1.0,
                      color: const Color(0xFF6D28D9),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
