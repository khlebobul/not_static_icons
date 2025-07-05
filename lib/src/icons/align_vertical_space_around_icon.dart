import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

class AlignVerticalSpaceAroundIcon extends AnimatedSVGIcon {
  const AlignVerticalSpaceAroundIcon({
    super.key,
    super.size = 40.0,
    super.color = Colors.black,
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
      _AlignVerticalSpaceAroundPainter(
        color: color,
        animationValue: animationValue,
        strokeWidth: strokeWidth,
      );

  @override
  String get animationDescription =>
      'Rectangle shrinks and returns to original size';
}

class _AlignVerticalSpaceAroundPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _AlignVerticalSpaceAroundPainter({
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

    // Calculate scaling factors for animation
    // First half (0.0 to 0.5): shrink rectangle
    // Second half (0.5 to 1.0): return to original size
    final animT = t <= 0.5 ? t * 2.0 : (1.0 - t) * 2.0;

    // Central rectangle - shrinks during animation
    final originalWidth = 10.0 * scale;
    final originalHeight = 6.0 * scale;
    final minWidth = 6.0 * scale; // Shrink to smaller size
    final minHeight = 4.0 * scale; // Shrink to smaller size

    final currentWidth = originalWidth - (originalWidth - minWidth) * animT;
    final currentHeight = originalHeight - (originalHeight - minHeight) * animT;

    // Center the shrinking rectangle
    final rectLeft = 7.0 * scale + (originalWidth - currentWidth) / 2;
    final rectTop = 9.0 * scale + (originalHeight - currentHeight) / 2;

    final rect = RRect.fromRectAndRadius(
      Rect.fromLTWH(rectLeft, rectTop, currentWidth, currentHeight),
      Radius.circular(2.0 * scale),
    );
    canvas.drawRRect(rect, paint);

    // Top horizontal line
    canvas.drawLine(
      Offset(2.0 * scale, 4.0 * scale),
      Offset(22.0 * scale, 4.0 * scale),
      paint,
    );

    // Bottom horizontal line
    canvas.drawLine(
      Offset(2.0 * scale, 20.0 * scale),
      Offset(22.0 * scale, 20.0 * scale),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate is _AlignVerticalSpaceAroundPainter &&
        (oldDelegate.color != color ||
            oldDelegate.animationValue != animationValue ||
            oldDelegate.strokeWidth != strokeWidth);
  }
}
