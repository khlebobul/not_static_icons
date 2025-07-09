import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';
import 'dart:math';

/// Animated Atom Icon - Rings rotate with different speeds and return
class AtomIcon extends AnimatedSVGIcon {
  const AtomIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 1200),
    super.strokeWidth = 2.0,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
  });

  @override
  String get animationDescription =>
      "The rings of the atom rotate with different speeds and elastic easing, then return to their original position.";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return AtomPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

/// Painter for Atom icon
class AtomPainter extends CustomPainter {
  final Color color;
  final double animationValue; // 0.0 to 1.0
  final double strokeWidth;

  AtomPainter({
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
    final center = Offset(size.width / 2, size.height / 2);

    // Draw nucleus (static)
    canvas.drawCircle(center, 1.0 * scale, paint..style = PaintingStyle.fill);

    // Restore paint style for rings
    paint.style = PaintingStyle.stroke;

    // More complex animation with smooth easing
    final smoothEase = _smoothEaseInOut(animationValue);

    // Different rotation speeds for each ring - multiple full rotations
    final ring1Rotation = smoothEase * pi * 4; // 2 full rotations (720 degrees)
    final ring2Rotation = smoothEase *
        pi *
        6; // 3 full rotations (1080 degrees, opposite direction)

    // Draw first ring with rotation
    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(ring1Rotation);
    canvas.translate(-center.dx, -center.dy);
    _drawFirstRing(canvas, paint, scale);
    canvas.restore();

    // Draw second ring with different rotation
    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(-ring2Rotation); // Opposite direction
    canvas.translate(-center.dx, -center.dy);
    _drawSecondRing(canvas, paint, scale);
    canvas.restore();
  }

    // Smooth ease in-out function for fluid animation
  double _smoothEaseInOut(double t) {
    // Cubic ease-in-out for smooth acceleration and deceleration
    if (t < 0.5) {
      return 4 * t * t * t;
    } else {
      return 1 - pow(-2 * t + 2, 3) / 2;
    }
  }

  void _drawFirstRing(Canvas canvas, Paint paint, double scale) {
    // First elliptical ring path (from SVG)
    final path = Path();

    // Convert SVG path to Flutter path
    // M20.2 20.2c2.04-2.03.02-7.36-4.5-11.9-4.54-4.52-9.87-6.54-11.9-4.5-2.04 2.03-.02 7.36 4.5 11.9 4.54 4.52 9.87 6.54 11.9 4.5Z
    path.moveTo(20.2 * scale, 20.2 * scale);
    path.relativeCubicTo(2.04 * scale, -2.03 * scale, 0.02 * scale,
        -7.36 * scale, -4.5 * scale, -11.9 * scale);
    path.relativeCubicTo(-4.54 * scale, -4.52 * scale, -9.87 * scale,
        -6.54 * scale, -11.9 * scale, -4.5 * scale);
    path.relativeCubicTo(-2.04 * scale, 2.03 * scale, -0.02 * scale,
        7.36 * scale, 4.5 * scale, 11.9 * scale);
    path.relativeCubicTo(4.54 * scale, 4.52 * scale, 9.87 * scale, 6.54 * scale,
        11.9 * scale, 4.5 * scale);
    path.close();

    canvas.drawPath(path, paint);
  }

  void _drawSecondRing(Canvas canvas, Paint paint, double scale) {
    // Second elliptical ring path (from SVG)
    final path = Path();

    // Convert SVG path to Flutter path
    // M15.7 15.7c4.52-4.54 6.54-9.87 4.5-11.9-2.03-2.04-7.36-.02-11.9 4.5-4.52 4.54-6.54 9.87-4.5 11.9 2.03 2.04 7.36.02 11.9-4.5Z
    path.moveTo(15.7 * scale, 15.7 * scale);
    path.relativeCubicTo(4.52 * scale, -4.54 * scale, 6.54 * scale,
        -9.87 * scale, 4.5 * scale, -11.9 * scale);
    path.relativeCubicTo(-2.03 * scale, -2.04 * scale, -7.36 * scale,
        -0.02 * scale, -11.9 * scale, 4.5 * scale);
    path.relativeCubicTo(-4.52 * scale, 4.54 * scale, -6.54 * scale,
        9.87 * scale, -4.5 * scale, 11.9 * scale);
    path.relativeCubicTo(2.03 * scale, 2.04 * scale, 7.36 * scale, 0.02 * scale,
        11.9 * scale, -4.5 * scale);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(AtomPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
