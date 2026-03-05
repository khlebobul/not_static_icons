import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Clock Alert Icon - Clock hands rotate with alert
class ClockAlertIcon extends AnimatedSVGIcon {
  const ClockAlertIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 1200),
    super.strokeWidth = 2.0,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
    super.onTap,
    super.interactive,
    super.controller,
  });

  @override
  String get animationDescription => "Alert pulses urgently";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return ClockAlertPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class ClockAlertPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  ClockAlertPainter({
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

    final scale = size.width / 24.0;

    // Partial circle: M21.25 8.2A10 10 0 1 0 16 21.16
    final circlePath = Path();
    circlePath.moveTo(21.25 * scale, 8.2 * scale);
    circlePath.arcToPoint(
      Offset(16 * scale, 21.16 * scale),
      radius: Radius.circular(10 * scale),
      clockwise: false,
      largeArc: true,
    );
    canvas.drawPath(circlePath, paint);

    // Clock hands with rotation: M12 6v6l4 2
    final oscillation = 4 * animationValue * (1 - animationValue);
    final rotation = oscillation * math.pi / 6;

    canvas.save();
    canvas.translate(12 * scale, 12 * scale);
    canvas.rotate(rotation);
    canvas.translate(-12 * scale, -12 * scale);

    canvas.drawLine(
        Offset(12 * scale, 6 * scale), Offset(12 * scale, 12 * scale), paint);
    canvas.drawLine(
        Offset(12 * scale, 12 * scale), Offset(16 * scale, 14 * scale), paint);

    canvas.restore();

    // Alert symbol with urgent pulse animation
    final pulseScale = 1.0 + oscillation * 0.4;
    final alertOpacity = 0.6 + oscillation * 0.4;

    final alertPaint = Paint()
      ..color = color.withValues(alpha: alertOpacity)
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;

    canvas.save();
    canvas.translate(20 * scale, 16.5 * scale);
    canvas.scale(pulseScale);
    canvas.translate(-20 * scale, -16.5 * scale);

    // Alert line: M20 12v5
    canvas.drawLine(Offset(20 * scale, 12 * scale),
        Offset(20 * scale, 17 * scale), alertPaint);

    // Alert dot: M20 21h.01 (draw as small circle for visibility)
    canvas.drawCircle(
        Offset(20 * scale, 21 * scale),
        0.5 * scale * pulseScale,
        Paint()
          ..color = color.withValues(alpha: alertOpacity)
          ..style = PaintingStyle.fill);

    canvas.restore();
  }

  @override
  bool shouldRepaint(ClockAlertPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
