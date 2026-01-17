import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Chart Gantt Icon - Bars slide horizontally
class ChartGanttIcon extends AnimatedSVGIcon {
  const ChartGanttIcon({
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
  String get animationDescription => "Gantt chart bars slide horizontally";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return ChartGanttPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

/// Painter for Chart Gantt icon
class ChartGanttPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  ChartGanttPainter({
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
    // M3 3v16a2 2 0 0 0 2 2h16
    final axisPath = Path();
    axisPath.moveTo(3 * scale, 3 * scale);
    axisPath.lineTo(3 * scale, 19 * scale);
    axisPath.quadraticBezierTo(3 * scale, 21 * scale, 5 * scale, 21 * scale);
    axisPath.lineTo(21 * scale, 21 * scale);
    canvas.drawPath(axisPath, paint);

    // ========== ANIMATED PART - GANTT BARS ==========
    // Oscillation for smooth slide effect
    final oscillation = 4 * animationValue * (1 - animationValue);
    final slideOffset = oscillation * 2.0;

    // Top bar: M10 6h8 - slides right
    canvas.drawLine(
      Offset((10 + slideOffset) * scale, 6 * scale),
      Offset((18 + slideOffset) * scale, 6 * scale),
      paint,
    );

    // Middle bar: M8 11h7 - slides left
    canvas.drawLine(
      Offset((8 - slideOffset) * scale, 11 * scale),
      Offset((15 - slideOffset) * scale, 11 * scale),
      paint,
    );

    // Bottom bar: M12 16h6 - slides right
    canvas.drawLine(
      Offset((12 + slideOffset) * scale, 16 * scale),
      Offset((18 + slideOffset) * scale, 16 * scale),
      paint,
    );
  }

  @override
  bool shouldRepaint(ChartGanttPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
