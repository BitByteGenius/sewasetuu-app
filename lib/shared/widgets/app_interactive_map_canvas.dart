import 'package:flutter/material.dart';
import 'package:sewasetu/app/theme/app_colors.dart';
import 'package:sewasetu/app/theme/app_radius.dart';
import 'package:sewasetu/app/theme/app_shadows.dart';
import 'package:sewasetu/app/theme/app_text_styles.dart';
import 'package:sewasetu/core/utils/formatters.dart';
import 'package:sewasetu/modules/stay/stay.dart';

/// Stylized interactive map canvas with custom property price markers and 400m privacy circle
class AppInteractiveMapCanvas extends StatefulWidget {
  final List<StayEntity> stays;
  final ValueChanged<StayEntity>? onStayTap;
  final StayEntity? initialSelectedStay;
  final bool showPrivacyRadius;

  const AppInteractiveMapCanvas({
    super.key,
    required this.stays,
    this.onStayTap,
    this.initialSelectedStay,
    this.showPrivacyRadius = false,
  });

  @override
  State<AppInteractiveMapCanvas> createState() => _AppInteractiveMapCanvasState();
}

class _AppInteractiveMapCanvasState extends State<AppInteractiveMapCanvas> {
  StayEntity? _selectedStay;

  @override
  void initState() {
    super.initState();
    _selectedStay = widget.initialSelectedStay ?? (widget.stays.isNotEmpty ? widget.stays.first : null);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Stack(
      children: [
        // Custom Stylized Vector Canvas Map
        Positioned.fill(
          child: CustomPaint(
            painter: _MapCanvasPainter(
              isDark: isDark,
              showPrivacyRadius: widget.showPrivacyRadius,
              selectedStayIndex: _selectedStay != null ? widget.stays.indexOf(_selectedStay!) : -1,
            ),
          ),
        ),

        // Interactive Price Markers positioned across map coordinates
        ...widget.stays.asMap().entries.map((entry) {
          final index = entry.key;
          final stay = entry.value;
          final isSelected = _selectedStay?.id == stay.id;

          // Normalized simulated positions on canvas
          final double leftPercent = 0.2 + ((index * 0.23 + 0.1) % 0.6);
          final double topPercent = 0.18 + ((index * 0.28 + 0.08) % 0.55);

          return Positioned(
            left: MediaQuery.of(context).size.width * leftPercent,
            top: 400 * topPercent,
            child: GestureDetector(
              onTap: () {
                setState(() => _selectedStay = stay);
                widget.onStayTap?.call(stay);
              },
              child: AnimatedScale(
                scale: isSelected ? 1.15 : 1.0,
                duration: const Duration(milliseconds: 200),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? (isDark ? AppColors.primaryLight : AppColors.primary)
                        : (isDark ? AppColors.surfaceDark : Colors.white),
                    borderRadius: AppRadius.radiusPill,
                    boxShadow: AppShadows.md,
                    border: Border.all(
                      color: isSelected
                          ? Colors.transparent
                          : (isDark ? AppColors.borderDark : AppColors.borderLight),
                      width: 1.5,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (isSelected) ...[
                        Icon(
                          Icons.apartment_rounded,
                          size: 14,
                          color: isDark ? Colors.black : Colors.white,
                        ),
                        const SizedBox(width: 4),
                      ],
                      Text(
                        AppFormatters.formatCurrency(stay.pricePerNight),
                        style: AppTextStyles.labelMedium(isDark).copyWith(
                          fontWeight: FontWeight.w800,
                          color: isSelected
                              ? (isDark ? Colors.black : Colors.white)
                              : (isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }),

        // 400m Privacy Notice Banner (Top)
        if (widget.showPrivacyRadius)
          Positioned(
            top: 16,
            left: 16,
            right: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: (isDark ? AppColors.surfaceDark : Colors.white).withAlpha(235),
                borderRadius: AppRadius.radiusPill,
                boxShadow: AppShadows.sm,
                border: Border.all(
                  color: isDark ? AppColors.borderDark : AppColors.borderLight,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.security_rounded,
                    size: 15,
                    color: isDark ? AppColors.primaryLight : AppColors.primary,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Approximate location within 400m for host privacy',
                    style: AppTextStyles.labelSmall(isDark).copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),

        // Bottom Selected Property Preview Card
        if (_selectedStay != null)
          Positioned(
            left: 16,
            right: 16,
            bottom: 20,
            child: StayCardWidget(
              stay: _selectedStay!,
              style: StayCardStyle.horizontal,
              onTap: () => widget.onStayTap?.call(_selectedStay!),
            ),
          ),
      ],
    );
  }
}

class _MapCanvasPainter extends CustomPainter {
  final bool isDark;
  final bool showPrivacyRadius;
  final int selectedStayIndex;

  _MapCanvasPainter({
    required this.isDark,
    required this.showPrivacyRadius,
    required this.selectedStayIndex,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // 1. Background Landmass
    final bgPaint = Paint()..color = isDark ? const Color(0xFF1E293B) : const Color(0xFFF1F5F9);
    canvas.drawRect(Offset.zero & size, bgPaint);

    // 2. City River / Lake polygon
    final waterPaint = Paint()..color = isDark ? const Color(0xFF0F172A) : const Color(0xFFE2E8F0);
    final waterPath = Path()
      ..moveTo(0, size.height * 0.35)
      ..cubicTo(
        size.width * 0.3,
        size.height * 0.25,
        size.width * 0.6,
        size.height * 0.45,
        size.width,
        size.height * 0.38,
      )
      ..lineTo(size.width, size.height * 0.48)
      ..cubicTo(
        size.width * 0.6,
        size.height * 0.55,
        size.width * 0.3,
        size.height * 0.35,
        0,
        size.height * 0.45,
      )
      ..close();
    canvas.drawPath(waterPath, waterPaint);

    // 3. Grid / Roads
    final roadPaint = Paint()
      ..color = isDark ? const Color(0xFF334155) : Colors.white
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    // Horizontal roads
    canvas.drawLine(Offset(0, size.height * 0.2), Offset(size.width, size.height * 0.2), roadPaint);
    canvas.drawLine(Offset(0, size.height * 0.6), Offset(size.width, size.height * 0.6), roadPaint);
    canvas.drawLine(Offset(0, size.height * 0.78), Offset(size.width, size.height * 0.78), roadPaint);

    // Vertical & diagonal roads
    canvas.drawLine(Offset(size.width * 0.25, 0), Offset(size.width * 0.25, size.height), roadPaint);
    canvas.drawLine(Offset(size.width * 0.55, 0), Offset(size.width * 0.55, size.height), roadPaint);
    canvas.drawLine(Offset(size.width * 0.8, 0), Offset(size.width * 0.8, size.height), roadPaint);

    // 4. Privacy Radius Circle (400 meter simulated circle)
    if (showPrivacyRadius) {
      final center = Offset(size.width * 0.5, size.height * 0.38);
      final radiusFillPaint = Paint()
        ..color = (isDark ? AppColors.primaryLight : AppColors.primary).withAlpha(35)
        ..style = PaintingStyle.fill;
      final radiusBorderPaint = Paint()
        ..color = (isDark ? AppColors.primaryLight : AppColors.primary).withAlpha(160)
        ..strokeWidth = 2
        ..style = PaintingStyle.stroke;

      canvas.drawCircle(center, 70, radiusFillPaint);
      canvas.drawCircle(center, 70, radiusBorderPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _MapCanvasPainter oldDelegate) {
    return oldDelegate.isDark != isDark ||
        oldDelegate.showPrivacyRadius != showPrivacyRadius ||
        oldDelegate.selectedStayIndex != selectedStayIndex;
  }
}
