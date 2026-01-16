import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Calendar Minus 2 Icon - Minus sign draws itself
class CalendarMinus2Icon extends AnimatedSVGIcon {
  const CalendarMinus2Icon({
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
  String get animationDescription => "Minus sign draws itself";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return CalendarMinus2Painter(
      color: color,
      progress: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class CalendarMinus2Painter extends CustomPainter {
  final Color color;
  final double progress;
  final double strokeWidth;

  CalendarMinus2Painter({
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

    // Minus (Animated)
    // M10 16h4

    final minusPath = Path();
    minusPath.moveTo(10 * scale, 16 * scale);
    minusPath.lineTo(14 * scale, 16 * scale);

    double drawProgress = progress;
    if (progress == 0) {
      drawProgress = 1.0;
    }

    if (drawProgress > 0) {
      final pathMetrics = minusPath.computeMetrics();
      for (final metric in pathMetrics) {
        final extractPath =
            metric.extractPath(0.0, metric.length * drawProgress);
        canvas.drawPath(extractPath, paint);
      }
    }
  }

  @override
  bool shouldRepaint(CalendarMinus2Painter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.progress != progress ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
