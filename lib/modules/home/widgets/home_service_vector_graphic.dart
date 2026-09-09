import 'package:flutter/material.dart';
import 'package:sewasetu/modules/home/controllers/home_controller.dart';

/// Resolution-independent, handcrafted vector artwork for the 4 primary marketplace services.
/// Renders crisp vector paths with subtle duotone gradients and smooth state transitions
/// that adapt perfectly to both Dark and Light themes.
class HomeServiceVectorGraphic extends StatelessWidget {
  final HomeService service;
  final bool isSelected;
  final Color activeColor;
  final double size;
  final bool isDark;

  const HomeServiceVectorGraphic({
    super.key,
    required this.service,
    required this.isSelected,
    required this.activeColor,
    this.size = 32.0,
    this.isDark = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _getPainter(service, isSelected, activeColor, isDark),
      ),
    );
  }

  CustomPainter _getPainter(
    HomeService service,
    bool isSelected,
    Color activeColor,
    bool isDark,
  ) {
    switch (service) {
      case HomeService.stay:
        return StayVectorPainter(
          isSelected: isSelected,
          accentColor: activeColor,
          isDark: isDark,
        );
      case HomeService.trips:
        return TripsVectorPainter(
          isSelected: isSelected,
          accentColor: activeColor,
          isDark: isDark,
        );
      case HomeService.shop:
        return ShopVectorPainter(
          isSelected: isSelected,
          accentColor: activeColor,
          isDark: isDark,
        );
      case HomeService.rental:
        return RentalVectorPainter(
          isSelected: isSelected,
          accentColor: activeColor,
          isDark: isDark,
        );
    }
  }
}

/// 1. Architectural A-Frame Alpine Stay Vector
class StayVectorPainter extends CustomPainter {
  final bool isSelected;
  final Color accentColor;
  final bool isDark;

  StayVectorPainter({
    required this.isSelected,
    required this.accentColor,
    required this.isDark,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    final primaryColor = isSelected
        ? accentColor
        : (isDark ? Colors.white.withValues(alpha: 0.85) : const Color(0xFF475569));
    final secondaryColor = isSelected
        ? accentColor.withValues(alpha: 0.25)
        : (isDark
            ? Colors.white.withValues(alpha: 0.20)
            : const Color(0xFF94A3B8).withValues(alpha: 0.35));
    final highlightColor = isSelected
        ? const Color(0xFFF59E0B)
        : (isDark ? Colors.white70 : const Color(0xFF64748B));

    // Background Mountain Ridge silhouette
    final bgPath = Path();
    bgPath.moveTo(w * 0.05, h * 0.82);
    bgPath.lineTo(w * 0.35, h * 0.42);
    bgPath.lineTo(w * 0.58, h * 0.68);
    bgPath.lineTo(w * 0.82, h * 0.36);
    bgPath.lineTo(w * 0.98, h * 0.82);
    bgPath.close();

    final bgPaint = Paint()
      ..color = secondaryColor
      ..style = PaintingStyle.fill;
    canvas.drawPath(bgPath, bgPaint);

    // Chimney
    final chimneyPath = Path();
    chimneyPath.addRRect(RRect.fromRectAndRadius(
      Rect.fromLTWH(w * 0.65, h * 0.26, w * 0.10, h * 0.25),
      const Radius.circular(2),
    ));
    canvas.drawPath(
      chimneyPath,
      Paint()
        ..color = primaryColor
        ..style = PaintingStyle.fill,
    );

    // Main A-Frame Cabin Roof
    final cabinPath = Path();
    cabinPath.moveTo(w * 0.50, h * 0.16); // Roof Peak
    cabinPath.lineTo(w * 0.86, h * 0.84); // Right Eaves
    cabinPath.lineTo(w * 0.14, h * 0.84); // Left Eaves
    cabinPath.close();

    final cabinFillColor = isSelected
        ? (isDark ? const Color(0xFF0F2926) : Colors.white)
        : (isDark ? const Color(0xFF1E293B) : const Color(0xFFF1F5F9));

    canvas.drawPath(
      cabinPath,
      Paint()
        ..color = cabinFillColor
        ..style = PaintingStyle.fill,
    );

    // Roof Outline Stroke
    final roofStrokePaint = Paint()
      ..color = primaryColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.4
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    canvas.drawPath(cabinPath, roofStrokePaint);

    // Warm Glowing Cabin Window (Triangle)
    final windowPath = Path();
    windowPath.moveTo(w * 0.50, h * 0.36);
    windowPath.lineTo(w * 0.64, h * 0.58);
    windowPath.lineTo(w * 0.36, h * 0.58);
    windowPath.close();

    final windowPaint = Paint()
      ..color = highlightColor.withValues(alpha: isSelected ? 0.95 : 0.80)
      ..style = PaintingStyle.fill;
    canvas.drawPath(windowPath, windowPaint);

    // Window Divider Frame
    final dividerPaint = Paint()
      ..color = primaryColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;
    canvas.drawLine(Offset(w * 0.50, h * 0.36), Offset(w * 0.50, h * 0.58), dividerPaint);
    canvas.drawLine(Offset(w * 0.40, h * 0.50), Offset(w * 0.60, h * 0.50), dividerPaint);

    // Front Doorway
    final doorRect = RRect.fromRectAndCorners(
      Rect.fromLTWH(w * 0.42, h * 0.64, w * 0.16, h * 0.20),
      topLeft: const Radius.circular(3),
      topRight: const Radius.circular(3),
    );
    canvas.drawRRect(doorRect, Paint()..color = primaryColor..style = PaintingStyle.fill);

    // Base Ground Deck Line
    canvas.drawLine(
      Offset(w * 0.08, h * 0.86),
      Offset(w * 0.92, h * 0.86),
      Paint()
        ..color = primaryColor
        ..strokeWidth = 2.0
        ..strokeCap = StrokeCap.round,
    );
  }

  @override
  bool shouldRepaint(covariant StayVectorPainter oldDelegate) =>
      oldDelegate.isSelected != isSelected ||
      oldDelegate.accentColor != accentColor ||
      oldDelegate.isDark != isDark;
}

/// 2. Precision Adventure Compass & Cardinal Navigator Vector for Trips
class TripsVectorPainter extends CustomPainter {
  final bool isSelected;
  final Color accentColor;
  final bool isDark;

