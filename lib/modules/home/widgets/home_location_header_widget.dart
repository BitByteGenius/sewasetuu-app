import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sewasetu/app/routes/app_routes.dart';
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
  bool _isNotificationPressed = false;

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
          const SizedBox(width: 8),

           GestureDetector(
            onTapDown: (_) => setState(() => _isNotificationPressed = true),
            onTapUp: (_) => setState(() => _isNotificationPressed = false),
            onTapCancel: () => setState(() => _isNotificationPressed = false),
            onTap: () => Get.toNamed(AppRoutes.notifications),
            behavior: HitTestBehavior.opaque,
            child: AnimatedScale(
              scale: _isNotificationPressed ? 0.92 : 1.0,
              duration: const Duration(milliseconds: 150),
              child: Builder(
                builder: (context) {
                  final isDark = Theme.of(context).brightness == Brightness.dark;
                  return Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
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
                                  Icons.notifications_none_rounded,
                                  color: isDark ? AppColors.primaryLight : AppColors.primary,
                                  size: 22,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      // Blinking small dot
                      Positioned(
                        top: 2,
                        right: 2,
                        child: _BlinkingNotificationDot(isDark: isDark),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
           
           const SizedBox(width: 8),


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

/// Self-contained pulsing/blinking alert dot for notifications
class _BlinkingNotificationDot extends StatefulWidget {
  final bool isDark;

  const _BlinkingNotificationDot({required this.isDark});

  @override
  State<_BlinkingNotificationDot> createState() => _BlinkingNotificationDotState();
}

class _BlinkingNotificationDotState extends State<_BlinkingNotificationDot>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? _animation;

  @override
  void initState() {
    super.initState();
    _initAnimation();
  }

  void _initAnimation() {
    _controller ??= AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);

    _animation ??= Tween<double>(begin: 0.15, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller!,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void reassemble() {
    super.reassemble();
    if (_controller == null || _animation == null) {
      _initAnimation();
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_controller == null || _animation == null) {
      _initAnimation();
    }

    return FadeTransition(
      opacity: _animation!,
      child: Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: const Color(0xFFEF4444),
          border: Border.all(
            color: widget.isDark ? const Color(0xFF1E293B) : Colors.white,
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFEF4444).withValues(alpha: 0.6),
              blurRadius: 4,
              spreadRadius: 1,
            ),
          ],
        ),
      ),
    );
  }
}
