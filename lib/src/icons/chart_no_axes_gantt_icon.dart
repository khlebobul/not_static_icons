import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Chart No Axes Gantt Icon - Bars slide horizontally
class ChartNoAxesGanttIcon extends AnimatedSVGIcon {
  const ChartNoAxesGanttIcon({
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
  String get animationDescription => "Gantt bars slide horizontally";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return ChartNoAxesGanttPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

/// Painter for Chart No Axes Gantt icon
class ChartNoAxesGanttPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  ChartNoAxesGanttPainter({
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

    // ========== ANIMATED BARS ==========
    // Oscillation for smooth slide effect
    final oscillation = 4 * animationValue * (1 - animationValue);
    final slideOffset = oscillation * 2.0;

    // Top bar: M6 5h12 - slides right
    canvas.drawLine(
      Offset((6 + slideOffset) * scale, 5 * scale),
      Offset((18 + slideOffset) * scale, 5 * scale),
      paint,
    );

    // Middle bar: M4 12h10 - slides left
    canvas.drawLine(
      Offset((4 - slideOffset) * scale, 12 * scale),
      Offset((14 - slideOffset) * scale, 12 * scale),
      paint,
    );

    // Bottom bar: M12 19h8 - slides right
    canvas.drawLine(
      Offset((12 + slideOffset) * scale, 19 * scale),
      Offset((20 + slideOffset) * scale, 19 * scale),
      paint,
    );
  }

  @override
  bool shouldRepaint(ChartNoAxesGanttPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
