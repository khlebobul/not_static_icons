import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../core/animated_svg_icon_base.dart';

/// Animated Bubbles Icon - Bubbles float up and return
class BubblesIcon extends AnimatedSVGIcon {
  const BubblesIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration =
        const Duration(milliseconds: 1000), // Slower for bubbles
    super.strokeWidth = 2.0,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
    super.onTap,
    super.interactive,
    super.controller,
  });

  @override
  String get animationDescription => "Bubbles float up and return";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return BubblesPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class BubblesPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  BubblesPainter({
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

    // Use sine wave for up and down motion: 0 -> 1 -> 0
    final moveValue = math.sin(animationValue * math.pi);

    // Helper to draw bubble with offset
    void drawBubble(
        double cx, double cy, double r, double offsetFactor, double phase) {
      // Move up: y decreases
      double yOffset = -moveValue * 4.0 * offsetFactor;

      // Scale effect: grow slightly as they go up
      double scaleEffect = 1.0 + moveValue * 0.1 * offsetFactor;

      canvas.save();
      canvas.translate(cx * scale, (cy + yOffset) * scale);
      canvas.scale(scaleEffect);
      canvas.translate(-cx * scale, -cy * scale);

      canvas.drawCircle(Offset(cx * scale, cy * scale), r * scale, paint);

      canvas.restore();
    }

    // Big Bubble
    // circle cx="7.5" cy="16.5" r="5.5"
    drawBubble(7.5, 16.5, 5.5, 1.0, 0);

    // Reflection on big bubble
    // M7.2 14.8a2 2 0 0 1 2 2
    // This should move with the big bubble
    double bigBubbleYOffset = -moveValue * 4.0 * 1.0;
    double bigBubbleScale = 1.0 + moveValue * 0.1;

    canvas.save();
    canvas.translate(7.5 * scale, (16.5 + bigBubbleYOffset) * scale);
    canvas.scale(bigBubbleScale);
    canvas.translate(-7.5 * scale, -16.5 * scale);

    final reflectionPath = Path();
    reflectionPath.moveTo(7.2 * scale, 14.8 * scale);
    reflectionPath.arcToPoint(
      Offset(9.2 * scale, 16.8 * scale),
      radius: Radius.circular(2 * scale),
      clockwise: true,
    );
    canvas.drawPath(reflectionPath, paint);
    canvas.restore();

    // Medium Bubble
    // circle cx="18.5" cy="8.5" r="3.5"
    drawBubble(18.5, 8.5, 3.5, 1.5, 0.5);

    // Small Bubble
    // circle cx="7.5" cy="4.5" r="2.5"
    drawBubble(7.5, 4.5, 2.5, 0.8, 0.2);
  }

  @override
  bool shouldRepaint(BubblesPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
