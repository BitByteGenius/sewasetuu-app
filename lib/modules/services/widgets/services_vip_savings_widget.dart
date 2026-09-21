import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sewasetu/app/theme/app_colors.dart';

/// VIP Club Promotional Savings Card matching the bottom of screenshot 1
class ServicesVipSavingsWidget extends StatelessWidget {
  final VoidCallback onTap;

  const ServicesVipSavingsWidget({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: isDark ? AppColors.surfaceDark : Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isDark ? AppColors.borderDark : const Color(0xFFE2E8F0),
              width: 1.1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: isDark ? 0.25 : 0.03),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              // VIP Black Badge
              Container(
                width: 38,
                height: 38,
                decoration: const BoxDecoration(
                  color: Color(0xFF1E1E1E),
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [Color(0xFF333333), Color(0xFF111111)],
                  ),
                ),
                child: Center(
                  child: Text(
                    'VIP',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 11,
                      fontWeight: FontWeight.w900,
                      color: const Color(0xFFFBBF24), // Amber Gold
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),

              // Text Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: isDark ? AppColors.textPrimaryDark : const Color(0xFF1E293B),
                        ),
                        children: [
                          const TextSpan(text: 'Save upto '),
                          TextSpan(
                            text: '15% off',
                            style: GoogleFonts.plusJakartaSans(
                              fontWeight: FontWeight.w900,
                              color: const Color(0xFFB45309), // Warm amber gold
                            ),
                          ),
                          const TextSpan(text: ' on Home Services'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 3),
                    Row(
                      children: [
                        Text(
                          'Starting @ 199 ',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 11.5,
                            fontWeight: FontWeight.w600,
                            color: isDark ? AppColors.textMutedDark : const Color(0xFF64748B),
                          ),
                        ),
                        Text(
                          '₹599',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 11.5,
                            fontWeight: FontWeight.w500,
                            color: isDark ? const Color(0xFF64748B) : const Color(0xFF94A3B8),
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Chevron
              Icon(
                Icons.chevron_right_rounded,
                size: 22,
                color: isDark ? AppColors.primaryLight : const Color(0xFF0F766E),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
