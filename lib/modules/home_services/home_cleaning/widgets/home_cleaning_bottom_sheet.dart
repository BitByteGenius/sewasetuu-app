import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sewasetu/app/theme/app_colors.dart';
import 'package:sewasetu/shared/widgets/app_network_image.dart';
import '../controller/home_cleaning_controller.dart';
import '../models/home_cleaning_category_model.dart';

/// Modal Bottom Sheet displaying the Home Cleaning category options grid
/// matching the provided UI mockup.
class HomeCleaningBottomSheet extends StatelessWidget {
  const HomeCleaningBottomSheet({super.key});

  /// Helper method to present the modal bottom sheet from anywhere in the app
  static Future<T?> show<T>(BuildContext context) {
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withValues(alpha: 0.5),
      builder: (context) => const HomeCleaningBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Row: Title & Circular Close ('X') button
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 20, 20, 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Home Cleaning',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: isDark
                          ? AppColors.textPrimaryDark
                          : const Color(0xFF1E293B),
                    ),
                  ),
                  InkWell(
                    onTap: () => Navigator.of(context).pop(),
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isDark
                            ? AppColors.surfaceVariantDark
                            : const Color(0xFFF1F5F9),
                      ),
                      child: Icon(
                        Icons.close_rounded,
                        size: 20,
                        color: isDark
                            ? Colors.white
                            : const Color(0xFF334155),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Content Grid
            const HomeCleaningBottomSheetContent(),
          ],
        ),
      ),
    );
  }
}

/// Reusable Grid Content widget for Home Cleaning sub-categories
class HomeCleaningBottomSheetContent extends StatelessWidget {
  const HomeCleaningBottomSheetContent({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final controller = Get.isRegistered<HomeCleaningController>()
        ? Get.find<HomeCleaningController>()
        : Get.put(HomeCleaningController());

    return Obx(() {
      final categories = controller.categories;

      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(24, 8, 24, 32),
        itemCount: categories.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 18,
          mainAxisSpacing: 22,
          childAspectRatio: 0.72,
        ),
        itemBuilder: (context, index) {
          final item = categories[index];
          return _buildCategoryCard(context, item, controller, isDark);
        },
      );
    });
  }

  Widget _buildCategoryCard(
    BuildContext context,
    HomeCleaningCategoryModel item,
    HomeCleaningController controller,
    bool isDark,
  ) {
    return GestureDetector(
      onTap: () => controller.onCategorySelected(item),
      behavior: HitTestBehavior.opaque,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Top Square Image Container
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: isDark ? AppColors.surfaceDark : const Color(0xFFFAFAFA),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isDark
                      ? AppColors.borderDark
                      : const Color(0xFFE2E8F0),
                  width: 1.2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.03),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(18.8),
                child: AppNetworkImage(
                  imageUrl: item.imageUrl,
                  fit: BoxFit.cover,
                  errorWidget: Center(
                    child: Icon(
                      item.fallbackIcon,
                      size: 34,
                      color: isDark
                          ? AppColors.textMutedDark
                          : const Color(0xFF64748B),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),

          // Sub-category Title Label
          Text(
            item.title,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 13.5,
              fontWeight: FontWeight.w600,
              height: 1.2,
              color: isDark
                  ? AppColors.textPrimaryDark
                  : const Color(0xFF1E293B),
            ),
          ),
        ],
      ),
    );
  }
}
