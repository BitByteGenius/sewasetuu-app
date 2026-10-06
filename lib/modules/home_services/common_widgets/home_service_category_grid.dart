import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sewasetu/app/theme/app_colors.dart';
import '../electrician/models/home_service_model.dart';

/// Reusable Category Shortcut Grid widget for Home Service modules.
/// Features state-driven category selection, active item highlighting,
/// and smooth **Show More / Show Less** toggle support.
class HomeServiceCategoryGrid extends StatelessWidget {
  final List<HomeServiceCategory> categories;
  final String activeCategoryId;
  final bool isExpanded;
  final int initialVisibleCount;
  final ValueChanged<String> onCategorySelected;
  final VoidCallback onToggleExpand;

  const HomeServiceCategoryGrid({
    super.key,
    required this.categories,
    required this.activeCategoryId,
    required this.isExpanded,
    this.initialVisibleCount = 8,
    required this.onCategorySelected,
    required this.onToggleExpand,
  });

  @override
  Widget build(BuildContext context) {
    if (categories.isEmpty) return const SizedBox.shrink();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final visibleCategories = (isExpanded || categories.length <= initialVisibleCount)
        ? categories
        : categories.take(initialVisibleCount).toList();

    final remainingCount = categories.length - initialVisibleCount;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(12),
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
          // Header Label & "All" Reset Pill
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Select Category',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 14.5,
                  fontWeight: FontWeight.w800,
                  color: isDark ? AppColors.textPrimaryDark : const Color(0xFF1E293B),
                ),
              ),
              if (activeCategoryId.isNotEmpty && activeCategoryId != 'all')
                InkWell(
                  onTap: () {
                    HapticFeedback.lightImpact();
                    onCategorySelected('all');
                  },
                  borderRadius: BorderRadius.circular(8),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    child: Text(
                      'Clear Selection',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF0F766E),
                      ),
                    ),
                  ),
                ),
            ],
          ),

          const SizedBox(height: 10),

          // Categories Grid
          LayoutBuilder(
            builder: (context, constraints) {
              const crossAxisCount = 4;
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: visibleCategories.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.85,
                ),
                itemBuilder: (context, index) {
                  final cat = visibleCategories[index];
                  final isSelected = activeCategoryId == cat.id;

                  return Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(14),
                      onTap: () {
                        HapticFeedback.lightImpact();
                        onCategorySelected(cat.id);
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? (isDark
                                  ? AppColors.primaryLight.withValues(alpha: 0.15)
                                  : const Color(0xFFF0FDF4))
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: isSelected
                                ? (isDark
                                    ? AppColors.primaryLight
                                    : const Color(0xFF0F766E))
                                : (isDark
                                    ? AppColors.borderDark.withValues(alpha: 0.5)
                                    : const Color(0xFFF1F5F9)),
                            width: isSelected ? 1.4 : 1.0,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Category Icon Container
                            Container(
                              width: 44,
                              height: 44,
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? const Color(0xFF0F766E)
                                    : (isDark
                                        ? const Color(0xFF1E293B)
                                        : const Color(0xFFF1F5F9)),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                cat.icon ?? Icons.category_rounded,
                                size: 22,
                                color: isSelected
                                    ? Colors.white
                                    : (isDark
                                        ? const Color(0xFF94A3B8)
                                        : const Color(0xFF475569)),
                              ),
                            ),

                            const SizedBox(height: 6),

                            // Category Name
                            Text(
                              cat.name,
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 11,
                                fontWeight:
                                    isSelected ? FontWeight.w800 : FontWeight.w600,
                                height: 1.15,
                                color: isSelected
                                    ? (isDark
                                        ? AppColors.primaryLight
                                        : const Color(0xFF0F766E))
                                    : (isDark
                                        ? AppColors.textPrimaryDark
                                        : const Color(0xFF334155)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),

          // Show More / Show Less Toggle Button
          if (categories.length > initialVisibleCount) ...[
            const SizedBox(height: 10),
            Center(
              child: TextButton.icon(
                style: TextButton.styleFrom(
                  foregroundColor: const Color(0xFF0F766E),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  HapticFeedback.lightImpact();
                  onToggleExpand();
                },
                icon: Icon(
                  isExpanded
                      ? Icons.keyboard_arrow_up_rounded
                      : Icons.keyboard_arrow_down_rounded,
                  size: 20,
                ),
                label: Text(
                  isExpanded
                      ? 'Show Less'
                      : 'Show More (${remainingCount > 0 ? "+$remainingCount" : ""})',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
