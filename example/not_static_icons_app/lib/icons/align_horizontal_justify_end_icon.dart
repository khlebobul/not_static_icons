import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

class AlignHorizontalJustifyEndIcon extends AnimatedSVGIcon {
  const AlignHorizontalJustifyEndIcon({
    super.key,
    super.size = 100.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 600),
    super.strokeWidth = 2.0,
  });

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) => _AlignHorizontalJustifyEndPainter(
    color: color,
    animationValue: animationValue,
    strokeWidth: strokeWidth,
  );

  @override
  String get animationDescription => 'Rectangles move closer to end line';
}

class _AlignHorizontalJustifyEndPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _AlignHorizontalJustifyEndPainter({
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

    // Calculate movement towards the end line (x = 22)
    // First half (0.0 to 0.5): move closer to line
    // Second half (0.5 to 1.0): move back to original position
    final animT = t <= 0.5 ? t * 2.0 : (1.0 - t) * 2.0;

    // First rectangle - subtle movement towards end line
    final rect1OriginalX = 2.0 * scale;
    final rect1MovementRange = 3.0 * scale; // Subtle movement
    final rect1X = rect1OriginalX + rect1MovementRange * animT;

    final rect1Rect = RRect.fromRectAndRadius(
      Rect.fromLTWH(rect1X, 5.0 * scale, 6.0 * scale, 14.0 * scale),
      Radius.circular(2.0 * scale),
    );
    canvas.drawRRect(rect1Rect, paint);

    // Second rectangle - subtle movement towards end line
    final rect2OriginalX = 12.0 * scale;
    final rect2MovementRange = 2.0 * scale; // Subtle movement
    final rect2X = rect2OriginalX + rect2MovementRange * animT;

    final rect2Rect = RRect.fromRectAndRadius(
      Rect.fromLTWH(rect2X, 7.0 * scale, 6.0 * scale, 10.0 * scale),
      Radius.circular(2.0 * scale),
    );
    canvas.drawRRect(rect2Rect, paint);

    // End line - vertical line at x=22
    canvas.drawLine(
      Offset(22.0 * scale, 2.0 * scale),
      Offset(22.0 * scale, 22.0 * scale),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
