import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../core/animated_svg_icon_base.dart';

/// Animated Chart Spline Icon - Wave animation along the curve
class ChartSplineIcon extends AnimatedSVGIcon {
  const ChartSplineIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 600),
    super.strokeWidth = 2.0,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
    super.onTap,
    super.interactive,
    super.controller,
  });

  @override
  String get animationDescription => "Wave animation along the spline";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return ChartSplinePainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

/// Painter for Chart Spline icon
class ChartSplinePainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  ChartSplinePainter({
    required this.color,
    required this.animationValue,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;

    final scale = size.width / 24.0;

    // ========== STATIC PART - AXES ==========
    final axisPath = Path();
    axisPath.moveTo(3 * scale, 3 * scale);
    axisPath.lineTo(3 * scale, 19 * scale);
    axisPath.quadraticBezierTo(3 * scale, 21 * scale, 5 * scale, 21 * scale);
    axisPath.lineTo(21 * scale, 21 * scale);
    canvas.drawPath(axisPath, paint);

    // ========== ANIMATED PART - SPLINE WITH WAVE ==========
    // Original points: (7,16) -> (11,9) -> (15,12) -> (20,5)
    // Wave travels from left to right

    final wavePhase = animationValue * math.pi * 2;
    final waveAmplitude = 2.0;

    // Calculate wave offset for each point based on x position
    double waveOffset(double x) {
      // Wave travels from left to right
      final normalizedX = (x - 7) / 13; // 0 to 1 across the curve
      return math.sin(wavePhase - normalizedX * math.pi * 2) * waveAmplitude;
    }

    // Key points with wave applied
    final p0y = 16 + waveOffset(7);
    final p1y = 9 + waveOffset(11);
    final p2y = 12 + waveOffset(15);
    final p3y = 5 + waveOffset(20);

    final splinePath = Path();
    splinePath.moveTo(7 * scale, p0y * scale);

    // First curve
    splinePath.cubicTo(
      7.5 * scale,
      (14 + waveOffset(7.5)) * scale,
      9.5 * scale,
      (9 + waveOffset(9.5)) * scale,
      11 * scale,
      p1y * scale,
    );

    // Second curve
    splinePath.cubicTo(
      13 * scale,
      (9 + waveOffset(13)) * scale,
      13 * scale,
      (12 + waveOffset(13)) * scale,
      15 * scale,
      p2y * scale,
    );

    // Third curve
    splinePath.cubicTo(
      17.5 * scale,
      (12 + waveOffset(17.5)) * scale,
      18.5 * scale,
      (7 + waveOffset(18.5)) * scale,
      20 * scale,
      p3y * scale,
    );

    canvas.drawPath(splinePath, paint);
  }

  @override
  bool shouldRepaint(ChartSplinePainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
