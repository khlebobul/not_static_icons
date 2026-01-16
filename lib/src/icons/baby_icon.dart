import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';
import 'dart:math';

/// Animated Baby Icon - Hair curl moves up and down
class BabyIcon extends AnimatedSVGIcon {
  const BabyIcon({
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
  String get animationDescription =>
      "Baby icon with a hair curl that gently bounces up and down.";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return BabyPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

/// Painter for Baby icon
class BabyPainter extends CustomPainter {
  final Color color;
  final double animationValue; // 0.0 to 1.0
  final double strokeWidth;

  BabyPainter({
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

    // Calculate the vertical offset for the hair curl
    final curlOffset = _calculateCurlOffset(animationValue);

    // Draw the static parts of the baby icon
    _drawStaticParts(canvas, paint, scale);

    // Draw the animated hair curl
    _drawAnimatedHairCurl(canvas, paint, scale, curlOffset);
  }

  // Calculate the vertical offset for the hair curl
  double _calculateCurlOffset(double t) {
    // Use a sine wave to create smooth up and down motion
    // Scale to -1.0 to 1.0 range, then multiply by max displacement
    const maxDisplacement = 0.3; // Reduced vertical displacement in SVG units
    return sin(t * 2 * pi) * maxDisplacement;
  }

  void _drawStaticParts(Canvas canvas, Paint paint, double scale) {
    // Draw the smile: M10 16c.5.3 1.2.5 2 .5s1.5-.2 2-.5
    // Make the smile bigger and more pronounced
    final smilePath = Path();
    smilePath.moveTo(9.8 * scale, 16 * scale);
    smilePath.relativeCubicTo(0.6 * scale, 0.5 * scale, 1.4 * scale,
        0.7 * scale, 2.2 * scale, 0.7 * scale);
    smilePath.relativeCubicTo(0 * scale, 0 * scale, 1.6 * scale, -0.2 * scale,
        2.2 * scale, -0.7 * scale);
    canvas.drawPath(smilePath, paint);

    // Draw right eye: M15 12h.01
    canvas.drawLine(
      Offset(15 * scale, 12 * scale),
      Offset(15.01 * scale, 12 * scale),
      paint,
    );

    // Draw the main face outline:
    // M19.38 6.813A9 9 0 0 1 20.8 10.2a2 2 0 0 1 0 3.6 9 9 0 0 1-17.6 0 2 2 0 0 1 0-3.6A9 9 0 0 1 12 3
    final facePath = Path();
    facePath.moveTo(19.38 * scale, 6.813 * scale);

    // A9 9 0 0 1 20.8 10.2
    facePath.arcToPoint(
      Offset(20.8 * scale, 10.2 * scale),
      radius: Radius.circular(9 * scale),
      rotation: 0,
      largeArc: false,
      clockwise: true,
    );

    // a2 2 0 0 1 0 3.6
    facePath.arcToPoint(
      Offset(20.8 * scale, 13.8 * scale),
      radius: Radius.circular(2 * scale),
      rotation: 0,
      largeArc: false,
      clockwise: true,
    );

    // A9 9 0 0 1-17.6 0
    facePath.arcToPoint(
      Offset(3.2 * scale, 13.8 * scale),
      radius: Radius.circular(9 * scale),
      rotation: 0,
      largeArc: false,
      clockwise: true,
    );

    // a2 2 0 0 1 0-3.6
    facePath.arcToPoint(
      Offset(3.2 * scale, 10.2 * scale),
      radius: Radius.circular(2 * scale),
      rotation: 0,
      largeArc: false,
      clockwise: true,
    );

    // A9 9 0 0 1 12 3
    facePath.arcToPoint(
      Offset(12 * scale, 3 * scale),
      radius: Radius.circular(9 * scale),
      rotation: 0,
      largeArc: false,
      clockwise: true,
    );

    canvas.drawPath(facePath, paint);

    // Draw left eye: M9 12h.01
    canvas.drawLine(
      Offset(9 * scale, 12 * scale),
      Offset(9.01 * scale, 12 * scale),
      paint,
    );
  }

  void _drawAnimatedHairCurl(
      Canvas canvas, Paint paint, double scale, double offset) {
    // Draw the animated hair curl with vertical offset:
    // Original: c2 0 3.5 1.1 3.5 2.5s-.9 2.5-2 2.5c-.8 0-1.5-.4-1.5-1
    final curlPath = Path();

    // Start from the top of the head
    curlPath.moveTo(12 * scale, 3 * scale);

    // Apply the vertical offset to the control points and end point
    curlPath.relativeCubicTo(
        2 * scale,
        0 * scale,
        3.5 * scale,
        (1.1 + offset * 0.3) * scale, // Adjust control point
        3.5 * scale,
        (2.5 + offset) * scale // Adjust end point
        );

    curlPath.relativeCubicTo(
        0 * scale,
        0 * scale,
        -0.9 * scale,
        (2.5 + offset * 0.5) * scale, // Adjust control point
        -2 * scale,
        (2.5 + offset * 0.2) * scale // Adjust end point
        );

    curlPath.relativeCubicTo(-0.8 * scale, 0 * scale, -1.5 * scale,
        -0.4 * scale, -1.5 * scale, -1 * scale);

    canvas.drawPath(curlPath, paint);
  }

  @override
  bool shouldRepaint(BabyPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
