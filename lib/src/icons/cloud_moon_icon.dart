import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Cloud Moon Icon - Moon glows
class CloudMoonIcon extends AnimatedSVGIcon {
  const CloudMoonIcon({
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
  String get animationDescription => "Moon glows";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return CloudMoonPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class CloudMoonPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  CloudMoonPainter({
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

    // Cloud: M13 16a3 3 0 0 1 0 6H7a5 5 0 1 1 4.9-6z
    final cloudPath = Path();
    cloudPath.moveTo(13 * scale, 16 * scale);
    cloudPath.arcToPoint(
      Offset(13 * scale, 22 * scale),
      radius: Radius.circular(3 * scale),
      clockwise: true,
    );
    cloudPath.lineTo(7 * scale, 22 * scale);
    cloudPath.arcToPoint(
      Offset(11.9 * scale, 16 * scale),
      radius: Radius.circular(5 * scale),
      clockwise: true,
      largeArc: true,
    );
    cloudPath.close();
    canvas.drawPath(cloudPath, paint);

    // Moon with tilt animation
    final oscillation = 4 * animationValue * (1 - animationValue);
    final tilt = oscillation * math.pi / 12;

    canvas.save();
    canvas.translate(16 * scale, 9 * scale);
    canvas.rotate(tilt);
    canvas.translate(-16 * scale, -9 * scale);

    // Moon path: M18.376 14.512a6 6 0 0 0 3.461-4.127c.148-.625-.659-.97-1.248-.714a4 4 0 0 1-5.259-5.26c.255-.589-.09-1.395-.716-1.248a6 6 0 0 0-4.594 5.36
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
  }

  @override
  bool shouldRepaint(CloudMoonPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
