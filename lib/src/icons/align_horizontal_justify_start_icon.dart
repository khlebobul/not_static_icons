import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

class AlignHorizontalJustifyStartIcon extends AnimatedSVGIcon {
  const AlignHorizontalJustifyStartIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 600),
    super.strokeWidth = 2.0,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
  });

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) =>
      _AlignHorizontalJustifyStartPainter(
        color: color,
        animationValue: animationValue,
        strokeWidth: strokeWidth,
      );

  @override
  String get animationDescription => 'Rectangles move closer to start line';
}

class _AlignHorizontalJustifyStartPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _AlignHorizontalJustifyStartPainter({
    required this.color,
    required this.animationValue,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final scale = size.width / 24.0;

    // Animation interpolation
    final t = animationValue;

    // Calculate movement towards the start line (x = 2)
    // First half (0.0 to 0.5): move closer to line
    // Second half (0.5 to 1.0): move back to original position
    final animT = t <= 0.5 ? t * 2.0 : (1.0 - t) * 2.0;

    // First rectangle - subtle movement towards start line
    final rect1OriginalX = 6.0 * scale;
    final rect1MovementRange = -2.0 * scale; // Subtle movement towards line
    final rect1X = rect1OriginalX + rect1MovementRange * animT;

    final rect1Rect = RRect.fromRectAndRadius(
      Rect.fromLTWH(rect1X, 5.0 * scale, 6.0 * scale, 14.0 * scale),
      Radius.circular(2.0 * scale),
    );
    canvas.drawRRect(rect1Rect, paint);

    // Second rectangle - subtle movement towards start line
    final rect2OriginalX = 16.0 * scale;
    final rect2MovementRange = -3.0 * scale; // Subtle movement towards line
    final rect2X = rect2OriginalX + rect2MovementRange * animT;

    final rect2Rect = RRect.fromRectAndRadius(
      Rect.fromLTWH(rect2X, 7.0 * scale, 6.0 * scale, 10.0 * scale),
      Radius.circular(2.0 * scale),
    );
    canvas.drawRRect(rect2Rect, paint);

    // Start line - vertical line at x=2
    canvas.drawLine(
      Offset(2.0 * scale, 2.0 * scale),
      Offset(2.0 * scale, 22.0 * scale),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
