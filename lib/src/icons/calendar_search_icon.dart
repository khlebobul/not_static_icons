import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../core/animated_svg_icon_base.dart';

/// Animated Calendar Search Icon - Magnifying glass pulses
class CalendarSearchIcon extends AnimatedSVGIcon {
  const CalendarSearchIcon({
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
  String get animationDescription => "Magnifying glass pulses";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    // Pulse: 1.0 -> 1.2 -> 1.0
    final pulse = math.sin(animationValue * math.pi);
    final scale = 1.0 + pulse * 0.2;

    return CalendarSearchPainter(
      color: color,
      searchScale: scale,
      strokeWidth: strokeWidth,
    );
  }
}

class CalendarSearchPainter extends CustomPainter {
  final Color color;
  final double searchScale;
  final double strokeWidth;

  CalendarSearchPainter({
    required this.color,
    required this.searchScale,
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
    // M21 11.75V6a2 2 0 0 0-2-2H5a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h7.25
    final bodyPath = Path();
    bodyPath.moveTo(21 * scale, 11.75 * scale);
    bodyPath.lineTo(21 * scale, 6 * scale);
    bodyPath.arcToPoint(Offset(19 * scale, 4 * scale),
        radius: Radius.circular(2 * scale), clockwise: false);
    bodyPath.lineTo(5 * scale, 4 * scale);
    bodyPath.arcToPoint(Offset(3 * scale, 6 * scale),
        radius: Radius.circular(2 * scale), clockwise: false);
    bodyPath.lineTo(3 * scale, 20 * scale);
    bodyPath.arcToPoint(Offset(5 * scale, 22 * scale),
        radius: Radius.circular(2 * scale), clockwise: false);
    bodyPath.lineTo(12.25 * scale, 22 * scale);
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

    // Search Icon (Animated)
    // circle cx="18" cy="18" r="3"
    // m22 22-1.875-1.875
    // Center 18, 18.

    canvas.save();
    canvas.translate(18 * scale, 18 * scale);
    canvas.scale(searchScale);
    canvas.translate(-18 * scale, -18 * scale);

    canvas.drawCircle(Offset(18 * scale, 18 * scale), 3 * scale, paint);
    canvas.drawLine(Offset(22 * scale, 22 * scale),
        Offset(20.125 * scale, 20.125 * scale), paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(CalendarSearchPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.searchScale != searchScale ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
