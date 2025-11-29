import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../core/animated_svg_icon_base.dart';

/// Animated Calendar Clock Icon - Clock hands spin
class CalendarClockIcon extends AnimatedSVGIcon {
  const CalendarClockIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 1000),
    super.strokeWidth = 2.0,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
  });

  @override
  String get animationDescription => "Clock hands spin";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    // Spin hands: 0 to 360 degrees
    final angle = animationValue * math.pi * 2;

    return CalendarClockPainter(
      color: color,
      angle: angle,
      strokeWidth: strokeWidth,
    );
  }
}

class CalendarClockPainter extends CustomPainter {
  final Color color;
  final double angle;
  final double strokeWidth;

  CalendarClockPainter({
    required this.color,
    required this.angle,
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
    // M21 7.5V6a2 2 0 0 0-2-2H5a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h3.5
    final bodyPath = Path();
    bodyPath.moveTo(21 * scale, 7.5 * scale);
    bodyPath.lineTo(21 * scale, 6 * scale);
    bodyPath.arcToPoint(Offset(19 * scale, 4 * scale),
        radius: Radius.circular(2 * scale), clockwise: false);
    bodyPath.lineTo(5 * scale, 4 * scale);
    bodyPath.arcToPoint(Offset(3 * scale, 6 * scale),
        radius: Radius.circular(2 * scale), clockwise: false);
    bodyPath.lineTo(3 * scale, 20 * scale);
    bodyPath.arcToPoint(Offset(5 * scale, 22 * scale),
        radius: Radius.circular(2 * scale), clockwise: false);
    bodyPath.lineTo(8.5 * scale, 22 * scale);
    canvas.drawPath(bodyPath, paint);

    // M3 10h5
    canvas.drawLine(
        Offset(3 * scale, 10 * scale), Offset(8 * scale, 10 * scale), paint);

    // Top Lines
    // M16 2v4
    canvas.drawLine(
        Offset(16 * scale, 2 * scale), Offset(16 * scale, 6 * scale), paint);
    // M8 2v4
    canvas.drawLine(
        Offset(8 * scale, 2 * scale), Offset(8 * scale, 6 * scale), paint);

    // Clock (Animated)
    // circle cx="16" cy="16" r="6"
    canvas.drawCircle(Offset(16 * scale, 16 * scale), 6 * scale, paint);

    // Hands
    // M16 14v2.2l1.6 1
    // Center is 16, 16.
    // 16, 14 is top (minute hand?). Length 2.
    // 16, 16.2 is center? No, v2.2 from 14 goes to 16.2.
    // So center is roughly 16, 16.
    // Hand 1: 16,14 to 16,16.2.
    // Hand 2: 16,16.2 to 17.6, 17.2.

    // Let's rotate around 16, 16.
    canvas.save();
    canvas.translate(16 * scale, 16 * scale);
    canvas.rotate(angle);
    canvas.translate(-16 * scale, -16 * scale);

    final handsPath = Path();
    handsPath.moveTo(16 * scale, 14 * scale);
    handsPath.lineTo(16 * scale, 16 * scale); // Center
    handsPath.lineTo(17.6 * scale, 17 * scale); // Hour hand?
    canvas.drawPath(handsPath, paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(CalendarClockPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.angle != angle ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
