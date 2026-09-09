import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sewasetu/app/theme/app_colors.dart';
import 'package:sewasetu/modules/home/controllers/home_controller.dart';

/// Large premium search bar located beneath the service switcher with dynamic service-based placeholder
class HomeDynamicSearchBarWidget extends StatefulWidget {
  const HomeDynamicSearchBarWidget({super.key});

  @override
  State<HomeDynamicSearchBarWidget> createState() => _HomeDynamicSearchBarWidgetState();
}

class _HomeDynamicSearchBarWidgetState extends State<HomeDynamicSearchBarWidget> {
  bool _isPressed = false;
  bool _isMicPressed = false;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 16.0),
      child: GestureDetector(
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) => setState(() => _isPressed = false),
        onTapCancel: () => setState(() => _isPressed = false),
        onTap: controller.onSearchTap,
        behavior: HitTestBehavior.opaque,
        child: AnimatedScale(
          scale: _isPressed ? 0.98 : 1.0,
          duration: const Duration(milliseconds: 140),
          child: Container(
            height: 52,
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF1E293B) : Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0),
                width: 1.2,
              ),
              boxShadow: isDark
                  ? [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.25),
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ]
                  : [
                      BoxShadow(
                        color: const Color(0xFF0F172A).withValues(alpha: 0.06),
                        blurRadius: 14,
                        offset: const Offset(0, 3),
                        spreadRadius: -1,
                      ),
                    ],
            ),
            child: Row(
              children: [
                // Search Icon with subtle brand color
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: isDark ? 0.20 : 0.10),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.search_rounded,
                    color: isDark ? AppColors.primaryLight : AppColors.primary,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),

                // Dynamic Placeholder Text with smooth cross-fade animation
                Expanded(
                  child: Obx(() {
                    final placeholder = controller.currentSearchPlaceholder;
                    final activeService = controller.selectedService.value;

                    return AnimatedSwitcher(
                      duration: const Duration(milliseconds: 250),
                      transitionBuilder: (child, animation) {
                        return FadeTransition(
                          opacity: animation,
                          child: SlideTransition(
                            position: Tween<Offset>(
                              begin: const Offset(0, 0.15),
                              end: Offset.zero,
                            ).animate(animation),
                            child: child,
                          ),
                        );
                      },
                      child: Text(
                        placeholder,
                        key: ValueKey<HomeService>(activeService),
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 13.5,
                          fontWeight: FontWeight.w500,
                          color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    );
                  }),
                ),

                // Vertical Divider
                Container(
                  height: 22,
                  width: 1,
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  color: isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0),
                ),

                // Voice Search Action with interactive tap feedback
                GestureDetector(
                  onTapDown: (_) => setState(() => _isMicPressed = true),
                  onTapUp: (_) => setState(() => _isMicPressed = false),
                  onTapCancel: () => setState(() => _isMicPressed = false),
                  onTap: controller.onVoiceSearchTap,
                  behavior: HitTestBehavior.opaque,
                  child: AnimatedScale(
                    scale: _isMicPressed ? 0.85 : 1.0,
                    duration: const Duration(milliseconds: 140),
                    child: Container(
                      padding: const EdgeInsets.all(7),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _isMicPressed
                            ? (isDark ? AppColors.primaryContainerDark : AppColors.primaryContainer)
                            : (isDark ? const Color(0xFF334155) : const Color(0xFFF1F5F9)),
                      ),
                      child: Icon(
                        Icons.mic_none_rounded,
                        size: 19,
                        color: isDark ? AppColors.primaryLight : AppColors.primary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
