import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sewasetu/app/theme/app_colors.dart';
import 'package:sewasetu/shared/widgets/app_network_image.dart';

import '../models/kitchen_cleaning_model.dart';

/// Premium, responsive package comparison and FAQ sheet matching reference images.
/// Works with any dynamic backend model data.
class KitchenCleaningPackageDetailSheet extends StatefulWidget {
  final KitchenServiceDetailData detailData;
  final Function(KitchenPackageColumn selectedPackage)? onProceed;

  const KitchenCleaningPackageDetailSheet({
    super.key,
    required this.detailData,
    this.onProceed,
  });

  /// Static helper to display the sheet modally
  static Future<void> show(
    BuildContext context, {
    required KitchenServiceDetailData detailData,
    Function(KitchenPackageColumn selectedPackage)? onProceed,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (context) => KitchenCleaningPackageDetailSheet(
        detailData: detailData,
        onProceed: onProceed,
      ),
    );
  }

  @override
  State<KitchenCleaningPackageDetailSheet> createState() =>
      _KitchenCleaningPackageDetailSheetState();
}

class _KitchenCleaningPackageDetailSheetState
    extends State<KitchenCleaningPackageDetailSheet> {
  late String _selectedPackageId;
  final Set<String> _expandedFaqIds = {};
  bool _isCategoryExpanded = true;

  @override
  void initState() {
    super.initState();
    // Default select popular package or first package
    if (widget.detailData.packages.isNotEmpty) {
      final popular = widget.detailData.packages
          .firstWhere((p) => p.isPopular, orElse: () => widget.detailData.packages.first);
      _selectedPackageId = popular.id;
    } else {
      _selectedPackageId = 'essential';
    }
  }

  KitchenPackageColumn get _selectedPackage {
    return widget.detailData.packages.firstWhere(
      (p) => p.id == _selectedPackageId,
      orElse: () => widget.detailData.packages.isNotEmpty
          ? widget.detailData.packages.first
          : const KitchenPackageColumn(
              id: 'default', title: 'Package', price: 0.0),
    );
  }

  void _toggleFaq(String id) {
    setState(() {
      if (_expandedFaqIds.contains(id)) {
        _expandedFaqIds.remove(id);
      } else {
        _expandedFaqIds.add(id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final size = MediaQuery.of(context).size;
    final data = widget.detailData;

    return Container(
      constraints: BoxConstraints(
        maxHeight: size.height * 0.94,
      ),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        children: [
          // Drag Handle & Header bar
          _buildSheetHeader(context, isDark, data),

          // Scrollable Body Content
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 1. Top Banner Image with Overlay Stats Tag
                  _buildBannerImage(context, isDark, data),

                  const SizedBox(height: 12),

                  // 2. Service Title & Essential Badge
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data.title,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            color: isDark
                                ? AppColors.textPrimaryDark
                                : const Color(0xFF0F172A),
                          ),
                        ),
                        if (data.badgeText != null) ...[
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(
                                Icons.star_border_rounded,
                                size: 14,
                                color: Color(0xFFD97706),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                data.badgeText!,
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFFD97706),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // 3. Package Comparison Matrix / Table
                  _buildComparisonMatrix(context, isDark, data),

                  const SizedBox(height: 24),

                  // 4. Frequently Asked Questions (FAQ) Accordion Section
                  if (data.faqItems.isNotEmpty)
                    _buildFaqSection(context, isDark, data.faqItems),

                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),

          // Sticky Bottom Checkout Bar
          _buildStickyBottomBar(context, isDark),
        ],
      ),
    );
  }

  Widget _buildSheetHeader(
      BuildContext context, bool isDark, KitchenServiceDetailData data) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Handle bar
        Center(
          child: Container(
            margin: const EdgeInsets.only(top: 10, bottom: 6),
            width: 38,
            height: 4.5,
            decoration: BoxDecoration(
              color: isDark ? AppColors.borderDark : const Color(0xFFCBD5E1),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back, size: 22),
                onPressed: () => Navigator.of(context).pop(),
              ),
              Expanded(
                child: Text(
                  'Kitchen Cleaning',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: isDark
                        ? AppColors.textPrimaryDark
                        : const Color(0xFF1E293B),
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.search_rounded, size: 22),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.shopping_cart_outlined, size: 22),
                onPressed: () {},
              ),
            ],
          ),
        ),
        Divider(
          height: 1,
          thickness: 1,
          color: isDark ? AppColors.borderDark : const Color(0xFFF1F5F9),
        ),
      ],
    );
  }

  Widget _buildBannerImage(
      BuildContext context, bool isDark, KitchenServiceDetailData data) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      height: 180,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: AppNetworkImage(
              imageUrl: data.bannerImageUrl,
              fit: BoxFit.cover,
            ),
          ),

          // Gradient overlay for bottom stats badge readability
          DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withValues(alpha: 0.65),
                ],
                stops: const [0.6, 1.0],
              ),
            ),
          ),

          // Bottom Left Stats Pill ("15k bookings near you | ★ 4.74")
          Positioned(
            left: 12,
            bottom: 12,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.75),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.verified_user_rounded,
                    size: 14,
                    color: Color(0xFF38BDF8),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    data.bookingStatsText,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 11.5,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildComparisonMatrix(
      BuildContext context, bool isDark, KitchenServiceDetailData data) {
    final packages = data.packages;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceVariantDark.withValues(alpha: 0.4) : const Color(0xFFFAFAFA),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? AppColors.borderDark : const Color(0xFFE2E8F0),
        ),
      ),
      child: Column(
        children: [
          // Package Headers Row (Services | Essential | Power Steam | Eco-Smart)
          _buildMatrixHeaderRow(context, isDark, packages),

          const Divider(height: 1, thickness: 1),

          // "Select Package" Row with radio buttons
          _buildSelectPackageRow(context, isDark, packages),

          const Divider(height: 1, thickness: 1),

          // "Prices" Row
          _buildPricesRow(context, isDark, packages),

          const Divider(height: 1, thickness: 1),

          // Accordion Group Headers & Feature Comparison Rows
          ...data.comparisonGroups.map((group) {
            return Column(
              children: [
                // Group title bar ("Kitchen Cleaning" accordion)
                InkWell(
                  onTap: () {
                    setState(() {
                      _isCategoryExpanded = !_isCategoryExpanded;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.soup_kitchen_rounded,
                          size: 18,
                          color: Color(0xFF64748B),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            group.groupTitle,
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 14,
                              fontWeight: FontWeight.w800,
                              color: isDark
                                  ? AppColors.textPrimaryDark
                                  : const Color(0xFF1E293B),
                            ),
                          ),
                        ),
                        Icon(
                          _isCategoryExpanded
                              ? Icons.keyboard_arrow_up_rounded
                              : Icons.keyboard_arrow_down_rounded,
                          size: 20,
                          color: const Color(0xFF64748B),
                        ),
                      ],
                    ),
                  ),
                ),
                if (_isCategoryExpanded)
                  Column(
                    children: group.features.map((feature) {
                      return _buildFeatureRow(
                          context, isDark, packages, feature);
                    }).toList(),
                  ),
              ],
            );
          }),
        ],
      ),
    );
  }

  int _getServicesFlex(int count) => count <= 2 ? 44 : 32;
  int _getPackageFlex(int count) => count <= 2 ? 28 : 20;

  Widget _buildMatrixHeaderRow(
      BuildContext context, bool isDark, List<KitchenPackageColumn> packages) {
    final servicesFlex = _getServicesFlex(packages.length);
    final packageFlex = _getPackageFlex(packages.length);

    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Column 1: "Services" Header
          Expanded(
            flex: servicesFlex,
            child: Padding(
              padding: const EdgeInsets.only(left: 14, bottom: 8),
              child: Text(
                'Services',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: isDark
                      ? AppColors.textMutedDark
                      : const Color(0xFF64748B),
                ),
              ),
            ),
          ),

          // Columns 2, 3, 4: Package Names & Tags
          ...packages.map((pkg) {
            final isSelected = pkg.id == _selectedPackageId;

            return Expanded(
              flex: packageFlex,
              child: GestureDetector(
                onTap: () {
                  HapticFeedback.selectionClick();
                  setState(() {
                    _selectedPackageId = pkg.id;
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? (isDark
                            ? AppColors.primaryContainerDark.withValues(alpha: 0.35)
                            : const Color(0xFFECFDF5))
                        : Colors.transparent,
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(12)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // Popular tag badge
                      if (pkg.badgeTag != null) ...[
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 2),
                          margin: const EdgeInsets.only(bottom: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF3E8FF),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            pkg.badgeTag!,
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 9,
                              fontWeight: FontWeight.w800,
                              color: const Color(0xFF7E22CE),
                            ),
                          ),
                        ),
                      ],

                      // Crown or Star Icon
                      if (pkg.id.contains('steam') || pkg.id.contains('eco'))
                        const Icon(
                          Icons.workspace_premium_outlined,
                          size: 16,
                          color: Color(0xFF7E22CE),
                        )
                      else
                        const Icon(
                          Icons.star_outline_rounded,
                          size: 16,
                          color: Color(0xFFD97706),
                        ),

                      const SizedBox(height: 2),

                      // Package Title
                      Text(
                        pkg.title,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 12,
                          fontWeight:
                              isSelected ? FontWeight.w800 : FontWeight.w600,
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
          }),
        ],
      ),
    );
  }

  Widget _buildSelectPackageRow(
      BuildContext context, bool isDark, List<KitchenPackageColumn> packages) {
    final servicesFlex = _getServicesFlex(packages.length);
    final packageFlex = _getPackageFlex(packages.length);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            flex: servicesFlex,
            child: Padding(
              padding: const EdgeInsets.only(left: 14),
              child: Text(
                'Select Package',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: isDark
                      ? AppColors.textMutedDark
                      : const Color(0xFF64748B),
                ),
              ),
            ),
          ),
          ...packages.map((pkg) {
            final isSelected = pkg.id == _selectedPackageId;

            return Expanded(
              flex: packageFlex,
              child: GestureDetector(
                onTap: () {
                  HapticFeedback.selectionClick();
                  setState(() {
                    _selectedPackageId = pkg.id;
                  });
                },
                child: Container(
                  color: isSelected
                      ? (isDark
                          ? AppColors.primaryContainerDark.withValues(alpha: 0.35)
                          : const Color(0xFFECFDF5))
                      : Colors.transparent,
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Center(
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: 22,
                      height: 22,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isSelected
                            ? const Color(0xFF0F766E)
                            : Colors.transparent,
                        border: Border.all(
                          color: isSelected
                              ? const Color(0xFF0F766E)
                              : (isDark
                                  ? AppColors.borderDark
                                  : const Color(0xFFCBD5E1)),
                          width: 2,
                        ),
                      ),
                      child: isSelected
                          ? const Icon(
                              Icons.check,
                              size: 14,
                              color: Colors.white,
                            )
                          : null,
                    ),
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildPricesRow(
      BuildContext context, bool isDark, List<KitchenPackageColumn> packages) {
    final servicesFlex = _getServicesFlex(packages.length);
    final packageFlex = _getPackageFlex(packages.length);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Expanded(
            flex: servicesFlex,
            child: Padding(
              padding: const EdgeInsets.only(left: 14),
              child: Text(
                'Prices',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: isDark
                      ? AppColors.textMutedDark
                      : const Color(0xFF64748B),
                ),
              ),
            ),
          ),
          ...packages.map((pkg) {
            final isSelected = pkg.id == _selectedPackageId;

            return Expanded(
              flex: packageFlex,
              child: Container(
                color: isSelected
                    ? (isDark
                        ? AppColors.primaryContainerDark.withValues(alpha: 0.35)
                        : const Color(0xFFECFDF5))
                    : Colors.transparent,
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Text(
                  '₹ ${pkg.price.toStringAsFixed(0)}',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 12.5,
                    fontWeight: isSelected ? FontWeight.w900 : FontWeight.w700,
                    color: isSelected
                        ? (isDark
                            ? AppColors.primaryLight
                            : const Color(0xFF0F766E))
                        : (isDark
                            ? AppColors.textPrimaryDark
                            : const Color(0xFF1E293B)),
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildFeatureRow(
    BuildContext context,
    bool isDark,
    List<KitchenPackageColumn> packages,
    KitchenFeatureRow feature,
  ) {
    final servicesFlex = _getServicesFlex(packages.length);
    final packageFlex = _getPackageFlex(packages.length);

    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: isDark
                ? AppColors.borderDark.withValues(alpha: 0.5)
                : const Color(0xFFF1F5F9),
          ),
        ),
      ),
      child: Row(
        children: [
          // Feature Label
          Expanded(
            flex: servicesFlex,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              child: Text(
                feature.featureName,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 11.5,
                  height: 1.3,
                  fontWeight: FontWeight.w500,
                  color: isDark
                      ? AppColors.textSecondaryDark
                      : const Color(0xFF475569),
                ),
              ),
            ),
          ),

          // Columns feature support values (Check ✓, Cross ✕, or Text)
          ...packages.map((pkg) {
            final isSelected = pkg.id == _selectedPackageId;
            final val = feature.columnValues[pkg.id];

            return Expanded(
              flex: packageFlex,
              child: Container(
                color: isSelected
                    ? (isDark
                        ? AppColors.primaryContainerDark.withValues(alpha: 0.35)
                        : const Color(0xFFECFDF5))
                    : Colors.transparent,
                padding: const EdgeInsets.symmetric(vertical: 10),
                alignment: Alignment.center,
                child: _buildFeatureValueWidget(val, isDark),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildFeatureValueWidget(KitchenFeatureValue? val, bool isDark) {
    if (val == null) {
      return const SizedBox.shrink();
    }

    if (val.isSupported != null) {
      if (val.isSupported!) {
        return const Icon(
          Icons.check_rounded,
          size: 18,
          color: Color(0xFF0F766E), // Teal checkmark
        );
      } else {
        return const Icon(
          Icons.close_rounded,
          size: 16,
          color: Color(0xFFCBD5E1), // Muted grey cross
        );
      }
    }

    if (val.textValue != null) {
      final isZero = val.textValue!.toUpperCase() == 'ZERO';
      return Text(
        val.textValue!,
        style: GoogleFonts.plusJakartaSans(
          fontSize: 10.5,
          fontWeight: FontWeight.w800,
          color: isZero
              ? const Color(0xFF0F766E)
              : (isDark ? AppColors.textMutedDark : const Color(0xFF64748B)),
        ),
      );
    }

    return const SizedBox.shrink();
  }

  Widget _buildFaqSection(
      BuildContext context, bool isDark, List<KitchenFaqItem> faqs) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Frequently Asked Questions',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 17,
              fontWeight: FontWeight.w800,
              color: isDark
                  ? AppColors.textPrimaryDark
                  : const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 12),
          Column(
            children: faqs.map((faq) {
              final isExpanded = _expandedFaqIds.contains(faq.id);

              return Container(
                margin: const EdgeInsets.only(bottom: 8),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: isDark
                          ? AppColors.borderDark
                          : const Color(0xFFF1F5F9),
                    ),
                  ),
                ),
                child: Theme(
                  data: Theme.of(context).copyWith(
                    dividerColor: Colors.transparent,
                  ),
                  child: ExpansionTile(
                    tilePadding:
                        const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                    childrenPadding: const EdgeInsets.fromLTRB(4, 0, 4, 12),
                    expandedCrossAxisAlignment: CrossAxisAlignment.start,
                    title: Text(
                      faq.question,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: isDark
                            ? AppColors.textPrimaryDark
                            : const Color(0xFF1E293B),
                      ),
                    ),
                    trailing: Icon(
                      isExpanded ? Icons.remove : Icons.add,
                      size: 20,
                      color: isDark
                          ? AppColors.textPrimaryDark
                          : const Color(0xFF0F172A),
                    ),
                    onExpansionChanged: (expanded) {
                      _toggleFaq(faq.id);
                    },
                    children: [
                      Text(
                        faq.answer,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 12.5,
                          height: 1.4,
                          color: isDark
                              ? AppColors.textMutedDark
                              : const Color(0xFF64748B),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildStickyBottomBar(BuildContext context, bool isDark) {
    final pkg = _selectedPackage;
    final origPrice = pkg.originalPrice ?? (pkg.price * 1.4);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            // Price info
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Starts from ',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 11,
                        color: isDark
                            ? AppColors.textMutedDark
                            : const Color(0xFF94A3B8),
                      ),
                    ),
                    Text(
                      '₹${origPrice.toStringAsFixed(0)}',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 11,
                        color: isDark
                            ? AppColors.textMutedDark
                            : const Color(0xFF94A3B8),
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 1),
                Text(
                  '₹ ${pkg.price.toStringAsFixed(0)}',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    color: isDark
                        ? AppColors.textPrimaryDark
                        : const Color(0xFF0F172A),
                  ),
                ),
              ],
            ),

            const Spacer(),

            // Proceed Button
            SizedBox(
              height: 44,
              width: 140,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0F766E), // Teal Accent
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 0,
                ),
                onPressed: () {
                  HapticFeedback.lightImpact();
                  Navigator.of(context).pop();
                  if (widget.onProceed != null) {
                    widget.onProceed!(pkg);
                  }
                },
                child: Text(
                  'Proceed',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 14.5,
                    fontWeight: FontWeight.w800,
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