  TripsVectorPainter({
    required this.isSelected,
    required this.accentColor,
    required this.isDark,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final center = Offset(w * 0.50, h * 0.50);
    final dialRadius = w * 0.42;

    final primaryColor = isSelected
        ? accentColor
        : (isDark ? Colors.white.withValues(alpha: 0.85) : const Color(0xFF475569));
    final dialFillColor = isSelected
        ? (isDark
            ? accentColor.withValues(alpha: 0.18)
            : accentColor.withValues(alpha: 0.08))
        : (isDark
            ? Colors.white.withValues(alpha: 0.06)
            : const Color(0xFFF1F5F9));

    // 1. Compass Outer Dial Fill
    canvas.drawCircle(
      center,
      dialRadius,
      Paint()
        ..color = dialFillColor
        ..style = PaintingStyle.fill,
    );

    // 2. Compass Outer Dial Bezel Ring
    final bezelPaint = Paint()
      ..color = primaryColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.2
      ..strokeCap = StrokeCap.round;
    canvas.drawCircle(center, dialRadius, bezelPaint);

    // 3. Inner Concentric Ring
    final innerRingPaint = Paint()
      ..color = primaryColor.withValues(alpha: isSelected ? 0.40 : 0.25)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;
    canvas.drawCircle(center, dialRadius * 0.72, innerRingPaint);

    // 4. Cardinal Tick Marks (N, S, E, W)
    final tickPaint = Paint()
      ..color = primaryColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.6
      ..strokeCap = StrokeCap.round;

    // North Tick
    canvas.drawLine(
      Offset(center.dx, center.dy - dialRadius),
      Offset(center.dx, center.dy - dialRadius + 4.5),
      tickPaint,
    );
    // South Tick
    canvas.drawLine(
      Offset(center.dx, center.dy + dialRadius),
      Offset(center.dx, center.dy + dialRadius - 4.5),
      tickPaint,
    );
    // West Tick
    canvas.drawLine(
      Offset(center.dx - dialRadius, center.dy),
      Offset(center.dx - dialRadius + 4.5, center.dy),
      tickPaint,
    );
    // East Tick
    canvas.drawLine(
      Offset(center.dx + dialRadius, center.dy),
      Offset(center.dx + dialRadius - 4.5, center.dy),
      tickPaint,
    );

    // 5. Compass Rose Needles (Faceted 3D Needle)
    final needleLength = dialRadius * 0.78;
    final needleWing = dialRadius * 0.24;

    // --- NORTH NEEDLE (Vibrant Crimson Red / Coral Facets) ---
    // Left half (Darker crimson shade)
    final northLeft = Path()
      ..moveTo(center.dx, center.dy)
      ..lineTo(center.dx - needleWing, center.dy)
      ..lineTo(center.dx, center.dy - needleLength)
      ..close();
    canvas.drawPath(
      northLeft,
      Paint()
        ..color = isSelected ? const Color(0xFFDC2626) : const Color(0xFFEF4444)
        ..style = PaintingStyle.fill,
    );

    // Right half (Lighter coral/amber highlight)
    final northRight = Path()
      ..moveTo(center.dx, center.dy)
      ..lineTo(center.dx + needleWing, center.dy)
      ..lineTo(center.dx, center.dy - needleLength)
      ..close();
    canvas.drawPath(
      northRight,
      Paint()
        ..color = isSelected ? const Color(0xFFF87171) : const Color(0xFFFCA5A5)
        ..style = PaintingStyle.fill,
    );

    // --- SOUTH NEEDLE (Sleek Metallic Silver / Slate Facets) ---
    // Left half (Lighter silver)
    final southLeft = Path()
      ..moveTo(center.dx, center.dy)
      ..lineTo(center.dx - needleWing, center.dy)
      ..lineTo(center.dx, center.dy + needleLength)
      ..close();
    canvas.drawPath(
      southLeft,
      Paint()
        ..color = isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B)
        ..style = PaintingStyle.fill,
    );

    // Right half (Darker slate)
    final southRight = Path()
      ..moveTo(center.dx, center.dy)
      ..lineTo(center.dx + needleWing, center.dy)
      ..lineTo(center.dx, center.dy + needleLength)
      ..close();
    canvas.drawPath(
      southRight,
      Paint()
        ..color = isDark ? const Color(0xFF64748B) : const Color(0xFF475569)
        ..style = PaintingStyle.fill,
    );

    // Needle Crisp Centerline
    canvas.drawLine(
      Offset(center.dx, center.dy - needleLength),
      Offset(center.dx, center.dy + needleLength),
      Paint()
        ..color = isDark
            ? Colors.white.withValues(alpha: 0.6)
            : Colors.black.withValues(alpha: 0.25)
        ..strokeWidth = 0.8,
    );

    // 6. Central Brass / Jewel Hub
    canvas.drawCircle(
      center,
      3.8,
      Paint()
        ..color = isSelected
            ? const Color(0xFFF59E0B) // Gold amber jewel
            : (isDark ? Colors.white : const Color(0xFF1E293B))
        ..style = PaintingStyle.fill,
    );
    canvas.drawCircle(
      center,
      3.8,
      Paint()
        ..color = isDark
            ? Colors.black.withValues(alpha: 0.4)
            : Colors.white.withValues(alpha: 0.6)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.0,
    );
  }

