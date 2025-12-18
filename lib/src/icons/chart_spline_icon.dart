import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Chart Spline Icon - Spline curve pulses up and down
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
  });

  @override
  String get animationDescription => "Spline curve pulses up and down";

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

    // ========== ANIMATED PART - SPLINE CURVE ==========
    // Original: M7 16c.5-2 1.5-7 4-7 2 0 2 3 4 3 2.5 0 4.5-5 5-7
    // Points: (7,16) -> curve to (11,9) -> curve to (15,12) -> curve to (20,5)
    final oscillation = 4 * animationValue * (1 - animationValue);
    final lift = oscillation * 2.0;

    final splinePath = Path();
    splinePath.moveTo(7 * scale, (16 - lift) * scale);

    // First curve: from (7,16) curving up to (11,9)
    splinePath.cubicTo(
      7.5 * scale,
      (14 - lift) * scale,
      9.5 * scale,
      (9 - lift) * scale,
      11 * scale,
      (9 - lift) * scale,
    );

    // Second curve: from (11,9) curving down to (15,12)
    splinePath.cubicTo(
      13 * scale,
      (9 - lift) * scale,
      13 * scale,
      (12 - lift) * scale,
      15 * scale,
      (12 - lift) * scale,
    );

    // Third curve: from (15,12) curving up to (20,5)
    splinePath.cubicTo(
      17.5 * scale,
      (12 - lift) * scale,
      18.5 * scale,
      (7 - lift) * scale,
      20 * scale,
      (5 - lift) * scale,
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
