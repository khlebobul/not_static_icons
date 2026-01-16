import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Chart Scatter Icon - Points pulse/scale
class ChartScatterIcon extends AnimatedSVGIcon {
  const ChartScatterIcon({
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
  String get animationDescription => "Scatter points pulse and scale";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return ChartScatterPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

/// Painter for Chart Scatter icon
class ChartScatterPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  ChartScatterPainter({
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

    final fillPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final scale = size.width / 24.0;

    // ========== STATIC PART - AXES ==========
    final axisPath = Path();
    axisPath.moveTo(3 * scale, 3 * scale);
    axisPath.lineTo(3 * scale, 19 * scale);
    axisPath.quadraticBezierTo(3 * scale, 21 * scale, 5 * scale, 21 * scale);
    axisPath.lineTo(21 * scale, 21 * scale);
    canvas.drawPath(axisPath, paint);

    // ========== ANIMATED PART - SCATTER POINTS ==========
    final oscillation = 4 * animationValue * (1 - animationValue);
    // Base radius matches strokeWidth / 2 (so diameter = strokeWidth)
    final baseRadius = strokeWidth / 2;
    final pointScale = 1.0 + oscillation * 1.5;

    // Points with fill (as in original SVG with r=.5)
    // (7.5, 7.5)
    canvas.drawCircle(
      Offset(7.5 * scale, 7.5 * scale),
      baseRadius * pointScale,
      fillPaint,
    );

    // (18.5, 5.5)
    canvas.drawCircle(
      Offset(18.5 * scale, 5.5 * scale),
      baseRadius * pointScale,
      fillPaint,
    );

    // (11.5, 11.5)
    canvas.drawCircle(
      Offset(11.5 * scale, 11.5 * scale),
      baseRadius * pointScale,
      fillPaint,
    );

    // (7.5, 16.5)
    canvas.drawCircle(
      Offset(7.5 * scale, 16.5 * scale),
      baseRadius * pointScale,
      fillPaint,
    );

    // (17.5, 14.5)
    canvas.drawCircle(
      Offset(17.5 * scale, 14.5 * scale),
      baseRadius * pointScale,
      fillPaint,
    );
  }

  @override
  bool shouldRepaint(ChartScatterPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
