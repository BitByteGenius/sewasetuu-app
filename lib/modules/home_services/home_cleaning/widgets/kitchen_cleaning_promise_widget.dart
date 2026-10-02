import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sewasetu/app/theme/app_colors.dart';

/// "SewaSetu Promise" & "Why SewaSetu?" feature cards matching reference mockup.
class KitchenCleaningPromiseWidget extends StatelessWidget {
  final List<String> whyUsFeatures;

  const KitchenCleaningPromiseWidget({
    super.key,
    required this.whyUsFeatures,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1. SewaSetu Promise Banner Card
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          decoration: BoxDecoration(
            color: isDark ? AppColors.surfaceDark : const Color(0xFFF1F5F9),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isDark ? AppColors.borderDark : const Color(0xFFE2E8F0),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Oji One Promise',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: isDark
                          ? AppColors.textPrimaryDark
                          : const Color(0xFF1E293B),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildPromiseItem(
                    context,
                    icon: Icons.monetization_on_outlined,
                    title: 'Best\nPrice',
                    isDark: isDark,
                  ),
                  _buildPromiseItem(
                    context,
                    icon: Icons.verified_user_outlined,
                    title: 'Free\nCancellation',
                    isDark: isDark,
                  ),
                  _buildPromiseItem(
                    context,
                    icon: Icons.star_border_rounded,
                    title: '5 Star Rated\nPartner',
                    isDark: isDark,
                  ),
                ],
              ),
            ],
          ),
        ),

        // 2. Why SewaSetu? Feature Steps
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Row(
            children: [
              Text(
                'Why ',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: isDark
                      ? AppColors.textPrimaryDark
                      : const Color(0xFF1E293B),
                ),
              ),
              
              Text(
                'Oji One?',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: isDark
                      ? AppColors.textPrimaryDark
                      : const Color(0xFF1E293B),
                ),
              ),
            ],
          ),
        ),

        ...whyUsFeatures.map((feature) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            width: double.infinity,
            decoration: BoxDecoration(
              color: isDark ? AppColors.surfaceDark : const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isDark ? AppColors.borderDark : const Color(0xFFF1F5F9),
              ),
            ),
            child: Text(
              feature,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 13.5,
                fontWeight: FontWeight.w600,
                color: isDark
                    ? AppColors.textPrimaryDark
                    : const Color(0xFF334155),
              ),
            ),
          );
        }),
      ],
    );
  }

  Widget _buildPromiseItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required bool isDark,
  }) {
    return Column(
      children: [
        Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            color: isDark
                ? AppColors.surfaceVariantDark
                : const Color(0xFFEEF2FF),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            size: 26,
            color: const Color(0xFF4338CA),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          textAlign: TextAlign.center,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            height: 1.2,
            color: isDark
                ? AppColors.textPrimaryDark
                : const Color(0xFF334155),
          ),
        ),
      ],
    );
  }
}
