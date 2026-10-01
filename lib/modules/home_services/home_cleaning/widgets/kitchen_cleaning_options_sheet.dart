import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sewasetu/app/theme/app_colors.dart';
import '../models/kitchen_cleaning_model.dart';

/// Modal Bottom Sheet for selecting variant options (e.g. 2 BHK vs 3 BHK, Single Door vs Double Door)
class KitchenCleaningOptionsSheet extends StatefulWidget {
  final KitchenCleaningServiceItem service;
  final ValueChanged<ServiceOptionItem> onOptionSelected;

  const KitchenCleaningOptionsSheet({
    super.key,
    required this.service,
    required this.onOptionSelected,
  });

  static Future<void> show(
    BuildContext context, {
    required KitchenCleaningServiceItem service,
    required ValueChanged<ServiceOptionItem> onOptionSelected,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => KitchenCleaningOptionsSheet(
        service: service,
        onOptionSelected: onOptionSelected,
      ),
    );
  }

  @override
  State<KitchenCleaningOptionsSheet> createState() =>
      _KitchenCleaningOptionsSheetState();
}

class _KitchenCleaningOptionsSheetState
    extends State<KitchenCleaningOptionsSheet> {
  late ServiceOptionItem selectedOption;

  @override
  void initState() {
    super.initState();
    selectedOption = widget.service.options.isNotEmpty
        ? widget.service.options.first
        : ServiceOptionItem(
            id: 'default',
            name: widget.service.title,
            price: widget.service.price,
          );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Handle bar
            Center(
              child: Container(
                margin: const EdgeInsets.only(top: 12, bottom: 8),
                width: 36,
                height: 4,
                decoration: BoxDecoration(
                  color: isDark ? AppColors.borderDark : const Color(0xFFCBD5E1),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),

            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 16, 12),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.service.title,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: isDark
                                ? AppColors.textPrimaryDark
                                : const Color(0xFF1E293B),
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Select an option below',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 12.5,
                            color: isDark
                                ? AppColors.textMutedDark
                                : const Color(0xFF64748B),
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close_rounded, size: 22),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),

            // Options Radio List
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Column(
                  children: widget.service.options.map((opt) {
                    final isSelected = selectedOption.id == opt.id;

                    return Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? (isDark
                                ? AppColors.primaryLight.withValues(alpha: 0.12)
                                : const Color(0xFFF0FDF4))
                            : (isDark
                                ? AppColors.surfaceVariantDark
                                : const Color(0xFFF8FAFC)),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: isSelected
                              ? const Color(0xFF0F766E)
                              : (isDark
                                  ? AppColors.borderDark
                                  : const Color(0xFFE2E8F0)),
                          width: isSelected ? 1.8 : 1.0,
                        ),
                      ),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            selectedOption = opt;
                          });
                        },
                        borderRadius: BorderRadius.circular(14),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 14),
                          child: Row(
                            children: [
                              Icon(
                                isSelected
                                    ? Icons.radio_button_checked_rounded
                                    : Icons.radio_button_off_rounded,
                                color: isSelected
                                    ? const Color(0xFF0F766E)
                                    : (isDark
                                        ? AppColors.textMutedDark
                                        : const Color(0xFF94A3B8)),
                                size: 22,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      opt.name,
                                      style: GoogleFonts.plusJakartaSans(
                                        fontSize: 14,
                                        fontWeight: isSelected
                                            ? FontWeight.w800
                                            : FontWeight.w600,
                                        color: isDark
                                            ? AppColors.textPrimaryDark
                                            : const Color(0xFF1E293B),
                                      ),
                                    ),
                                    if (opt.description != null) ...[
                                      const SizedBox(height: 2),
                                      Text(
                                        opt.description!,
                                        style: GoogleFonts.plusJakartaSans(
                                          fontSize: 12,
                                          color: isDark
                                              ? AppColors.textMutedDark
                                              : const Color(0xFF64748B),
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                '₹${opt.price.toStringAsFixed(0)}',
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w900,
                                  color: isDark
                                      ? AppColors.primaryLight
                                      : const Color(0xFF0F766E),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),

            // Confirm Add Button
            Padding(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0F766E),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    elevation: 0,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    widget.onOptionSelected(selectedOption);
                  },
                  child: Text(
                    'Add Service  •  ₹${selectedOption.price.toStringAsFixed(0)}',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
