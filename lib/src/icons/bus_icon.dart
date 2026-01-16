import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../core/animated_svg_icon_base.dart';

/// Animated Bus Icon - Bus moves forward and bounces
class BusIcon extends AnimatedSVGIcon {
  const BusIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 1000),
    super.strokeWidth = 2.0,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
    super.onTap,
    super.interactive,
    super.controller,
  });

  @override
  String get animationDescription => "Bus moves forward and bounces";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    // Bounce: 2 cycles
    final bounce = math.sin(animationValue * math.pi * 4).abs() * 1.0;

    // Wheel rotation: 0 to 2pi * 2
    final rotation = animationValue * math.pi * 4;

    return BusPainter(
      color: color,
      bounceY: -bounce,
      wheelRotation: rotation,
      strokeWidth: strokeWidth,
    );
  }
}

class BusPainter extends CustomPainter {
  final Color color;
  final double bounceY;
  final double wheelRotation;
  final double strokeWidth;

  BusPainter({
    required this.color,
    required this.bounceY,
    required this.wheelRotation,
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

    canvas.save();
    canvas.translate(0, bounceY * scale);

    // Windows
    // M8 6v6
    canvas.drawLine(
        Offset(8 * scale, 6 * scale), Offset(8 * scale, 12 * scale), paint);
    // M15 6v6
    canvas.drawLine(
        Offset(15 * scale, 6 * scale), Offset(15 * scale, 12 * scale), paint);

    // Line
    // M2 12h19.6
    canvas.drawLine(
        Offset(2 * scale, 12 * scale), Offset(21.6 * scale, 12 * scale), paint);

    // Body Path
    // M18 18h3s.5-1.7.8-2.8c.1-.4.2-.8.2-1.2 0-.4-.1-.8-.2-1.2l-1.4-5C20.1 6.8 19.1 6 18 6H4a2 2 0 0 0-2 2v10h3
    final bodyPath = Path();
    bodyPath.moveTo(18 * scale, 18 * scale);
    bodyPath.lineTo(21 * scale, 18 * scale);
    // s.5-1.7.8-2.8 -> cubic to relative
    // s x2 y2 x y (reflected control point)
    // Since previous command was L, reflected control point is current point (21, 18).
    // So it's cubicTo(21, 18, 21+0.5, 18-1.7, 21+0.8, 18-2.8) -> (21.5, 16.3, 21.8, 15.2)
    bodyPath.cubicTo(
      21 * scale, 18 * scale, // Control point 1 (reflected)
      21.5 * scale, 16.3 * scale, // Control point 2
      21.8 * scale, 15.2 * scale, // End point
    );

    // c.1-.4.2-.8.2-1.2 -> relative cubic
    // c dx1 dy1 dx2 dy2 dx dy
    // 0.1 -0.4, 0.2 -0.8, 0.2 -1.2
    // From 21.8, 15.2
    // cp1: 21.9, 14.8
    // cp2: 22.0, 14.4
    // end: 22.0, 14.0
    bodyPath.relativeCubicTo(
      0.1 * scale,
      -0.4 * scale,
      0.2 * scale,
      -0.8 * scale,
      0.2 * scale,
      -1.2 * scale,
    );

    // 0-.4-.1-.8-.2-1.2 -> relative cubic? No, SVG path command syntax.
    // 0 -.4 -.1 -.8 -.2 -1.2
    // cp1: 0, -0.4
    // cp2: -0.1, -0.8
    // end: -0.2, -1.2
    // From 22.0, 14.0
    // cp1: 22.0, 13.6
    // cp2: 21.9, 13.2
    // end: 21.8, 12.8
    bodyPath.relativeCubicTo(
      0 * scale,
      -0.4 * scale,
      -0.1 * scale,
      -0.8 * scale,
      -0.2 * scale,
      -1.2 * scale,
    );

    // l-1.4-5 -> relative line
    // -1.4, -5
    // From 21.8, 12.8 -> 20.4, 7.8
    bodyPath.relativeLineTo(-1.4 * scale, -5 * scale);

    // C20.1 6.8 19.1 6 18 6 -> Absolute Cubic
    // cp1: 20.1, 6.8
    // cp2: 19.1, 6
    // end: 18, 6
    bodyPath.cubicTo(
      20.1 * scale,
      6.8 * scale,
      19.1 * scale,
      6 * scale,
      18 * scale,
      6 * scale,
    );

    // H4
    bodyPath.lineTo(4 * scale, 6 * scale);

    // a2 2 0 0 0-2 2
    bodyPath.arcToPoint(
      Offset(2 * scale, 8 * scale),
      radius: Radius.circular(2 * scale),
      clockwise: false,
    );

    // v10
    bodyPath.relativeLineTo(0, 10 * scale);

    // h3
    bodyPath.relativeLineTo(3 * scale, 0);

    canvas.drawPath(bodyPath, paint);

    // Wheel Arches?
    // M9 18h5
    canvas.drawLine(
        Offset(9 * scale, 18 * scale), Offset(14 * scale, 18 * scale), paint);

    canvas.restore(); // End body bounce

    // Wheels (Rotate)
    // circle cx="7" cy="18" r="2"
    drawWheel(canvas, paint, 7, 18, 2, scale, wheelRotation, bounceY);

    // circle cx="16" cy="18" r="2"
    drawWheel(canvas, paint, 16, 18, 2, scale, wheelRotation, bounceY);
  }

  void drawWheel(Canvas canvas, Paint paint, double cx, double cy, double r,
      double scale, double rotation, double bounceY) {
    canvas.save();
    // Move to wheel center, applying bounceY
    canvas.translate(cx * scale, (cy + bounceY) * scale);
    canvas.rotate(rotation);

    // Draw circle
    canvas.drawCircle(Offset.zero, r * scale, paint);

    // Spokes removed as per request

    canvas.restore();
  }

  @override
  bool shouldRepaint(BusPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.bounceY != bounceY ||
        oldDelegate.wheelRotation != wheelRotation ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
