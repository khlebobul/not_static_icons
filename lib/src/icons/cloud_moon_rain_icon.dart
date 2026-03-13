import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Cloud Moon Rain Icon - Moon glows and rain falls
class CloudMoonRainIcon extends AnimatedSVGIcon {
  const CloudMoonRainIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 1500),
    super.strokeWidth = 2.0,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
    super.onTap,
    super.interactive,
    super.controller,
  });

  @override
  String get animationDescription => "Moon glows and rain falls";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return CloudMoonRainPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class CloudMoonRainPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  CloudMoonRainPainter({
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

    // Moon with tilt animation
    final oscillation = 4 * animationValue * (1 - animationValue);
    final tilt = oscillation * math.pi / 12;

    canvas.save();
    canvas.translate(16 * scale, 9 * scale);
    canvas.rotate(tilt);
    canvas.translate(-16 * scale, -9 * scale);

    // Moon path
    final moonPath = Path();
    moonPath.moveTo(18.376 * scale, 14.512 * scale);
    moonPath.arcToPoint(
      Offset(21.837 * scale, 10.385 * scale),
      radius: Radius.circular(6 * scale),
      clockwise: false,
    );
    moonPath.cubicTo(
      21.985 * scale,
      9.76 * scale,
      21.178 * scale,
      9.415 * scale,
      20.589 * scale,
      9.671 * scale,
    );
    moonPath.arcToPoint(
      Offset(15.33 * scale, 4.411 * scale),
      radius: Radius.circular(4 * scale),
      clockwise: true,
    );
    moonPath.cubicTo(
      15.585 * scale,
      3.822 * scale,
      15.24 * scale,
      3.016 * scale,
      14.614 * scale,
      3.163 * scale,
    );
    moonPath.arcToPoint(
      Offset(10.02 * scale, 8.523 * scale),
      radius: Radius.circular(6 * scale),
      clockwise: false,
    );
    canvas.drawPath(moonPath, paint);

    canvas.restore();

    // Cloud: M3 20a5 5 0 1 1 8.9-4H13a3 3 0 0 1 2 5.24
    final cloudPath = Path();
    cloudPath.moveTo(3 * scale, 20 * scale);
    cloudPath.arcToPoint(
      Offset(11.9 * scale, 16 * scale),
      radius: Radius.circular(5 * scale),
      clockwise: true,
      largeArc: true,
    );
    cloudPath.lineTo(13 * scale, 16 * scale);
    cloudPath.arcToPoint(
      Offset(15 * scale, 21.24 * scale),
      radius: Radius.circular(3 * scale),
      clockwise: true,
    );
    canvas.drawPath(cloudPath, paint);

    // Rain with falling animation (full opacity, no displacement at rest)
    canvas.save();
    canvas.translate(0, oscillation * 2.0 * scale);
    // M11 20v2
    canvas.drawLine(
        Offset(11 * scale, 20 * scale), Offset(11 * scale, 22 * scale), paint);
    canvas.restore();

    final t2 = (animationValue * 1.4 - 0.15).clamp(0.0, 1.0);
    final osc2 = 4 * t2 * (1 - t2);
    canvas.save();
    canvas.translate(0, osc2 * 2.0 * scale);
    // M7 19v2
    canvas.drawLine(
        Offset(7 * scale, 19 * scale), Offset(7 * scale, 21 * scale), paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(CloudMoonRainPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
