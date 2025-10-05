import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';
import 'dart:math' as math;

/// Animated Bone Icon - wiggle animation
class BoneIcon extends AnimatedSVGIcon {
  const BoneIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 1500),
    super.strokeWidth = 2.0,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
    super.resetToStartOnComplete = true,
  });

  @override
  String get animationDescription => 'Bone: wiggle animation';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) =>
      _BonePainter(
        color: color,
        animationValue: animationValue,
        strokeWidth: strokeWidth,
      );
}

class _BonePainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _BonePainter({
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

    // Draw bone with wiggle animation
    _drawWigglingBone(canvas, paint, scale);
  }

  void _drawWigglingBone(Canvas canvas, Paint paint, double scale) {
    final progress = animationValue;

    // Create wiggle effect - alternating left/right rotation
    final wiggleAngle = math.sin(progress * math.pi * 6) * 0.15; // 6 wiggles

    // Save canvas state
    canvas.save();

    // Move to center for rotation
    canvas.translate(12 * scale, 12 * scale);

    // Apply wiggle rotation
    canvas.rotate(wiggleAngle);

    // Move back to draw from origin
    canvas.translate(-12 * scale, -12 * scale);

    // Draw the complete bone
    _drawCompleteIcon(canvas, paint, scale);

    // Restore canvas state
    canvas.restore();
  }

  void _drawCompleteIcon(Canvas canvas, Paint paint, double scale) {
    // Draw bone path: M17 10c.7-.7 1.69 0 2.5 0a2.5 2.5 0 1 0 0-5 .5.5 0 0 1-.5-.5 2.5 2.5 0 1 0-5 0c0 .81.7 1.8 0 2.5l-7 7c-.7.7-1.69 0-2.5 0a2.5 2.5 0 0 0 0 5c.28 0 .5.22.5.5a2.5 2.5 0 1 0 5 0c0-.81-.7-1.8 0-2.5Z
    final bonePath = Path();

    // Start at M17 10
    bonePath.moveTo(17 * scale, 10 * scale);

    // Curve c.7-.7 1.69 0 2.5 0 (relative cubic)
    bonePath.relativeCubicTo(
        0.7 * scale, -0.7 * scale, 1.69 * scale, 0, 2.5 * scale, 0);

    // Arc a2.5 2.5 0 1 0 0-5 (top right circle)
    bonePath.arcToPoint(
      Offset(19.5 * scale, 5 * scale),
      radius: Radius.circular(2.5 * scale),
      clockwise: false,
      largeArc: true,
    );

    // Arc .5.5 0 0 1-.5-.5 (small connector)
    bonePath.arcToPoint(
      Offset(19 * scale, 4.5 * scale),
      radius: Radius.circular(0.5 * scale),
      clockwise: true,
    );

    // Arc a2.5 2.5 0 1 0-5 0 (top left circle)
    bonePath.arcToPoint(
      Offset(14 * scale, 4.5 * scale),
      radius: Radius.circular(2.5 * scale),
      clockwise: false,
      largeArc: true,
    );

    // Curve c0 .81.7 1.8 0 2.5 (relative cubic)
    bonePath.relativeCubicTo(
        0, 0.81 * scale, 0.7 * scale, 1.8 * scale, 0, 2.5 * scale);

    // Line l-7 7 (diagonal line to bottom)
    bonePath.relativeLineTo(-7 * scale, 7 * scale);

    // Curve c-.7.7-1.69 0-2.5 0 (relative cubic)
    bonePath.relativeCubicTo(
        -0.7 * scale, 0.7 * scale, -1.69 * scale, 0, -2.5 * scale, 0);

    // Arc a2.5 2.5 0 0 0 0 5 (bottom left circle)
    bonePath.arcToPoint(
      Offset(4.5 * scale, 19 * scale),
      radius: Radius.circular(2.5 * scale),
      clockwise: false,
    );

    // Curve c.28 0 .5.22.5.5 (relative cubic)
    bonePath.relativeCubicTo(
        0.28 * scale, 0, 0.5 * scale, 0.22 * scale, 0.5 * scale, 0.5 * scale);

    // Arc a2.5 2.5 0 1 0 5 0 (bottom right circle)
    bonePath.arcToPoint(
      Offset(10 * scale, 19.5 * scale),
      radius: Radius.circular(2.5 * scale),
      clockwise: false,
      largeArc: true,
    );

    // Curve c0-.81-.7-1.8 0-2.5 (relative cubic)
    bonePath.relativeCubicTo(
        0, -0.81 * scale, -0.7 * scale, -1.8 * scale, 0, -2.5 * scale);

    // Close the path back to start
    bonePath.close();

    canvas.drawPath(bonePath, paint);
  }

  @override
  bool shouldRepaint(_BonePainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
