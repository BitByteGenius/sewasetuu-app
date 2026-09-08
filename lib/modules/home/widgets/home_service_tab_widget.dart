import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sewasetu/modules/home/controllers/home_controller.dart';

/// Individual service tab card for the 4-service switcher
class HomeServiceTabWidget extends StatefulWidget {
  final HomeService service;
  final bool isSelected;
  final VoidCallback onTap;

  const HomeServiceTabWidget({
    super.key,
    required this.service,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<HomeServiceTabWidget> createState() => _HomeServiceTabWidgetState();
}

class _HomeServiceTabWidgetState extends State<HomeServiceTabWidget> {
  bool _isPressed = false;

  String get _serviceEmoji {
    switch (widget.service) {
      case HomeService.stay:
        return '🏠';
      case HomeService.trips:
        return '🗺️';
      case HomeService.shop:
        return '🛍️';
      case HomeService.rental:
        return '🚗';
    }
  }


  Color get _activeAccentColor {
    switch (widget.service) {
      case HomeService.stay:
        return const Color(0xFF0F766E); // Deep Teal
      case HomeService.trips:
        return const Color(0xFF6366F1); // Indigo
      case HomeService.shop:
        return const Color(0xFFEA580C); // Warm Orange
      case HomeService.rental:
        return const Color(0xFF2563EB); // Royal Blue
    }
  }

  @override
  Widget build(BuildContext context) {
    final isSelected = widget.isSelected;

    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: widget.onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedScale(
        scale: _isPressed ? 0.94 : (isSelected ? 1.02 : 1.0),
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOutCubic,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 280),
          curve: Curves.easeInOutCubic,
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.white.withValues(alpha: 0.08),
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(16),
              bottom: Radius.circular(14),
            ),
            border: Border.all(
              color: isSelected
                  ? _activeAccentColor.withValues(alpha: 0.8)
                  : Colors.white.withValues(alpha: 0.12),
              width: isSelected ? 1.5 : 1,
            ),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: _activeAccentColor.withValues(alpha: 0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                      spreadRadius: 0,
                    ),
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.25),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.15),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Animated Service Icon / Emoji
              AnimatedScale(
                scale: isSelected ? 1.15 : 0.95,
                duration: const Duration(milliseconds: 260),
                curve: Curves.easeOutBack,
                child: Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isSelected
                        ? _activeAccentColor.withValues(alpha: 0.12)
                        : Colors.white.withValues(alpha: 0.06),
                  ),
                  child: Center(
                    child: Text(
                      _serviceEmoji,
                      style: const TextStyle(
                        fontSize: 20,
                        height: 1.1,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 6),

              // Service Title
              SizedBox(
                height: 28,
                child: Center(
                  child: AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeInOut,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 11,
                      fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
                      color: isSelected
                          ? const Color(0xFF0F172A) // Rich slate 900 for high contrast
                          : Colors.white.withValues(alpha: 0.85),
                      letterSpacing: -0.2,
                      height: 1.15,
                    ),
                    child: Text(
                      widget.service.title,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),

              // Active dot indicator
              const SizedBox(height: 3),
              AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                width: isSelected ? 12 : 0,
                height: 2.5,
                decoration: BoxDecoration(
                  color: isSelected ? _activeAccentColor : Colors.transparent,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
