import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Calendar Plus Icon - Plus sign draws itself
class CalendarPlusIcon extends AnimatedSVGIcon {
  const CalendarPlusIcon({
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
  String get animationDescription => "Plus sign draws itself";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return CalendarPlusPainter(
      color: color,
      progress: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class CalendarPlusPainter extends CustomPainter {
  final Color color;
  final double progress;
  final double strokeWidth;

  CalendarPlusPainter({
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
    // M21 12.598V6a2 2 0 0 0-2-2H5a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h8.5
    final bodyPath = Path();
    bodyPath.moveTo(21 * scale, 12.598 * scale);
    bodyPath.lineTo(21 * scale, 6 * scale);
    bodyPath.arcToPoint(Offset(19 * scale, 4 * scale),
        radius: Radius.circular(2 * scale), clockwise: false);
    bodyPath.lineTo(5 * scale, 4 * scale);
    bodyPath.arcToPoint(Offset(3 * scale, 6 * scale),
        radius: Radius.circular(2 * scale), clockwise: false);
    bodyPath.lineTo(3 * scale, 20 * scale);
    bodyPath.arcToPoint(Offset(5 * scale, 22 * scale),
        radius: Radius.circular(2 * scale), clockwise: false);
    bodyPath.lineTo(13.5 * scale, 22 * scale);
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

    // Plus (Animated)
    // M16 19h6
    // M19 16v6

    final plusPath = Path();
    plusPath.moveTo(16 * scale, 19 * scale);
    plusPath.lineTo(22 * scale, 19 * scale);
    plusPath.moveTo(19 * scale, 16 * scale);
    plusPath.lineTo(19 * scale, 22 * scale);

    double drawProgress = progress;
    if (progress == 0) {
      drawProgress = 1.0;
    }

    if (drawProgress > 0) {
      final pathMetrics = plusPath.computeMetrics();
      for (final metric in pathMetrics) {
        final extractPath =
            metric.extractPath(0.0, metric.length * drawProgress);
        canvas.drawPath(extractPath, paint);
      }
    }
  }

  @override
  bool shouldRepaint(CalendarPlusPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.progress != progress ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
