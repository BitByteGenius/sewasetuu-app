import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sewasetu/app/theme/app_colors.dart';
import 'package:sewasetu/app/theme/app_spacing.dart';
import 'package:sewasetu/modules/home/controllers/home_controller.dart';
import 'location_selector_modal.dart';

/// Premium dark location header with interactive location selector and profile avatar
class HomeLocationHeaderWidget extends StatefulWidget {
  const HomeLocationHeaderWidget({super.key});

  @override
  State<HomeLocationHeaderWidget> createState() => _HomeLocationHeaderWidgetState();
}

class _HomeLocationHeaderWidgetState extends State<HomeLocationHeaderWidget> {
  bool _isLocationPressed = false;
  bool _isProfilePressed = false;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Location Selector Section
          Expanded(
            child: GestureDetector(
              onTapDown: (_) => setState(() => _isLocationPressed = true),
              onTapUp: (_) => setState(() => _isLocationPressed = false),
              onTapCancel: () => setState(() => _isLocationPressed = false),
              onTap: () => LocationSelectorModal.show(context),
              behavior: HitTestBehavior.opaque,
              child: AnimatedScale(
                scale: _isLocationPressed ? 0.98 : 1.0,
                duration: const Duration(milliseconds: 150),
                child: Row(
                  children: [
                    // Glowing Location Pin Badge
                    Container(
                      width: 38,
                      height: 38,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF0F766E), Color(0xFF14B8A6)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF14B8A6).withValues(alpha: 0.35),
                            blurRadius: 10,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.location_on_rounded,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                    AppSpacing.gapH12,

                    // Location Text Details
                    Expanded(
                      child: Obx(() {
                        final title = controller.locationTitle;
                        final subtitle = controller.locationService.isLocating.value
                            ? 'Detecting GPS location...'
                            : controller.locationSubtitle;
                        final isDark = Theme.of(context).brightness == Brightness.dark;

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Primary Location Title + Dropdown Chevron
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Flexible(
                                  child: Text(
                                    title,
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w800,
                                      color: isDark ? Colors.white : const Color(0xFF0F172A),
                                      letterSpacing: -0.3,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: isDark ? Colors.white : const Color(0xFF0F172A),
                                  size: 20,
                                ),
                              ],
                            ),
                            const SizedBox(height: 2),

                            // Subtitle Address Details
                            Text(
                              subtitle,
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),

          // Profile / Avatar Action Button
          GestureDetector(
            onTapDown: (_) => setState(() => _isProfilePressed = true),
            onTapUp: (_) => setState(() => _isProfilePressed = false),
            onTapCancel: () => setState(() => _isProfilePressed = false),
            onTap: controller.onProfileTap,
            behavior: HitTestBehavior.opaque,
            child: AnimatedScale(
              scale: _isProfilePressed ? 0.92 : 1.0,
              duration: const Duration(milliseconds: 150),
              child: Builder(
                builder: (context) {
                  final isDark = Theme.of(context).brightness == Brightness.dark;
                  return Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isDark ? const Color(0xFF1E293B) : const Color(0xFFF1F5F9),
                      border: Border.all(
                        color: isDark
                            ? Colors.white.withValues(alpha: 0.22)
                            : const Color(0xFFCBD5E1),
                        width: 1.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: isDark ? 0.35 : 0.06),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: ClipOval(
                      child: Center(
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: isDark
                                  ? const [Color(0xFF334155), Color(0xFF1E293B)]
                                  : const [Color(0xFFFFFFFF), Color(0xFFE2E8F0)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.person_rounded,
                              color: isDark ? AppColors.primaryLight : AppColors.primary,
                              size: 22,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
