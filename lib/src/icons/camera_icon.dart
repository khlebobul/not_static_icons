import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../core/animated_svg_icon_base.dart';

/// Animated Camera Icon - Shutter button presses
class CameraIcon extends AnimatedSVGIcon {
  const CameraIcon({
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
  String get animationDescription => "Shutter button presses";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    // Press: 0 -> 1 -> 0
    final press = math.sin(animationValue * math.pi);

    return CameraPainter(
      color: color,
      press: press,
      strokeWidth: strokeWidth,
    );
  }
}

class CameraPainter extends CustomPainter {
  final Color color;
  final double press;
  final double strokeWidth;

  CameraPainter({
    required this.color,
    required this.press,
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

    // Body
    // M13.997 4a2 2 0 0 1 1.76 1.05l.486.9A2 2 0 0 0 18.003 7H20a2 2 0 0 1 2 2v9a2 2 0 0 1-2 2H4a2 2 0 0 1-2-2V9a2 2 0 0 1 2-2h1.997a2 2 0 0 0 1.759-1.048l.489-.904A2 2 0 0 1 10.004 4z
    final bodyPath = Path();
    bodyPath.moveTo(13.997 * scale, 4 * scale);
    bodyPath.arcToPoint(Offset(15.757 * scale, 5.05 * scale),
        radius: Radius.circular(2 * scale), clockwise: true);
    bodyPath.lineTo(16.243 * scale, 5.95 * scale);
    bodyPath.arcToPoint(Offset(18.003 * scale, 7 * scale),
        radius: Radius.circular(2 * scale), clockwise: false);
    bodyPath.lineTo(20 * scale, 7 * scale);
    bodyPath.arcToPoint(Offset(22 * scale, 9 * scale),
        radius: Radius.circular(2 * scale), clockwise: true);
    bodyPath.lineTo(22 * scale, 18 * scale);
    bodyPath.arcToPoint(Offset(20 * scale, 20 * scale),
        radius: Radius.circular(2 * scale), clockwise: true);
    bodyPath.lineTo(4 * scale, 20 * scale);
    bodyPath.arcToPoint(Offset(2 * scale, 18 * scale),
        radius: Radius.circular(2 * scale), clockwise: true);
    bodyPath.lineTo(2 * scale, 9 * scale);
    bodyPath.arcToPoint(Offset(4 * scale, 7 * scale),
        radius: Radius.circular(2 * scale), clockwise: true);
    bodyPath.lineTo(5.997 * scale, 7 * scale);
    bodyPath.arcToPoint(Offset(7.756 * scale, 5.952 * scale),
        radius: Radius.circular(2 * scale), clockwise: false);
    bodyPath.lineTo(8.245 * scale, 5.048 * scale);
    bodyPath.arcToPoint(Offset(10.004 * scale, 4 * scale),
        radius: Radius.circular(2 * scale), clockwise: true);
    bodyPath.close();
    canvas.drawPath(bodyPath, paint);

    // Lens (Animated - Shutter effect)
    // circle cx="12" cy="13" r="3"
    // Let's scale it slightly or simulate a shutter closing/opening?
    // Or maybe just flash?
    // User requested "Shutter button presses".
    // The button isn't explicitly drawn in SVG, it's part of the top shape.
    // Maybe we can animate the top part pressing down?
    // Or animate the lens "taking a picture" (iris closing).

    // Let's animate the lens scaling down and up (iris effect).
    final lensScale = 1.0 - press * 0.2;

    canvas.save();
    canvas.translate(12 * scale, 13 * scale);
    canvas.scale(lensScale);
    canvas.translate(-12 * scale, -13 * scale);
    canvas.drawCircle(Offset(12 * scale, 13 * scale), 3 * scale, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(CameraPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.press != press ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
