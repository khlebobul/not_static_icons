import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../core/animated_svg_icon_base.dart';

/// Animated Calendar Off Icon - Slash appears
class CalendarOffIcon extends AnimatedSVGIcon {
  const CalendarOffIcon({
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
  String get animationDescription => "Slash appears";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    // Slash: 0 -> 1 (draws itself)
    // But user wants "return to original".
    // Original has slash.
    // So maybe it shakes? Or redraws?
    // Let's make it shake like BugOffIcon.

    final shake = math.sin(animationValue * math.pi * 3) * 0.1;

    return CalendarOffPainter(
      color: color,
      shake: shake,
      strokeWidth: strokeWidth,
    );
  }
}

class CalendarOffPainter extends CustomPainter {
  final Color color;
  final double shake;
  final double strokeWidth;

  CalendarOffPainter({
    required this.color,
    required this.shake,
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

    // Shake the whole icon? Or just the slash?
    // Let's shake the whole icon slightly.
    canvas.save();
    canvas.translate(shake * size.width, 0);

    // Calendar Body (Broken)
    // M4.2 4.2A2 2 0 0 0 3 6v14a2 2 0 0 0 2 2h14a2 2 0 0 0 1.82-1.18
    final bodyPath1 = Path();
    bodyPath1.moveTo(4.2 * scale, 4.2 * scale);
    bodyPath1.arcToPoint(Offset(3 * scale, 6 * scale),
        radius: Radius.circular(2 * scale), clockwise: false);
    bodyPath1.lineTo(3 * scale, 20 * scale);
    bodyPath1.arcToPoint(Offset(5 * scale, 22 * scale),
        radius: Radius.circular(2 * scale), clockwise: false);
    bodyPath1.lineTo(19 * scale, 22 * scale);
    bodyPath1.arcToPoint(Offset(20.82 * scale, 20.82 * scale),
        radius: Radius.circular(2 * scale), clockwise: false);
    canvas.drawPath(bodyPath1, paint);

    // M21 15.5V6a2 2 0 0 0-2-2H9.5
    final bodyPath2 = Path();
    bodyPath2.moveTo(21 * scale, 15.5 * scale);
    bodyPath2.lineTo(21 * scale, 6 * scale);
    bodyPath2.arcToPoint(Offset(19 * scale, 4 * scale),
        radius: Radius.circular(2 * scale), clockwise: false);
    bodyPath2.lineTo(9.5 * scale, 4 * scale);
    canvas.drawPath(bodyPath2, paint);

    // Top Lines
    // M16 2v4
    canvas.drawLine(
        Offset(16 * scale, 2 * scale), Offset(16 * scale, 6 * scale), paint);

    // Horizontal Line Parts
    // M3 10h7
    canvas.drawLine(
        Offset(3 * scale, 10 * scale), Offset(10 * scale, 10 * scale), paint);
    // M21 10h-5.5
    canvas.drawLine(Offset(21 * scale, 10 * scale),
        Offset(15.5 * scale, 10 * scale), paint);

    // Slash
    // m2 2 20 20
    canvas.drawLine(
        Offset(2 * scale, 2 * scale), Offset(22 * scale, 22 * scale), paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(CalendarOffPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.shake != shake ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
