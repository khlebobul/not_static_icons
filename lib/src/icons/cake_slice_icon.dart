import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../core/animated_svg_icon_base.dart';

/// Animated Cake Slice Icon - Cherry bounces
class CakeSliceIcon extends AnimatedSVGIcon {
  const CakeSliceIcon({
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
  String get animationDescription => "Cherry bounces";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    // Bounce: 0 -> 1 -> 0
    final bounce = math.sin(animationValue * math.pi);
    return CakeSlicePainter(
      color: color,
      bounceY: -bounce * 3.0,
      strokeWidth: strokeWidth,
    );
  }
}

class CakeSlicePainter extends CustomPainter {
  final Color color;
  final double bounceY;
  final double strokeWidth;

  CakeSlicePainter({
    required this.color,
    required this.bounceY,
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

    // Cake Body (Static)
    // M16 13H3
    canvas.drawLine(
        Offset(16 * scale, 13 * scale), Offset(3 * scale, 13 * scale), paint);
    // M16 17H3
    canvas.drawLine(
        Offset(16 * scale, 17 * scale), Offset(3 * scale, 17 * scale), paint);

    // m7.2 7.9-3.388 2.5A2 2 0 0 0 3 12.01V20a1 1 0 0 0 1 1h16a1 1 0 0 0 1-1v-8.654c0-2-2.44-6.026-6.44-8.026a1 1 0 0 0-1.082.057L10.4 5.6
    final bodyPath = Path();
    bodyPath.moveTo(7.2 * scale, 7.9 * scale);
    bodyPath.lineTo(
        3.812 * scale, 10.4 * scale); // 7.2-3.388=3.812, 7.9+2.5=10.4
    bodyPath.arcToPoint(
      Offset(3 * scale, 12.01 * scale),
      radius: Radius.circular(2 * scale),
      clockwise: false, // Sweep 0
    );
    bodyPath.lineTo(3 * scale, 20 * scale);
    bodyPath.arcToPoint(
      Offset(4 * scale, 21 * scale),
      radius: Radius.circular(1 * scale),
      clockwise: false, // Sweep 0
    );
    bodyPath.lineTo(20 * scale, 21 * scale);
    bodyPath.arcToPoint(
      Offset(21 * scale, 20 * scale),
      radius: Radius.circular(1 * scale),
      clockwise: false, // Sweep 0
    );
    bodyPath.lineTo(21 * scale, 11.346 * scale); // 20-8.654
    // c0-2-2.44-6.026-6.44-8.026
    // From 21, 11.346
    // cp1: 21, 9.346
    // cp2: 18.56, 5.32
    // end: 14.56, 3.32
    bodyPath.cubicTo(
      21 * scale,
      9.346 * scale,
      18.56 * scale,
      5.32 * scale,
      14.56 * scale,
      3.32 * scale,
    );
    // a1 1 0 0 0-1.082.057
    bodyPath.arcToPoint(
      Offset(13.478 * scale, 3.377 * scale), // 14.56-1.082, 3.32+0.057
      radius: Radius.circular(1 * scale),
      clockwise: false, // Sweep 0
    );
    // L10.4 5.6
    bodyPath.lineTo(10.4 * scale, 5.6 * scale);

    canvas.drawPath(bodyPath, paint);

    // Cherry (Bouncing)
    // circle cx="9" cy="7" r="2"
    canvas.save();
    canvas.translate(0, bounceY * scale);
    canvas.drawCircle(Offset(9 * scale, 7 * scale), 2 * scale, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(CakeSlicePainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.bounceY != bounceY ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