  @override
  bool shouldRepaint(covariant TripsVectorPainter oldDelegate) =>
      oldDelegate.isSelected != isSelected ||
      oldDelegate.accentColor != accentColor ||
      oldDelegate.isDark != isDark;
}

/// 3. Artisan Marketplace Shopping Bag Vector
class ShopVectorPainter extends CustomPainter {
  final bool isSelected;
  final Color accentColor;
  final bool isDark;

  ShopVectorPainter({
    required this.isSelected,
    required this.accentColor,
    required this.isDark,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    final primaryColor = isSelected
        ? accentColor
        : (isDark ? Colors.white.withValues(alpha: 0.85) : const Color(0xFF475569));
    final secondaryColor = isSelected
        ? accentColor.withValues(alpha: 0.22)
        : (isDark
            ? Colors.white.withValues(alpha: 0.18)
            : const Color(0xFF94A3B8).withValues(alpha: 0.35));
    final tagColor = isSelected
        ? const Color(0xFF10B981)
        : (isDark ? Colors.white70 : const Color(0xFF64748B));

    // Dual Handles Arc
    final handlePath = Path();
    handlePath.moveTo(w * 0.34, h * 0.38);
    handlePath.cubicTo(w * 0.34, h * 0.10, w * 0.66, h * 0.10, w * 0.66, h * 0.38);

    final handlePaint = Paint()
      ..color = primaryColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.4
      ..strokeCap = StrokeCap.round;
    canvas.drawPath(handlePath, handlePaint);

    // Tote Bag Body (Trapezoidal with subtle bevel)
    final bagPath = Path();
    bagPath.moveTo(w * 0.22, h * 0.36);
    bagPath.lineTo(w * 0.78, h * 0.36);
    bagPath.lineTo(w * 0.84, h * 0.84);
    bagPath.quadraticBezierTo(w * 0.84, h * 0.88, w * 0.78, h * 0.88);
    bagPath.lineTo(w * 0.22, h * 0.88);
    bagPath.quadraticBezierTo(w * 0.16, h * 0.88, w * 0.16, h * 0.84);
    bagPath.close();

    final bagFillColor = isSelected
        ? (isDark ? const Color(0xFF2C160B) : Colors.white)
        : (isDark ? const Color(0xFF1E293B) : const Color(0xFFF1F5F9));

    // Bag Fill
    canvas.drawPath(
      bagPath,
      Paint()
        ..color = bagFillColor
        ..style = PaintingStyle.fill,
    );

    // Decorative Artisan Weave Pattern / Horizontal lines inside bag
    final weavePaint = Paint()
      ..color = secondaryColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4;
    canvas.drawLine(Offset(w * 0.26, h * 0.48), Offset(w * 0.74, h * 0.48), weavePaint);
    canvas.drawLine(Offset(w * 0.28, h * 0.58), Offset(w * 0.72, h * 0.58), weavePaint);

    // Bag Stroke Outline
    final bagStroke = Paint()
      ..color = primaryColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.2
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    canvas.drawPath(bagPath, bagStroke);

    // Artisan Craft Badge / Gift Star on front of bag
    final badgePath = Path();
    badgePath.addOval(Rect.fromCircle(center: Offset(w * 0.50, h * 0.68), radius: w * 0.12));
    canvas.drawPath(badgePath, Paint()..color = tagColor..style = PaintingStyle.fill);

    // Small star inside badge
    final starCenter = Offset(w * 0.50, h * 0.68);
    final starPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;
    canvas.drawLine(starCenter - Offset(0, w * 0.06), starCenter + Offset(0, w * 0.06), starPaint);
    canvas.drawLine(starCenter - Offset(w * 0.06, 0), starCenter + Offset(w * 0.06, 0), starPaint);
  }

  @override
  bool shouldRepaint(covariant ShopVectorPainter oldDelegate) =>
      oldDelegate.isSelected != isSelected ||
      oldDelegate.accentColor != accentColor ||
      oldDelegate.isDark != isDark;
}

/// 4. Sleek Aerodynamic Vehicle & Wheel Adventure Rental Vector
class RentalVectorPainter extends CustomPainter {
  final bool isSelected;
  final Color accentColor;
  final bool isDark;

