import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sewasetu/app/theme/app_colors.dart';
import 'package:sewasetu/shared/widgets/app_network_image.dart';
import '../../electrician/screen/carpenter_screen.dart';
import '../../electrician/screen/electrician_screen.dart';
import '../../electrician/screen/plumbing_screen.dart';

/// Modal Bottom Sheet displaying Home Repair Services (Electrician, Plumbing, Carpentry)
/// as a clean, reusable grid matching HomeCleaningBottomSheet architecture.
class HomeRepairBottomSheet extends StatelessWidget {
  const HomeRepairBottomSheet({super.key});

  /// Helper method to present the modal bottom sheet from anywhere in the app
  static Future<T?> show<T>(BuildContext context) {
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withValues(alpha: 0.5),
      builder: (context) => const HomeRepairBottomSheet(),
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
                    'Home Repair Services',
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

            // Content Grid with Electrician, Plumbing, and Carpentry
            const HomeRepairBottomSheetContent(),
          ],
        ),
      ),
    );
  }
}

/// Reusable Grid Content widget displaying Electrician, Plumbing, and Carpentry
class HomeRepairBottomSheetContent extends StatelessWidget {
  const HomeRepairBottomSheetContent({super.key});

  void _navigateTo(Widget screen) {
    if (Get.isBottomSheetOpen ?? false) {
      Get.back();
    }
    Get.to(() => screen);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 32),
      crossAxisCount: 3,
      crossAxisSpacing: 18,
      mainAxisSpacing: 22,
      childAspectRatio: 0.72,
      children: [
        _buildServiceCard(
          context: context,
          isDark: isDark,
          title: 'Electrician',
          imageUrl:
              'https://images.unsplash.com/photo-1621905251189-08b45d6a269e?auto=format&fit=crop&w=500&q=80',
          fallbackIcon: Icons.electrical_services_rounded,
          onTap: () => _navigateTo(const ElectricianScreen()),
        ),
        _buildServiceCard(
          context: context,
          isDark: isDark,
          title: 'Plumbing',
          imageUrl:
              'https://images.unsplash.com/photo-1584622650111-993a426fbf0a?auto=format&fit=crop&w=500&q=80',
          fallbackIcon: Icons.plumbing_rounded,
          onTap: () => _navigateTo(const PlumbingScreen()),
        ),
        _buildServiceCard(
          context: context,
          isDark: isDark,
          title: 'Carpentry',
          imageUrl:
              'https://images.unsplash.com/photo-1538688525198-9b88f6f53126?auto=format&fit=crop&w=500&q=80',
          fallbackIcon: Icons.construction_rounded,
          onTap: () => _navigateTo(const CarpenterScreen()),
        ),
      ],
    );
  }

  Widget _buildServiceCard({
    required BuildContext context,
    required bool isDark,
    required String title,
    required String imageUrl,
    required IconData fallbackIcon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
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
                  imageUrl: imageUrl,
                  fit: BoxFit.cover,
                  errorWidget: Center(
                    child: Icon(
                      fallbackIcon,
                      size: 34,
                      color: const Color(0xFF0F766E),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),

          // Sub-category Title Label
          Text(
            title,
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
