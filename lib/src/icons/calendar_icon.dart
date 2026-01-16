import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../core/animated_svg_icon_base.dart';

/// Animated Calendar Icon - Top hooks stretch
class CalendarIcon extends AnimatedSVGIcon {
  const CalendarIcon({
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
  String get animationDescription => "Top hooks stretch";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    // Stretch: 0 -> 4 -> 0 (length increase)
    final stretch = math.sin(animationValue * math.pi) * 2.0;

    return CalendarPainter(
      color: color,
      stretch: stretch,
      strokeWidth: strokeWidth,
    );
  }
}

class CalendarPainter extends CustomPainter {
  final Color color;
  final double stretch;
  final double strokeWidth;

  CalendarPainter({
    required this.color,
    required this.stretch,
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
    // rect width="18" height="18" x="3" y="4" rx="2"
    final rect = RRect.fromRectAndRadius(
      Rect.fromLTWH(3 * scale, 4 * scale, 18 * scale, 18 * scale),
      Radius.circular(2 * scale),
    );
    canvas.drawRRect(rect, paint);

    // Top Lines (Animated)
    // M16 2v4
    // M8 2v4
    // Stretch up? Or down?
    // Let's stretch up.
    // 2 - stretch to 6.

    canvas.drawLine(Offset(16 * scale, (2 - stretch) * scale),
        Offset(16 * scale, 6 * scale), paint);
    canvas.drawLine(Offset(8 * scale, (2 - stretch) * scale),
        Offset(8 * scale, 6 * scale), paint);

    // Horizontal Line
    // M3 10h18
    canvas.drawLine(
        Offset(3 * scale, 10 * scale), Offset(21 * scale, 10 * scale), paint);
  }

  @override
  bool shouldRepaint(CalendarPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.stretch != stretch ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
