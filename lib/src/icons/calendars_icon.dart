import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../core/animated_svg_icon_base.dart';

/// Animated Calendars Icon - Back calendar tilts
class CalendarsIcon extends AnimatedSVGIcon {
  const CalendarsIcon({
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
  String get animationDescription => "Back calendar tilts";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    // Tilt: 0 -> -15 degrees -> 0
    final angle = -math.sin(animationValue * math.pi) * (15 * math.pi / 180);

    return CalendarsPainter(
      color: color,
      angle: angle,
      strokeWidth: strokeWidth,
    );
  }
}

class CalendarsPainter extends CustomPainter {
  final Color color;
  final double angle;
  final double strokeWidth;

  CalendarsPainter({
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

    // Front Calendar (Static relative to animation, but drawn last to overlap)
    // We draw back calendar first.

    // Back Calendar (Animated)
    // Pivot around center of front calendar? Or bottom right corner of back calendar?
    // Let's pivot around (15, 10) which is roughly center of front calendar.

    canvas.save();
    canvas.translate(15 * scale, 10 * scale);
    canvas.rotate(angle);
    canvas.translate(-15 * scale, -10 * scale);

    // M15.726 21.01A2 2 0 0 1 14 22H4a2 2 0 0 1-2-2V10a2 2 0 0 1 2-2
    final backPath = Path();
    backPath.moveTo(15.726 * scale, 21.01 * scale);
    backPath.arcToPoint(Offset(14 * scale, 22 * scale),
        radius: Radius.circular(2 * scale), clockwise: true);
    backPath.lineTo(4 * scale, 22 * scale);
    backPath.arcToPoint(Offset(2 * scale, 20 * scale),
        radius: Radius.circular(2 * scale), clockwise: true);
    backPath.lineTo(2 * scale, 10 * scale);
    backPath.arcToPoint(Offset(4 * scale, 8 * scale),
        radius: Radius.circular(2 * scale), clockwise: true);
    canvas.drawPath(backPath, paint);

    // M2 13h2
    canvas.drawLine(
        Offset(2 * scale, 13 * scale), Offset(4 * scale, 13 * scale), paint);

    canvas.restore();

    // Front Calendar
    // rect x="8" y="3" width="14" height="14" rx="2"
    final frontRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(8 * scale, 3 * scale, 14 * scale, 14 * scale),
      Radius.circular(2 * scale),
    );
    // To properly hide the back calendar lines behind the front calendar, we might need to fill it.
    // But SVG is transparent.
    // However, in the original SVG, the paths are just lines.
    // If we rotate the back calendar, it might cross the front calendar lines.
    // Let's just draw it.
    canvas.drawRRect(frontRect, paint);

    // M8 8h14
    canvas.drawLine(
        Offset(8 * scale, 8 * scale), Offset(22 * scale, 8 * scale), paint);

    // Rings (Static, attached to front)
    // M12 2v2
    canvas.drawLine(
        Offset(12 * scale, 2 * scale), Offset(12 * scale, 4 * scale), paint);
    // M18 2v2
    canvas.drawLine(
        Offset(18 * scale, 2 * scale), Offset(18 * scale, 4 * scale), paint);
  }

  @override
  bool shouldRepaint(CalendarsPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.angle != angle ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
