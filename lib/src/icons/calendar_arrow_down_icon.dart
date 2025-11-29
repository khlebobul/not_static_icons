import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../core/animated_svg_icon_base.dart';

/// Animated Calendar Arrow Down Icon - Arrow moves down
class CalendarArrowDownIcon extends AnimatedSVGIcon {
  const CalendarArrowDownIcon({
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
  String get animationDescription => "Arrow moves down";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    // Move down: 0 -> 1 -> 0
    final move = math.sin(animationValue * math.pi) * 3.0;

    return CalendarArrowDownPainter(
      color: color,
      offsetY: move,
      strokeWidth: strokeWidth,
    );
  }
}

class CalendarArrowDownPainter extends CustomPainter {
  final Color color;
  final double offsetY;
  final double strokeWidth;

  CalendarArrowDownPainter({
    required this.color,
    required this.offsetY,
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

    // Calendar Body (Static)
    // M21 11.354V6a2 2 0 0 0-2-2H5a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h7.343
    final bodyPath = Path();
    bodyPath.moveTo(21 * scale, 11.354 * scale);
    bodyPath.lineTo(21 * scale, 6 * scale);
    bodyPath.arcToPoint(Offset(19 * scale, 4 * scale),
        radius: Radius.circular(2 * scale), clockwise: false);
    bodyPath.lineTo(5 * scale, 4 * scale);
    bodyPath.arcToPoint(Offset(3 * scale, 6 * scale),
        radius: Radius.circular(2 * scale), clockwise: false);
    bodyPath.lineTo(3 * scale, 20 * scale);
    bodyPath.arcToPoint(Offset(5 * scale, 22 * scale),
        radius: Radius.circular(2 * scale), clockwise: false);
    bodyPath.lineTo(12.343 * scale, 22 * scale);
    canvas.drawPath(bodyPath, paint);

    // Top Lines
    // M16 2v4
    canvas.drawLine(
        Offset(16 * scale, 2 * scale), Offset(16 * scale, 6 * scale), paint);
    // M8 2v4
    canvas.drawLine(
        Offset(8 * scale, 2 * scale), Offset(8 * scale, 6 * scale), paint);

    // Horizontal Line
    // M3 10h18
    canvas.drawLine(
        Offset(3 * scale, 10 * scale), Offset(21 * scale, 10 * scale), paint);

    // Arrow (Animated)
    // m14 18 4 4 4-4
    // M18 14v8

    canvas.save();
    canvas.translate(0, offsetY * scale);

    final arrowPath = Path();
    arrowPath.moveTo(14 * scale, 18 * scale);
    arrowPath.lineTo(18 * scale, 22 * scale);
    arrowPath.lineTo(22 * scale, 18 * scale);
    canvas.drawPath(arrowPath, paint);

    canvas.drawLine(
        Offset(18 * scale, 14 * scale), Offset(18 * scale, 22 * scale), paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(CalendarArrowDownPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.offsetY != offsetY ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
