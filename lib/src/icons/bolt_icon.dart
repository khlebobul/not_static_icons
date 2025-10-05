import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';
import 'dart:math' as math;

/// Animated Bolt Icon - electric pulse animation
class BoltIcon extends AnimatedSVGIcon {
  const BoltIcon({
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
  String get animationDescription => 'Bolt: rotation animation';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) =>
      _BoltPainter(
        color: color,
        animationValue: animationValue,
        strokeWidth: strokeWidth,
      );
}

class _BoltPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _BoltPainter({
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

    // Draw complete bolt icon with rotation
    _drawRotatingIcon(canvas, paint, scale);
  }

  void _drawRotatingIcon(Canvas canvas, Paint paint, double scale) {
    final progress = animationValue;

    // Calculate rotation angle (one full rotation)
    final rotationAngle = progress * 2 * math.pi;

    // Save canvas state
    canvas.save();

    // Move to center for rotation
    canvas.translate(12 * scale, 12 * scale);

    // Apply rotation
    canvas.rotate(rotationAngle);

    // Move back to draw from origin
    canvas.translate(-12 * scale, -12 * scale);

    // Draw the complete icon
    _drawCompleteIcon(canvas, paint, scale);

    // Restore canvas state
    canvas.restore();
  }

  void _drawCompleteIcon(Canvas canvas, Paint paint, double scale) {
    // Draw outer hexagon: M21 16V8a2 2 0 0 0-1-1.73l-7-4a2 2 0 0 0-2 0l-7 4A2 2 0 0 0 3 8v8a2 2 0 0 0 1 1.73l7 4a2 2 0 0 0 2 0l7-4A2 2 0 0 0 21 16z
    final hexagonPath = Path();

    // Start at M21 16
    hexagonPath.moveTo(21 * scale, 16 * scale);

    // Vertical line to V8
    hexagonPath.lineTo(21 * scale, 8 * scale);

    // Arc a2 2 0 0 0-1-1.73 (top right corner)
    hexagonPath.arcToPoint(
      Offset(20 * scale, 6.27 * scale),
      radius: Radius.circular(2 * scale),
      clockwise: false,
    );

    // Line l-7-4 (to top point)
    hexagonPath.lineTo(13 * scale, 2.27 * scale);

    // Arc a2 2 0 0 0-2 0 (top curve)
    hexagonPath.arcToPoint(
      Offset(11 * scale, 2.27 * scale),
      radius: Radius.circular(2 * scale),
      clockwise: false,
    );

    // Line l-7 4 (to top left)
    hexagonPath.lineTo(4 * scale, 6.27 * scale);

    // Arc A2 2 0 0 0 3 8 (top left corner)
    hexagonPath.arcToPoint(
      Offset(3 * scale, 8 * scale),
      radius: Radius.circular(2 * scale),
      clockwise: false,
    );

    // Vertical line v8
    hexagonPath.lineTo(3 * scale, 16 * scale);

    // Arc a2 2 0 0 0 1 1.73 (bottom left corner)
    hexagonPath.arcToPoint(
      Offset(4 * scale, 17.73 * scale),
      radius: Radius.circular(2 * scale),
      clockwise: false,
    );

    // Line l7 4 (to bottom point)
    hexagonPath.lineTo(11 * scale, 21.73 * scale);

    // Arc a2 2 0 0 0 2 0 (bottom curve)
    hexagonPath.arcToPoint(
      Offset(13 * scale, 21.73 * scale),
      radius: Radius.circular(2 * scale),
      clockwise: false,
    );

    // Line l7-4 (to bottom right)
    hexagonPath.lineTo(20 * scale, 17.73 * scale);

    // Arc A2 2 0 0 0 21 16 (bottom right corner)
    hexagonPath.arcToPoint(
      Offset(21 * scale, 16 * scale),
      radius: Radius.circular(2 * scale),
      clockwise: false,
    );

    canvas.drawPath(hexagonPath, paint);

    // Draw inner circle: circle cx="12" cy="12" r="4"
    canvas.drawCircle(
      Offset(12 * scale, 12 * scale),
      4 * scale,
      paint,
    );
  }

  @override
  bool shouldRepaint(_BoltPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
