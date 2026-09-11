import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sewasetu/core/services/connectivity_service.dart';

/// Pixel-perfect, floating top connectivity snackbar.
/// Wrapped in a Material container with explicit TextDecoration.none to eliminate
/// any yellow/red double underlines in root overlays. Fully adaptive to both Light and Dark modes.
class GlobalConnectivityBanner extends StatelessWidget {
  const GlobalConnectivityBanner({super.key});

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<ConnectivityService>()) {
      return const SizedBox.shrink();
    }

    final service = Get.find<ConnectivityService>();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Obx(() {
      final isVisible = service.showBanner.value;
      final isOffline = service.bannerType.value == ConnectivityBannerType.offline;

      // Theme-adaptive palette
      final backgroundColor = isOffline
          ? (isDark ? const Color(0xFF1E293B) : Colors.white)
          : (isDark ? const Color(0xFF064E3B) : Colors.white);

      final borderColor = isOffline
          ? const Color(0xFFF59E0B).withValues(alpha: isDark ? 0.38 : 0.32)
          : const Color(0xFF10B981).withValues(alpha: isDark ? 0.45 : 0.36);

      final iconBadgeBg = isOffline
          ? (isDark ? const Color(0xFFF59E0B).withValues(alpha: 0.18) : const Color(0xFFFEF3C7))
          : (isDark ? const Color(0xFF10B981).withValues(alpha: 0.22) : const Color(0xFFD1FAE5));

      final iconColor = isOffline
          ? (isDark ? const Color(0xFFFBBF24) : const Color(0xFFD97706))
          : (isDark ? const Color(0xFF34D399) : const Color(0xFF059669));

      final titleColor = isDark ? Colors.white : const Color(0xFF0F172A);

      final subtitleColor = isOffline
          ? (isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B))
          : (isDark ? const Color(0xFF6EE7B7) : const Color(0xFF059669));

      final shadowColor = isOffline
          ? (isDark ? Colors.black.withValues(alpha: 0.40) : const Color(0xFFF59E0B).withValues(alpha: 0.12))
          : (isDark ? Colors.black.withValues(alpha: 0.40) : const Color(0xFF10B981).withValues(alpha: 0.14));

      return Positioned(
        top: 0,
        left: 0,
        right: 0,
        child: IgnorePointer(
          ignoring: !isVisible,
          child: AnimatedSlide(
            offset: isVisible ? const Offset(0, 0) : const Offset(0, -1.6),
            duration: const Duration(milliseconds: 380),
            curve: Curves.easeOutCubic,
            child: AnimatedOpacity(
              opacity: isVisible ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 280),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Material(
                    type: MaterialType.transparency,
                    child: GestureDetector(
                      onTap: service.dismissBanner,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
                        decoration: BoxDecoration(
                          color: backgroundColor,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: borderColor,
                            width: 1.2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: shadowColor,
                              blurRadius: 20,
                              offset: const Offset(0, 6),
                            ),
                            BoxShadow(
                              color: Colors.black.withValues(alpha: isDark ? 0.20 : 0.04),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            // 1. Left Icon Badge
                            Container(
                              width: 38,
                              height: 38,
                              decoration: BoxDecoration(
                                color: iconBadgeBg,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Icon(
                                  isOffline ? Icons.wifi_off_rounded : Icons.wifi_rounded,
                                  color: iconColor,
                                  size: 20,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),

                            // 2. Title and Subtitle with explicit TextDecoration.none
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    isOffline ? 'No Internet Connection' : 'Back Online',
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: 13.5,
                                      fontWeight: FontWeight.w700,
                                      color: titleColor,
                                      decoration: TextDecoration.none,
                                    ),
                                  ),
                                  const SizedBox(height: 1.5),
                                  Text(
                                    isOffline
                                        ? 'Attempting to reconnect...'
                                        : 'Connection has been restored',
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: 11.5,
                                      fontWeight: FontWeight.w500,
                                      color: subtitleColor,
                                      decoration: TextDecoration.none,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 10),

                            // 3. Right Status Indicator: Spinner when offline, Checkmark when back online
                            if (isOffline)
                              SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.2,
                                  valueColor: AlwaysStoppedAnimation<Color>(iconColor),
                                ),
                              )
                            else
                              Container(
                                width: 24,
                                height: 24,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xFF10B981),
                                ),
                                child: const Center(
                                  child: Icon(
                                    Icons.check_rounded,
                                    size: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
