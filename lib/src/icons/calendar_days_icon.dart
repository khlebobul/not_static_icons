import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Calendar Days Icon - Days appear sequentially
class CalendarDaysIcon extends AnimatedSVGIcon {
  const CalendarDaysIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 800),
    super.strokeWidth = 2.0,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
    super.onTap,
    super.interactive,
    super.controller,
  });

  @override
  String get animationDescription => "Days appear sequentially";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return CalendarDaysPainter(
      color: color,
      progress: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class CalendarDaysPainter extends CustomPainter {
  final Color color;
  final double progress;
  final double strokeWidth;

  CalendarDaysPainter({
    required this.color,
    required this.progress,
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

    // Days (Animated)
    // M8 14h.01
    // M12 14h.01
    // M16 14h.01
    // M8 18h.01
    // M12 18h.01
    // M16 18h.01

    final days = [
      Offset(8, 14),
      Offset(12, 14),
      Offset(16, 14),
      Offset(8, 18),
      Offset(12, 18),
      Offset(16, 18),
    ];

    // If progress is 0, draw all (static state).
    // If progress > 0, animate appearance.

    double drawProgress = progress;
    if (progress == 0) {
      drawProgress = 1.0;
    }

    for (int i = 0; i < days.length; i++) {
      final day = days[i];
      final threshold = i * (1.0 / days.length);

      if (drawProgress > threshold) {
        // Scale in
        double localProgress =
            ((drawProgress - threshold) / (1.0 / days.length)).clamp(0.0, 1.0);

        canvas.save();
        canvas.translate(day.dx * scale, day.dy * scale);
        canvas.scale(localProgress);

        canvas.drawLine(Offset(0, 0), Offset(0.01 * scale, 0), paint);

        canvas.restore();
      }
    }
  }

  @override
  bool shouldRepaint(CalendarDaysPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.progress != progress ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