  RentalVectorPainter({
    required this.isSelected,
    required this.accentColor,
    required this.isDark,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    final primaryColor = isSelected
        ? accentColor
        : (isDark ? Colors.white.withValues(alpha: 0.85) : const Color(0xFF475569));
    final secondaryColor = isSelected
        ? accentColor.withValues(alpha: 0.25)
        : (isDark
            ? Colors.white.withValues(alpha: 0.20)
            : const Color(0xFF94A3B8).withValues(alpha: 0.35));
    final lightGlowColor = isSelected
        ? const Color(0xFF38BDF8)
        : (isDark ? Colors.white70 : const Color(0xFF64748B));

    // Speed / Wind Arc above car
    final speedArc = Path();
    speedArc.moveTo(w * 0.14, h * 0.28);
    speedArc.quadraticBezierTo(w * 0.50, h * 0.18, w * 0.84, h * 0.24);
    canvas.drawPath(
      speedArc,
      Paint()
        ..color = secondaryColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.6
        ..strokeCap = StrokeCap.round,
    );

    // Car Body Profile Path (Modern Crossover Silhouette)
    final carPath = Path();
    carPath.moveTo(w * 0.10, h * 0.68); // Rear bumper
    carPath.lineTo(w * 0.12, h * 0.52); // Rear trunk
    carPath.lineTo(w * 0.26, h * 0.50); // Rear boot
    carPath.quadraticBezierTo(w * 0.34, h * 0.32, w * 0.44, h * 0.32); // Roof curve
    carPath.lineTo(w * 0.66, h * 0.32); // Roof flat
    carPath.lineTo(w * 0.78, h * 0.48); // Windshield
    carPath.lineTo(w * 0.90, h * 0.54); // Hood
    carPath.quadraticBezierTo(w * 0.94, h * 0.58, w * 0.94, h * 0.64); // Front nose
    carPath.lineTo(w * 0.90, h * 0.68); // Front chin

    // Front Wheel Arch
    carPath.lineTo(w * 0.82, h * 0.68);
    carPath.arcToPoint(
      Offset(w * 0.64, h * 0.68),
      radius: Radius.circular(w * 0.10),
      clockwise: false,
    );

    // Underbody
    carPath.lineTo(w * 0.38, h * 0.68);

    // Rear Wheel Arch
    carPath.arcToPoint(
      Offset(w * 0.20, h * 0.68),
      radius: Radius.circular(w * 0.10),
      clockwise: false,
    );
    carPath.close();

    final carFillColor = isSelected
        ? (isDark ? const Color(0xFF0F243A) : Colors.white)
        : (isDark ? const Color(0xFF1E293B) : const Color(0xFFF1F5F9));

    // Car Body Fill
    canvas.drawPath(
      carPath,
      Paint()
        ..color = carFillColor
        ..style = PaintingStyle.fill,
    );

    // Car Windows (Side glasses)
    final windowPath = Path();
    windowPath.moveTo(w * 0.36, h * 0.48);
    windowPath.lineTo(w * 0.45, h * 0.36);
    windowPath.lineTo(w * 0.64, h * 0.36);
    windowPath.lineTo(w * 0.74, h * 0.48);
    windowPath.close();

    canvas.drawPath(
      windowPath,
      Paint()
        ..color = secondaryColor
        ..style = PaintingStyle.fill,
    );

    // Car Body Outline
    final carStroke = Paint()
      ..color = primaryColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.2
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    canvas.drawPath(carPath, carStroke);

    // Headlight Beam
    final lightPath = Path();
    lightPath.moveTo(w * 0.92, h * 0.58);
    lightPath.lineTo(w * 0.98, h * 0.54);
    lightPath.lineTo(w * 0.98, h * 0.66);
    lightPath.close();
    canvas.drawPath(lightPath, Paint()..color = lightGlowColor..style = PaintingStyle.fill);

    // Wheels (Rear & Front)
    void drawWheel(Offset center, double radius) {
      // Outer Tire
      canvas.drawCircle(center, radius, Paint()..color = primaryColor..style = PaintingStyle.fill);
      // Rim
      canvas.drawCircle(
        center,
        radius * 0.55,
        Paint()
          ..color = isSelected
              ? (isDark ? const Color(0xFF1E293B) : Colors.white)
              : (isDark ? const Color(0xFF0F172A) : const Color(0xFFCBD5E1))
          ..style = PaintingStyle.fill,
      );
      // Hub
      canvas.drawCircle(center, radius * 0.22, Paint()..color = primaryColor..style = PaintingStyle.fill);
    }

    final wheelRadius = w * 0.085;
    drawWheel(Offset(w * 0.29, h * 0.68), wheelRadius);
    drawWheel(Offset(w * 0.73, h * 0.68), wheelRadius);

    // Ground Speed Track Line
    canvas.drawLine(
      Offset(w * 0.06, h * 0.84),
      Offset(w * 0.94, h * 0.84),
      Paint()
        ..color = primaryColor
        ..strokeWidth = 1.8
        ..strokeCap = StrokeCap.round,
    );
  }

  @override
  bool shouldRepaint(covariant RentalVectorPainter oldDelegate) =>
      oldDelegate.isSelected != isSelected ||
      oldDelegate.accentColor != accentColor ||
      oldDelegate.isDark != isDark;
}
