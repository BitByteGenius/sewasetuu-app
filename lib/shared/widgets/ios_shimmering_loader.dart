import 'dart:math' as math;
import 'package:flutter/material.dart';

/// Custom Shimmering iOS-style activity loader.
/// Renders authentic radial spokes with continuous sweeping opacity shimmer.
class IosShimmeringLoader extends StatefulWidget {
  final double size;
  final Color color;
  final int spokeCount;
  final Duration duration;

  const IosShimmeringLoader({
    super.key,
    this.size = 24.0,
    this.color = Colors.white,
    this.spokeCount = 10,
    this.duration = const Duration(milliseconds: 900),
  });

  @override
  State<IosShimmeringLoader> createState() => _IosShimmeringLoaderState();
}

class _IosShimmeringLoaderState extends State<IosShimmeringLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return CustomPaint(
            painter: _IosShimmerPainter(
              progress: _controller.value,
              color: widget.color,
              spokeCount: widget.spokeCount,
            ),
          );
        },
      ),
    );
  }
}

class _IosShimmerPainter extends CustomPainter {
  final double progress;
  final Color color;
  final int spokeCount;

  _IosShimmerPainter({
    required this.progress,
    required this.color,
    required this.spokeCount,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    final spokeLength = radius * 0.38;
    final spokeWidth = math.max(1.8, radius * 0.16);

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = spokeWidth;

    for (int i = 0; i < spokeCount; i++) {
      final angle = (i * 2 * math.pi / spokeCount) - (math.pi / 2);

      // Calculate shimmer phase offset
      final spokeProgress = (i / spokeCount);
      double fade = (progress - spokeProgress);
      if (fade < 0) fade += 1.0;

      // Exponential fade curve for authentic iOS trailing tail
      final opacity = math.pow(fade, 1.8).clamp(0.12, 1.0).toDouble();

      paint.color = color.withValues(alpha: opacity);

      final startRadius = radius * 0.54;
      final endRadius = startRadius + spokeLength;

      final start = Offset(
        center.dx + startRadius * math.cos(angle),
        center.dy + startRadius * math.sin(angle),
      );
      final end = Offset(
        center.dx + endRadius * math.cos(angle),
        center.dy + endRadius * math.sin(angle),
      );

      canvas.drawLine(start, end, paint);
    }
  }

  @override
  bool shouldRepaint(_IosShimmerPainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.color != color;
  }
}
