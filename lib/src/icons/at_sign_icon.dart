import 'package:flutter/material.dart';
import 'package:not_static_icons/not_static_icons.dart';

class AtSignIcon extends AnimatedSVGIcon {
  const AtSignIcon({
    super.key,
    super.size,
    super.color,
    super.strokeWidth = 2.0,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
  });

  @override
  String get animationDescription =>
      'Initial static display, then fades out and redraws on hover.';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return AtSignPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class AtSignPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  AtSignPainter({
    required this.color,
    required this.animationValue,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final scale = size.width / 24.0;

    // Inner circle: cx="12" cy="12" r="4"
    final innerCircle = Path()
      ..addOval(
        Rect.fromCircle(
          center: Offset(12 * scale, 12 * scale),
          radius: 4 * scale,
        ),
      );

    // Outer path: M16 8v5a3 3 0 0 0 6 0v-1a10 10 0 1 0-4 8
    final outerPath = Path();
    outerPath.moveTo(16 * scale, 8 * scale);
    outerPath.relativeLineTo(0, 5 * scale); // v5

    // a3 3 0 0 0 6 0 - дуга радиусом 3
    outerPath.arcToPoint(
      Offset(22 * scale, 13 * scale), // текущая позиция + 6 по x
      radius: Radius.circular(3 * scale),
      clockwise: false,
    );

    outerPath.relativeLineTo(0, -1 * scale); // v-1

    // a10 10 0 1 0-4 8 - большая дуга радиусом 10
    outerPath.arcToPoint(
      Offset(18 * scale, 20 * scale), // текущая позиция + (-4, 8)
      radius: Radius.circular(10 * scale),
      largeArc: true,
      clockwise: false,
    );

    // --- Animation Logic ---

    // Stage 1: Fade out the initial icon (animation 0.0 -> 0.2)
    final fadeOutOpacity = (1 - (animationValue / 0.2)).clamp(0.0, 1.0);
    if (fadeOutOpacity > 0) {
      final fadePaint = Paint()
        ..color = color.withValues(alpha: fadeOutOpacity)
        ..strokeWidth = strokeWidth
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round;
      canvas.drawPath(innerCircle, fadePaint);
      canvas.drawPath(outerPath, fadePaint);
    }

    // Stage 2: Draw the icon (animation 0.2 -> 1.0)
    if (animationValue > 0.2) {
      // Remap animationValue from (0.2..1.0) to (0.0..1.0) for drawing
      final drawAnimationValue = (animationValue - 0.2) / 0.8;

      final paint = Paint()
        ..color = color
        ..strokeWidth = strokeWidth
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round;

      final innerCircleMetrics = innerCircle.computeMetrics().first;
      final outerPathMetrics = outerPath.computeMetrics().first;
      final totalLength = innerCircleMetrics.length + outerPathMetrics.length;
      final currentLength = drawAnimationValue * totalLength;

      if (currentLength <= innerCircleMetrics.length) {
        // Draw inner circle progressively
        final animatedPath = innerCircleMetrics.extractPath(0, currentLength);
        canvas.drawPath(animatedPath, paint);
      } else {
        // Draw inner circle completely, then outer path progressively
        canvas.drawPath(innerCircle, paint);
        final remainingLength = currentLength - innerCircleMetrics.length;
        if (remainingLength > 0) {
          final animatedPath = outerPathMetrics.extractPath(0, remainingLength);
          canvas.drawPath(animatedPath, paint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(AtSignPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
