import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sewasetu/modules/home/controllers/home_controller.dart';
import 'home_service_vector_graphic.dart';

/// Swiggy-style Connected Tab Bar where the active tab physically merges
/// into the sheet below with inverted concave corner fillets and a continuous outline.
class SwiggyConnectedTabBar extends StatefulWidget {
  final HomeService activeService;
  final ValueChanged<HomeService> onServiceChanged;
  final bool isDark;

  const SwiggyConnectedTabBar({
    super.key,
    required this.activeService,
    required this.onServiceChanged,
    required this.isDark,
  });

  @override
  State<SwiggyConnectedTabBar> createState() => _SwiggyConnectedTabBarState();
}

class _SwiggyConnectedTabBarState extends State<SwiggyConnectedTabBar>
    with SingleTickerProviderStateMixin {
  static const List<HomeService> _services = [
    HomeService.stay,
    HomeService.trips,
    HomeService.shop,
    HomeService.rental,
  ];

  late AnimationController _animController;
  late Animation<double> _slideAnimation;
  double _currentPosition = 0.0;

  @override
  void initState() {
    super.initState();
    _currentPosition = widget.activeService.index.toDouble();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 320),
    );
    _slideAnimation = Tween<double>(
      begin: _currentPosition,
      end: _currentPosition,
    ).animate(CurvedAnimation(
      parent: _animController,
      curve: Curves.easeInOutCubic,
    ));
  }

  @override
  void didUpdateWidget(covariant SwiggyConnectedTabBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.activeService != widget.activeService) {
      final target = widget.activeService.index.toDouble();
      _slideAnimation = Tween<double>(
        begin: _slideAnimation.value,
        end: target,
      ).animate(CurvedAnimation(
        parent: _animController,
        curve: Curves.easeInOutCubic,
      ));
      _animController.forward(from: 0.0);
    }
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const tabHeight = 86.0;

    return LayoutBuilder(
      builder: (context, constraints) {
        final totalWidth = constraints.maxWidth;

        return AnimatedBuilder(
          animation: _animController,
          builder: (context, child) {
            final activePos = _animController.isAnimating
                ? _slideAnimation.value
                : widget.activeService.index.toDouble();

            final activeColor = widget.activeService.themeColor(widget.isDark);
            final strokeColor = widget.isDark
                ? Colors.white.withValues(alpha: 0.88)
                : widget.activeService.accentColor;

            return SizedBox(
              width: totalWidth,
              height: tabHeight,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  // 1. Custom Painter that draws:
                  //    - Inactive tab rounded cards
                  //    - Active tab connected folder shape with concave fillets & stroke
                  Positioned.fill(
                    child: CustomPaint(
                      painter: _SwiggyConnectedTabPainter(
                        activePosition: activePos,
                        totalTabs: _services.length,
                        activeColor: activeColor,
                        strokeColor: strokeColor,
                        isDark: widget.isDark,
                        tabHeight: tabHeight,
                      ),
                    ),
                  ),

                  // 2. Interactive Tab Items (Vector icons + titles)
                  Positioned.fill(
                    child: Row(
                      children: _services.map((service) {
                        final isSelected = widget.activeService == service;

                        return Expanded(
                          child: GestureDetector(
                            onTap: () {
                              if (!isSelected) {
                                HapticFeedback.lightImpact();
                                widget.onServiceChanged(service);
                              }
                            },
                            behavior: HitTestBehavior.opaque,
                            child: _buildTabContent(service, isSelected),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildTabContent(HomeService service, bool isSelected) {
    final isDark = widget.isDark;

    return AnimatedScale(
      scale: isSelected ? 1.05 : 0.94,
      duration: const Duration(milliseconds: 240),
      curve: Curves.easeOutBack,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Resolution-independent icon container with sleek badge
          AnimatedContainer(
            duration: const Duration(milliseconds: 220),
            width: isSelected ? 42 : 36,
            height: isSelected ? 42 : 36,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isSelected
                  ? (isDark
                      ? service.accentColor.withValues(alpha: 0.22)
                      : service.accentColor.withValues(alpha: 0.14))
                  : (isDark
                      ? Colors.white.withValues(alpha: 0.06)
                      : const Color(0xFFF1F5F9)),
              border: Border.all(
                color: isSelected
                    ? service.accentColor.withValues(alpha: isDark ? 0.70 : 0.50)
                    : (isDark
                        ? Colors.white.withValues(alpha: 0.10)
                        : const Color(0xFFE2E8F0)),
                width: isSelected ? 1.5 : 1.0,
              ),
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: service.accentColor.withValues(alpha: isDark ? 0.35 : 0.22),
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ]
                  : null,
            ),
            child: Center(
              child: HomeServiceVectorGraphic(
                service: service,
                isSelected: isSelected,
                activeColor: service.accentColor,
                size: isSelected ? 26 : 22,
                isDark: isDark,
              ),
            ),
          ),
          const SizedBox(height: 5),

          // Tab Title
          AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 200),
            style: GoogleFonts.plusJakartaSans(
              fontSize: isSelected ? 12.5 : 11.5,
              fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
              color: isSelected
                  ? (isDark ? Colors.white : const Color(0xFF0F172A))
                  : (isDark
                      ? Colors.white.withValues(alpha: 0.70)
                      : const Color(0xFF64748B)),
              letterSpacing: -0.2,
            ),
            child: Text(
              service.shortTitle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

/// Custom painter executing the exact mathematical Swiggy folder-tab geometry with smooth corner radius
class _SwiggyConnectedTabPainter extends CustomPainter {
  final double activePosition;
  final int totalTabs;
  final Color activeColor;
  final Color strokeColor;
  final bool isDark;
  final double tabHeight;

  _SwiggyConnectedTabPainter({
    required this.activePosition,
    required this.totalTabs,
    required this.activeColor,
    required this.strokeColor,
    required this.isDark,
    required this.tabHeight,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final tabWidth = w / totalTabs;

    // 1. Draw Inactive Tabs Background Cards with enhanced corner radius
    final inactiveCardPaint = Paint()
      ..color = isDark
          ? Colors.black.withValues(alpha: 0.38)
          : Colors.white
      ..style = PaintingStyle.fill;

    final inactiveBorderPaint = Paint()
      ..color = isDark
          ? Colors.white.withValues(alpha: 0.12)
          : const Color(0xFFE2E8F0)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    for (int i = 0; i < totalTabs; i++) {
      final distanceToActive = (i - activePosition).abs();
      if (distanceToActive < 0.70) continue;

      final cardLeft = i * tabWidth + 4.0;
      final cardRight = (i + 1) * tabWidth - 4.0;
      final cardTop = 6.0;
      final cardBottom = h - 6.0;

      final cardRRect = RRect.fromRectAndRadius(
        Rect.fromLTRB(cardLeft, cardTop, cardRight, cardBottom),
        const Radius.circular(20),
      );

      canvas.drawRRect(cardRRect, inactiveCardPaint);
      canvas.drawRRect(cardRRect, inactiveBorderPaint);
    }

    // 2. Construct Active Tab Path with increased corner radius (topRadius: 24, fillet: 14)
    const fillet = 14.0;
    const topRadius = 24.0;

    final left = activePosition * tabWidth;
    final right = left + tabWidth;

    // Fill Path: Covers the active tab shape merging seamlessly into the sheet at y = h
    final fillPath = Path();
    fillPath.moveTo(math.max(0.0, left - fillet), h);
    fillPath.quadraticBezierTo(left, h, left, h - fillet);
    fillPath.lineTo(left, topRadius);
    fillPath.quadraticBezierTo(left, 0, left + topRadius, 0);
    fillPath.lineTo(right - topRadius, 0);
    fillPath.quadraticBezierTo(right, 0, right, topRadius);
    fillPath.lineTo(right, h - fillet);
    fillPath.quadraticBezierTo(right, h, math.min(w, right + fillet), h);
    fillPath.lineTo(math.max(0.0, left - fillet), h);
    fillPath.close();

    final fillPaint = Paint()
      ..color = activeColor
      ..style = PaintingStyle.fill;
    canvas.drawPath(fillPath, fillPaint);

    // 3. Construct the Crisp Outline Stroke along the baseline and active tab contour
    final strokePath = Path();
    strokePath.moveTo(0, h);
    strokePath.lineTo(math.max(0.0, left - fillet), h);
    strokePath.quadraticBezierTo(left, h, left, h - fillet);
    strokePath.lineTo(left, topRadius);
    strokePath.quadraticBezierTo(left, 0, left + topRadius, 0);
    strokePath.lineTo(right - topRadius, 0);
    strokePath.quadraticBezierTo(right, 0, right, topRadius);
    strokePath.lineTo(right, h - fillet);
    strokePath.quadraticBezierTo(right, h, math.min(w, right + fillet), h);
    strokePath.lineTo(w, h);

    final strokePaint = Paint()
      ..color = strokeColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = isDark ? 1.6 : 2.0
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    canvas.drawPath(strokePath, strokePaint);
  }

  @override
  bool shouldRepaint(covariant _SwiggyConnectedTabPainter oldDelegate) =>
      oldDelegate.activePosition != activePosition ||
      oldDelegate.activeColor != activeColor ||
      oldDelegate.strokeColor != strokeColor ||
      oldDelegate.isDark != isDark;
}
