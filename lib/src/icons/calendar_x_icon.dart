import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Calendar X Icon - X draws itself
class CalendarXIcon extends AnimatedSVGIcon {
  const CalendarXIcon({
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
  String get animationDescription => "X draws itself";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return CalendarXPainter(
      color: color,
      progress: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class CalendarXPainter extends CustomPainter {
  final Color color;
  final double progress;
  final double strokeWidth;

  CalendarXPainter({
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

    // X (Animated)
    // m14 14-4 4
    // m10 14 4 4
    
    final xPath = Path();
    xPath.moveTo(14 * scale, 14 * scale);
    xPath.lineTo(10 * scale, 18 * scale);
    xPath.moveTo(10 * scale, 14 * scale);
    xPath.lineTo(14 * scale, 18 * scale);
    
    double drawProgress = progress;
    if (progress == 0) {
      drawProgress = 1.0;
    }
    
    if (drawProgress > 0) {
      final pathMetrics = xPath.computeMetrics();
      for (final metric in pathMetrics) {
        final extractPath = metric.extractPath(0.0, metric.length * drawProgress);
        canvas.drawPath(extractPath, paint);
      }
    }
  }

  @override
  bool shouldRepaint(CalendarXPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.progress != progress ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
