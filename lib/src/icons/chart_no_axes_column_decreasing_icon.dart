import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Chart No Axes Column Decreasing Icon - Columns shrink and return
class ChartNoAxesColumnDecreasingIcon extends AnimatedSVGIcon {
  const ChartNoAxesColumnDecreasingIcon({
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
  String get animationDescription => "Column bars shrink showing decreasing trend";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return ChartNoAxesColumnDecreasingPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

/// Painter for Chart No Axes Column Decreasing icon
class ChartNoAxesColumnDecreasingPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  ChartNoAxesColumnDecreasingPainter({
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

    // ========== ANIMATED COLUMNS ==========
    // Oscillation for smooth shrink effect
    final oscillation = 4 * animationValue * (1 - animationValue);

    // Left column (tallest): M5 21V3 - shrinks most
    final leftTop = 3.0 + oscillation * 4.0;
    canvas.drawLine(
      Offset(5 * scale, 21 * scale),
      Offset(5 * scale, leftTop * scale),
      paint,
    );

    // Middle column: M12 21V9 - shrinks medium
    final middleTop = 9.0 + oscillation * 3.0;
    canvas.drawLine(
      Offset(12 * scale, 21 * scale),
      Offset(12 * scale, middleTop * scale),
      paint,
    );

    // Right column (shortest): M19 21v-6 (21 to 15) - shrinks least
    final rightTop = 15.0 + oscillation * 2.0;
    canvas.drawLine(
      Offset(19 * scale, 21 * scale),
      Offset(19 * scale, rightTop * scale),
      paint,
    );
  }

  @override
  bool shouldRepaint(ChartNoAxesColumnDecreasingPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
