import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Bell Off Icon - bell swings slightly; slash draws in
class BellOffIcon extends AnimatedSVGIcon {
  const BellOffIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 900),
    super.strokeWidth = 2.0,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
    super.resetToStartOnComplete = true,
    super.onTap,
    super.interactive,
    super.controller,
  });

  @override
  String get animationDescription => 'Bell swings, slash draws in';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return _BellOffPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class _BellOffPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _BellOffPainter({
    required this.color,
    required this.animationValue,
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

    final double scale = size.width / 24.0;

    // Slash (M2 2 L22 22); initial state matches original
    final double t = animationValue.clamp(0.0, 1.0);
    final Offset sStart = Offset(2 * scale, 2 * scale);
    final Offset sEnd = Offset(22 * scale, 22 * scale);
    if (t == 0.0) {
      canvas.drawLine(sStart, sEnd, paint);
    } else {
      final Offset sCurr = Offset(
        sStart.dx + (sEnd.dx - sStart.dx) * t,
        sStart.dy + (sEnd.dy - sStart.dy) * t,
      );
      canvas.drawLine(sStart, sCurr, paint);
    }

    // Right path segment from svg (M17 17H4 ...)
    final Path right = Path()
      ..moveTo(17 * scale, 17 * scale)
      ..lineTo(4 * scale, 17 * scale)
      ..arcToPoint(
        Offset(3.26 * scale, 15.327 * scale),
        radius: Radius.circular(1 * scale),
        clockwise: true,
      )
      ..cubicTo(
        4.59 * scale,
        13.956 * scale,
        6 * scale,
        12.499 * scale,
        6 * scale,
        8 * scale,
      );

    // Left/top segment (M8.668 3.01 A6 6 0 0 1 18 8 c0 2.687 .77 4.653 1.707 6.05)
    final Path left = Path()
      ..moveTo(8.668 * scale, 3.01 * scale)
      ..arcToPoint(
        Offset(18 * scale, 8 * scale),
        radius: Radius.circular(6 * scale),
        clockwise: true,
      )
      ..relativeCubicTo(
        0.0,
        2.687 * scale,
        0.77 * scale,
        4.653 * scale,
        1.707 * scale,
        6.05 * scale,
      );

    // Clapper arc
    final Path clapper = Path()
      ..moveTo(10.268 * scale, 21 * scale)
      ..arcToPoint(
        Offset(13.732 * scale, 21 * scale),
        radius: Radius.circular(2 * scale),
        clockwise: false,
      );

    // Swing all bell parts together
    final Offset pivot = Offset(12 * scale, 8 * scale);
    final double angle = 0.18 * math.sin(math.pi * animationValue);
    canvas.save();
    canvas.translate(pivot.dx, pivot.dy);
    canvas.rotate(angle);
    canvas.translate(-pivot.dx, -pivot.dy);

    canvas.drawPath(right, paint);
    canvas.drawPath(left, paint);
    canvas.drawPath(clapper, paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(_BellOffPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
