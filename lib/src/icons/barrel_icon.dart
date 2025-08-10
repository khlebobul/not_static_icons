import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../core/animated_svg_icon_base.dart';

/// Animated Barrel Icon - static original; on hover/press, vertically compresses then returns to original
class BarrelIcon extends AnimatedSVGIcon {
  const BarrelIcon({
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
  });

  @override
  String get animationDescription =>
      'Barrel: vertical squash and return to original shape';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return _BarrelPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class _BarrelPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _BarrelPainter({
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

    // Compute vertical squash factor: 1 -> 0.8 -> 1 over t in [0,1]
    final double t = animationValue.clamp(0.0, 1.0);
    final double squash = 1.0 - 0.2 * (t == 0.0 ? 0.0 : (Maths.sinPi(t)));

    // Apply vertical scaling around center (12,12)
    final center = Offset(12 * scale, 12 * scale);
    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.scale(1.0, squash);
    canvas.translate(-center.dx, -center.dy);

    _drawBarrel(canvas, scale, paint);

    canvas.restore();
  }

  void _drawBarrel(Canvas canvas, double scale, Paint paint) {
    // Outer body - exact path from SVG using arc endpoints
    final outer = Path()
      ..moveTo(17 * scale, 3 * scale)
      // a2 2 0 0 1 1.68 .92 (relative)
      ..arcToPoint(
        Offset(18.68 * scale, 3.92 * scale),
        radius: Radius.circular(2 * scale),
        clockwise: true,
      )
      // a15.25 15.25 0 0 1 0 16.16 (relative)
      ..arcToPoint(
        Offset(18.68 * scale, 20.08 * scale),
        radius: Radius.circular(15.25 * scale),
        clockwise: true,
      )
      // A2 2 0 0 1 17 21 (absolute)
      ..arcToPoint(
        Offset(17 * scale, 21 * scale),
        radius: Radius.circular(2 * scale),
        clockwise: true,
      )
      // H7
      ..lineTo(7 * scale, 21 * scale)
      // a2 2 0 0 1 -1.68 -.92 (relative)
      ..arcToPoint(
        Offset(5.32 * scale, 20.08 * scale),
        radius: Radius.circular(2 * scale),
        clockwise: true,
      )
      // a15.25 15.25 0 0 1 0 -16.16 (relative)
      ..arcToPoint(
        Offset(5.32 * scale, 3.92 * scale),
        radius: Radius.circular(15.25 * scale),
        clockwise: true,
      )
      // A2 2 0 0 1 7 3 (absolute)
      ..arcToPoint(
        Offset(7 * scale, 3 * scale),
        radius: Radius.circular(2 * scale),
        clockwise: true,
      )
      ..close();
    canvas.drawPath(outer, paint);

    // Inner vertical arcs (M10 3 a41 41 0 0 0 0 18) and (M14 3 a41 41 0 0 1 0 18)
    final leftArc = Path()
      ..moveTo(10 * scale, 3 * scale)
      ..arcToPoint(
        Offset(10 * scale, 21 * scale),
        radius: Radius.circular(41 * scale),
        clockwise: false,
      );
    canvas.drawPath(leftArc, paint);

    final rightArc = Path()
      ..moveTo(14 * scale, 3 * scale)
      ..arcToPoint(
        Offset(14 * scale, 21 * scale),
        radius: Radius.circular(41 * scale),
        clockwise: true,
      );
    canvas.drawPath(rightArc, paint);

    // Horizontal bands (M3.84 7 h16.32) and (M3.84 17 h16.32)
    canvas.drawLine(Offset(3.84 * scale, 7 * scale),
        Offset(20.16 * scale, 7 * scale), paint);
    canvas.drawLine(Offset(3.84 * scale, 17 * scale),
        Offset(20.16 * scale, 17 * scale), paint);
  }

  @override
  bool shouldRepaint(_BarrelPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}

// Small math helper for sin(pi * t)
class Maths {
  static double sinPi(double t) {
    return math.sin(3.141592653589793 * t);
  }
}
