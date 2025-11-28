import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Calendar Range Icon - Range line draws itself
class CalendarRangeIcon extends AnimatedSVGIcon {
  const CalendarRangeIcon({
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
  String get animationDescription => "Range line draws itself";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return CalendarRangePainter(
      color: color,
      progress: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class CalendarRangePainter extends CustomPainter {
  final Color color;
  final double progress;
  final double strokeWidth;

  CalendarRangePainter({
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
    canvas.drawLine(Offset(16 * scale, 2 * scale), Offset(16 * scale, 6 * scale), paint);
    // M8 2v4
    canvas.drawLine(Offset(8 * scale, 2 * scale), Offset(8 * scale, 6 * scale), paint);
    
    // Horizontal Line
    // M3 10h18
    canvas.drawLine(Offset(3 * scale, 10 * scale), Offset(21 * scale, 10 * scale), paint);

    // Range (Animated)
    // M17 14h-6
    // M13 18H7
    // M7 14h.01
    // M17 18h.01
    
    // Let's animate the lines drawing.
    final rangePath = Path();
    rangePath.moveTo(17 * scale, 14 * scale);
    rangePath.lineTo(11 * scale, 14 * scale);
    rangePath.moveTo(13 * scale, 18 * scale);
    rangePath.lineTo(7 * scale, 18 * scale);
    
    // Dots
    rangePath.moveTo(7 * scale, 14 * scale);
    rangePath.lineTo(7.01 * scale, 14 * scale);
    rangePath.moveTo(17 * scale, 18 * scale);
    rangePath.lineTo(17.01 * scale, 18 * scale);
    
    double drawProgress = progress;
    if (progress == 0) {
      drawProgress = 1.0;
    }
    
    if (drawProgress > 0) {
      final pathMetrics = rangePath.computeMetrics();
      for (final metric in pathMetrics) {
        final extractPath = metric.extractPath(0.0, metric.length * drawProgress);
        canvas.drawPath(extractPath, paint);
      }
    }
  }

  @override
  bool shouldRepaint(CalendarRangePainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.progress != progress ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
