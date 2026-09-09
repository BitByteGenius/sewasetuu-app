import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sewasetu/modules/home/controllers/home_controller.dart';
import 'home_service_vector_graphic.dart';

/// Swiggy-inspired Trapezium shape clipper with angled shoulders and rounded corner bevels.
class TrapeziumClipper extends CustomClipper<Path> {
  final double slant;
  final double radius;

  const TrapeziumClipper({this.slant = 5.0, this.radius = 12.0});

  @override
  Path getClip(Size size) {
    return _buildTrapeziumPath(size, slant, radius);
  }

  @override
  bool shouldReclip(covariant TrapeziumClipper oldClipper) =>
      oldClipper.slant != slant || oldClipper.radius != radius;
}

/// Helper to generate a consistent rounded trapezium path
Path _buildTrapeziumPath(Size size, double slant, double radius) {
  final w = size.width;
  final h = size.height;
  final path = Path();

  // Top edge narrower by slant, bottom edge full width
  path.moveTo(slant + radius, 0);
  path.lineTo(w - slant - radius, 0);
  path.quadraticBezierTo(w - slant, 0, w - slant + (radius * 0.7), radius * 0.7);
  path.lineTo(w - (radius * 0.7), h - radius);
  path.quadraticBezierTo(w, h, w - radius, h);
  path.lineTo(radius, h);
  path.quadraticBezierTo(0, h, (radius * 0.7), h - radius);
  path.lineTo(slant - (radius * 0.7), radius * 0.7);
  path.quadraticBezierTo(slant, 0, slant + radius, 0);
  path.close();

  return path;
}

/// Custom painter that renders a smooth trapezium background fill, border, and ambient shadow
class TrapeziumDecorationPainter extends CustomPainter {
  final Color fillColor;
  final Color borderColor;
  final double borderWidth;
  final double slant;
  final double radius;
  final Color? shadowColor;
  final double shadowBlur;

  TrapeziumDecorationPainter({
    required this.fillColor,
    required this.borderColor,
    this.borderWidth = 1.2,
    this.slant = 5.0,
    this.radius = 12.0,
    this.shadowColor,
    this.shadowBlur = 10.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final path = _buildTrapeziumPath(size, slant, radius);

    // Drop shadow
    if (shadowColor != null && shadowColor != Colors.transparent) {
      final shadowPaint = Paint()
        ..color = shadowColor!
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, shadowBlur);
      canvas.save();
      canvas.translate(0, 3);
      canvas.drawPath(path, shadowPaint);
      canvas.restore();
    }

    // Fill
    final fillPaint = Paint()
      ..color = fillColor
      ..style = PaintingStyle.fill;
    canvas.drawPath(path, fillPaint);

    // Border stroke
    if (borderWidth > 0) {
      final borderPaint = Paint()
        ..color = borderColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = borderWidth
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round;
      canvas.drawPath(path, borderPaint);
    }
  }

  @override
  bool shouldRepaint(covariant TrapeziumDecorationPainter oldDelegate) =>
      oldDelegate.fillColor != fillColor ||
      oldDelegate.borderColor != borderColor ||
      oldDelegate.borderWidth != borderWidth ||
      oldDelegate.slant != slant ||
      oldDelegate.radius != radius ||
      oldDelegate.shadowColor != shadowColor;
}

/// Individual service tab card featuring a Swiggy-style trapezium layout,
/// custom vector illustrations, and fluid spring animations.
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

  Color get _activeAccentColor {
    switch (widget.service) {
      case HomeService.stay:
        return const Color(0xFF0F766E); // Deep Teal
      case HomeService.trips:
        return const Color(0xFF6366F1); // Indigo
      case HomeService.shop:
        return const Color(0xFFEA580C); // Warm Orange / Coral
      case HomeService.rental:
        return const Color(0xFF2563EB); // Royal Blue
    }
  }

  @override
  Widget build(BuildContext context) {
    final isSelected = widget.isSelected;
    const slant = 4.5;
    const radius = 13.0;

    final fillColor = isSelected
        ? Colors.white
        : Colors.white.withValues(alpha: 0.08);

    final borderColor = isSelected
        ? _activeAccentColor.withValues(alpha: 0.85)
        : Colors.white.withValues(alpha: 0.12);

    final shadowColor = isSelected
        ? _activeAccentColor.withValues(alpha: 0.32)
        : Colors.black.withValues(alpha: 0.18);

    return GestureDetector(
      onTapDown: (_) {
        HapticFeedback.selectionClick();
        setState(() => _isPressed = true);
      },
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: widget.onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedScale(
        scale: _isPressed ? 0.94 : (isSelected ? 1.02 : 1.0),
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOutCubic,
        child: SizedBox(
          height: 78,
          child: CustomPaint(
            painter: TrapeziumDecorationPainter(
              fillColor: fillColor,
              borderColor: borderColor,
              borderWidth: isSelected ? 1.6 : 1.0,
              slant: slant,
              radius: radius,
              shadowColor: shadowColor,
              shadowBlur: isSelected ? 12.0 : 4.0,
            ),
            child: ClipPath(
              clipper: const TrapeziumClipper(slant: slant, radius: radius),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 7),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // 1. Handcrafted Custom Vector Illustration
                    AnimatedScale(
                      scale: isSelected ? 1.10 : 0.96,
                      duration: const Duration(milliseconds: 240),
                      curve: Curves.easeOutBack,
                      child: HomeServiceVectorGraphic(
                        service: widget.service,
                        isSelected: isSelected,
                        activeColor: _activeAccentColor,
                        size: 30,
                      ),
                    ),
                    const SizedBox(height: 5),

                    // 2. Service Title
                    SizedBox(
                      height: 18,
                      child: Center(
                        child: AnimatedDefaultTextStyle(
                          duration: const Duration(milliseconds: 220),
                          curve: Curves.easeInOut,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 11.5,
                            fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
                            color: isSelected
                                ? const Color(0xFF0F172A) // Rich slate 900 for high contrast
                                : Colors.white.withValues(alpha: 0.88),
                            letterSpacing: -0.2,
                            height: 1.1,
                          ),
                          child: Text(
                            widget.service.title,
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ),

                    // 3. Active Illuminated Accent Bar (Swiggy Indicator)
                    const SizedBox(height: 3),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 240),
                      curve: Curves.easeOutCubic,
                      width: isSelected ? 16 : 0,
                      height: 2.6,
                      decoration: BoxDecoration(
                        color: isSelected ? _activeAccentColor : Colors.transparent,
                        borderRadius: BorderRadius.circular(2),
                        boxShadow: isSelected
                            ? [
                                BoxShadow(
                                  color: _activeAccentColor.withValues(alpha: 0.5),
                                  blurRadius: 4,
                                  offset: const Offset(0, 1),
                                ),
                              ]
                            : null,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
