import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../core/animated_svg_icon_base.dart';

/// Animated Blend Icon - circles blending animation
class BlendIcon extends AnimatedSVGIcon {
  const BlendIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 1000),
    super.strokeWidth = 2.0,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
    super.resetToStartOnComplete = true,
  });

  @override
  String get animationDescription => 'Blend: clockwise rotation animation';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) =>
      _BlendPainter(
        color: color,
        animationValue: animationValue,
        strokeWidth: strokeWidth,
      );
}

class _BlendPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _BlendPainter({
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

    // Draw only animated icon
    _drawBlendingEffect(canvas, paint, scale);
  }

  void _drawBlendingEffect(Canvas canvas, Paint paint, double scale) {
    final progress = animationValue;

    // Calculate rotation angle (full rotation clockwise)
    final rotationAngle = progress * 2 * math.pi;

    // Center of rotation (center of the icon)
    final centerX = 12 * scale;
    final centerY = 12 * scale;

    // Apply rotation transformation
    canvas.save();
    canvas.translate(centerX, centerY);
    canvas.rotate(rotationAngle);
    canvas.translate(-centerX, -centerY);

    // Draw the circles with rotation
    canvas.drawCircle(Offset(9 * scale, 9 * scale), 7 * scale, paint);
    canvas.drawCircle(Offset(15 * scale, 15 * scale), 7 * scale, paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(_BlendPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
