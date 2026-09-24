import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sewasetu/app/theme/app_colors.dart';
import 'package:sewasetu/shared/widgets/app_network_image.dart';
import '../models/service_offer_item.dart';

/// "Offers for you" promotional banner carousel with copyable coupon codes & indicators
class ServicesOffersCarouselWidget extends StatefulWidget {
  final List<ServiceOfferItem> offers;
  final ValueChanged<String> onCopyCoupon;

  const ServicesOffersCarouselWidget({
    super.key,
    required this.offers,
    required this.onCopyCoupon,
  });

  @override
  State<ServicesOffersCarouselWidget> createState() => _ServicesOffersCarouselWidgetState();
}

class _ServicesOffersCarouselWidgetState extends State<ServicesOffersCarouselWidget> {
  late final PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.90);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.offers.isEmpty) return const SizedBox.shrink();

    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Title
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Offers for you',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.3,
              color: isDark ? AppColors.textPrimaryDark : const Color(0xFF1E293B),
            ),
          ),
        ),
        const SizedBox(height: 12),

        // Carousel Slider
        SizedBox(
          height: 130,
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.offers.length,
            onPageChanged: (index) {
              setState(() => _currentPage = index);
            },
            itemBuilder: (context, index) {
              final offer = widget.offers[index];
              return _buildOfferCard(context, offer, isDark);
            },
          ),
        ),

        const SizedBox(height: 10),

        // Dot indicators
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            widget.offers.length,
            (index) => AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              margin: const EdgeInsets.symmetric(horizontal: 3),
              height: 5,
              width: _currentPage == index ? 16 : 5,
              decoration: BoxDecoration(
                color: _currentPage == index
                    ? (isDark ? AppColors.primaryLight : const Color(0xFF1E293B))
                    : (isDark ? Colors.white24 : const Color(0xFFCBD5E1)),
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildOfferCard(BuildContext context, ServiceOfferItem offer, bool isDark) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF132A24) : const Color(0xFFEAF8F1),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: isDark ? const Color(0xFF1D4D3E) : const Color(0xFFC7EBD7),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.25 : 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(17),
        child: Row(
          children: [
            // Left content
            Expanded(
              flex: 65,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Category & Info icon
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            offer.categoryTag.toUpperCase(),
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 9.5,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.6,
                              color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Icon(
                          Icons.info_outline_rounded,
                          size: 13,
                          color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
                        ),
                      ],
                    ),

                    // Headline with highlighted discount
                    RichText(
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: '${offer.discountHighlight} ',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 14,
                              fontWeight: FontWeight.w900,
                              color: const Color(0xFF4F46E5), // Vibrant Indigo
                            ),
                          ),
                          TextSpan(
                            text: offer.discountHeadline.replaceFirst(offer.discountHighlight, '').trim(),
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 13.5,
                              fontWeight: FontWeight.w800,
                              color: isDark ? AppColors.textPrimaryDark : const Color(0xFF0F172A),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Coupon code pill with copy action
                    GestureDetector(
                      onTap: () => widget.onCopyCoupon(offer.couponCode),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4.5),
                        decoration: BoxDecoration(
                          color: isDark ? const Color(0xFF0F382C) : Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: const Color(0xFF10B981),
                            width: 1.1,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              offer.couponCode,
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 11,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 0.4,
                                color: const Color(0xFF059669),
                              ),
                            ),
                            const SizedBox(width: 5),
                            const Icon(
                              Icons.copy_rounded,
                              size: 12,
                              color: Color(0xFF059669),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Right image
            Expanded(
              flex: 35,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  AppNetworkImage(
                    imageUrl: offer.imageUrl,
                    fit: BoxFit.cover,
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(17),
                      bottomRight: Radius.circular(17),
                    ),
                  ),
                  // Left fade gradient
                  DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          isDark ? const Color(0xFF132A24) : const Color(0xFFEAF8F1),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
