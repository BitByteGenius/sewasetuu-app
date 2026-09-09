import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Top curved header banner with brand gradient, decorative ambient rings,
/// and rounded bottom corners (bottomLeft & bottomRight: 36px).
class AuthTopCurvedHeader extends StatelessWidget {
  final String tagText;
  final IconData? tagIcon;
  final String title;
  final String subtitle;
  final Widget? trailing;

  const AuthTopCurvedHeader({
    super.key,
    required this.tagText,
    this.tagIcon,
    required this.title,
    required this.subtitle,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF0D5F58),
            Color(0xFF0F766E),
            Color(0xFF14B8A6),
          ],
          stops: [0.0, 0.55, 1.0],
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(36),
          bottomRight: Radius.circular(36),
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0F766E).withValues(alpha: 0.32),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Ambient Decorative Watermark Rings
          Positioned(
            right: -30,
            top: -20,
            child: Container(
              width: 140,
              height: 140,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.06),
              ),
            ),
          ),
          Positioned(
            left: -40,
            bottom: -30,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.04),
              ),
            ),
          ),

          // Main Header Content
          Padding(
            padding: EdgeInsets.fromLTRB(24, topPadding + 44, 24, 28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Tag Badge
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.18),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.25),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (tagIcon != null) ...[
                        Icon(tagIcon, size: 13, color: Colors.white),
                        const SizedBox(width: 5),
                      ],
                      Text(
                        tagText,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 11.5,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          letterSpacing: 0.3,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),

                // Main Title
                Text(
                  title,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 27,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    letterSpacing: -0.5,
                    height: 1.18,
                    decoration: TextDecoration.none,
                  ),
                ),
                const SizedBox(height: 8),

                // Subtitle
                Text(
                  subtitle,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 13.5,
                    fontWeight: FontWeight.w500,
                    color: Colors.white.withValues(alpha: 0.88),
                    height: 1.45,
                    decoration: TextDecoration.none,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
