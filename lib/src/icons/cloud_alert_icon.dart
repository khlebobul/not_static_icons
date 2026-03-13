import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Cloud Alert Icon - Alert pulses
class CloudAlertIcon extends AnimatedSVGIcon {
  const CloudAlertIcon({
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
  String get animationDescription => "Alert pulses";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return CloudAlertPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class CloudAlertPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  CloudAlertPainter({
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

    // Cloud: M8.128 16.949A7 7 0 1 1 15.71 8h1.79a1 1 0 0 1 0 9h-1.642
    final cloudPath = Path();
    cloudPath.moveTo(8.128 * scale, 16.949 * scale);
    cloudPath.arcToPoint(
      Offset(15.71 * scale, 8 * scale),
      radius: Radius.circular(7 * scale),
      clockwise: true,
      largeArc: true,
    );
    cloudPath.lineTo(17.5 * scale, 8 * scale);
    cloudPath.arcToPoint(
      Offset(17.5 * scale, 17 * scale),
      radius: Radius.circular(1 * scale),
      clockwise: true,
      largeArc: false,
    );
    cloudPath.lineTo(15.858 * scale, 17 * scale);
    canvas.drawPath(cloudPath, paint);

    // Alert with shake animation (full opacity)
    final oscillation = 4 * animationValue * (1 - animationValue);
    final shakeX = math.sin(animationValue * math.pi * 6) * oscillation * 1.0;

    canvas.save();
    canvas.translate(shakeX * scale, 0);

    // Alert line: M12 12v4
    canvas.drawLine(
        Offset(12 * scale, 12 * scale), Offset(12 * scale, 16 * scale), paint);

    // Alert dot: M12 20h.01
    canvas.drawCircle(
        Offset(12 * scale, 20 * scale),
        0.5 * scale,
        Paint()
          ..color = color
          ..style = PaintingStyle.fill);

    canvas.restore();
  }

  @override
  bool shouldRepaint(CloudAlertPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
