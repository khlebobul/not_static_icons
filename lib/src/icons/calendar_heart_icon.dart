import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../core/animated_svg_icon_base.dart';

/// Animated Calendar Heart Icon - Heart beats
class CalendarHeartIcon extends AnimatedSVGIcon {
  const CalendarHeartIcon({
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
  String get animationDescription => "Heart beats";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    // Beat: 1.0 -> 1.3 -> 1.0
    final beat = math.sin(animationValue * math.pi);
    final scale = 1.0 + beat * 0.3;

    return CalendarHeartPainter(
      color: color,
      heartScale: scale,
      strokeWidth: strokeWidth,
    );
  }
}

class CalendarHeartPainter extends CustomPainter {
  final Color color;
  final double heartScale;
  final double strokeWidth;

  CalendarHeartPainter({
    required this.color,
    required this.heartScale,
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
    // M12.127 22H5a2 2 0 0 1-2-2V6a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2v5.125
    final bodyPath = Path();
    bodyPath.moveTo(12.127 * scale, 22 * scale);
    bodyPath.lineTo(5 * scale, 22 * scale);
    bodyPath.arcToPoint(Offset(3 * scale, 20 * scale),
        radius: Radius.circular(2 * scale), clockwise: true);
    bodyPath.lineTo(3 * scale, 6 * scale);
    bodyPath.arcToPoint(Offset(5 * scale, 4 * scale),
        radius: Radius.circular(2 * scale), clockwise: true);
    bodyPath.lineTo(19 * scale, 4 * scale);
    bodyPath.arcToPoint(Offset(21 * scale, 6 * scale),
        radius: Radius.circular(2 * scale), clockwise: true);
    bodyPath.lineTo(21 * scale, 11.125 * scale);
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

    // Heart (Animated)
    // M14.62 18.8A2.25 2.25 0 1 1 18 15.836a2.25 2.25 0 1 1 3.38 2.966l-2.626 2.856a.998.998 0 0 1-1.507 0z
    // Center roughly 18, 18.

    canvas.save();
    canvas.translate(18 * scale, 18 * scale);
    canvas.scale(heartScale);
    canvas.translate(-18 * scale, -18 * scale);

    final heartPath = Path();
    heartPath.moveTo(14.62 * scale, 18.8 * scale);
    // A2.25 2.25 0 1 1 18 15.836
    heartPath.arcToPoint(
      Offset(18 * scale, 15.836 * scale),
      radius: Radius.circular(2.25 * scale),
      largeArc: true,
      clockwise: true,
    );
    // a2.25 2.25 0 1 1 3.38 2.966
    heartPath.arcToPoint(
      Offset(21.38 * scale, 18.802 * scale), // 18+3.38, 15.836+2.966
      radius: Radius.circular(2.25 * scale),
      largeArc: true,
      clockwise: true,
    );
    // l-2.626 2.856
    heartPath.lineTo(18.754 * scale, 21.658 * scale);
    // a.998.998 0 0 1-1.507 0z
    heartPath.arcToPoint(
      Offset(17.247 * scale, 21.658 * scale), // Close enough to start?
      radius: Radius.circular(0.998 * scale),
      clockwise: true,
    );
    heartPath.close();
    canvas.drawPath(heartPath, paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(CalendarHeartPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.heartScale != heartScale ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
