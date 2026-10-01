import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sewasetu/app/theme/app_colors.dart';
import '../models/kitchen_cleaning_model.dart';

/// Expandable Accordion Frequently Asked Questions widget matching reference mockups.
class KitchenCleaningFaqWidget extends StatelessWidget {
  final List<KitchenFaqItem> faqItems;
  final Set<String> expandedIds;
  final ValueChanged<String> onToggle;

  const KitchenCleaningFaqWidget({
    super.key,
    required this.faqItems,
    required this.expandedIds,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    if (faqItems.isEmpty) return const SizedBox.shrink();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 12),
          child: Text(
            'Frequently asked questions',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: isDark ? AppColors.textPrimaryDark : const Color(0xFF1E293B),
            ),
          ),
        ),
        ...faqItems.map((item) {
          final isExpanded = expandedIds.contains(item.id);

          return Column(
            children: [
              InkWell(
                onTap: () => onToggle(item.id),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          item.question,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            height: 1.35,
                            color: isDark
                                ? AppColors.primaryLight
                                : const Color(0xFF0F766E),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Icon(
                        isExpanded ? Icons.close_rounded : Icons.add_rounded,
                        size: 20,
                        color: isDark
                            ? AppColors.textPrimaryDark
                            : const Color(0xFF1E293B),
                      ),
                    ],
                  ),
                ),
              ),

              if (isExpanded)
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 14),
                  child: Text(
                    item.answer,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 13,
                      height: 1.45,
                      color: isDark
                          ? AppColors.textMutedDark
                          : const Color(0xFF475569),
                    ),
                  ),
                ),

              Divider(
                height: 1,
                indent: 16,
                endIndent: 16,
                color: isDark ? AppColors.borderDark : const Color(0xFFF1F5F9),
              ),
            ],
          );
        }),
      ],
    );
  }
}
