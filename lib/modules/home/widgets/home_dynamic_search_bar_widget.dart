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
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: const Color(0xFFE2E8F0),
                width: 1.2,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.16),
                  blurRadius: 14,
                  offset: const Offset(0, 4),
                  spreadRadius: -1,
                ),
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.08),
                  blurRadius: 6,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Row(
              children: [
                // Search Icon with subtle brand color
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.search_rounded,
                    color: AppColors.primary,
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
                          color: const Color(0xFF64748B), // Slate 500
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
                  color: const Color(0xFFCBD5E1),
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
                            ? AppColors.primaryContainer
                            : const Color(0xFFF1F5F9), // Slate 100
                      ),
                      child: const Icon(
                        Icons.mic_none_rounded,
                        size: 19,
                        color: AppColors.primary,
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
