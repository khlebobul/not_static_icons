import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

class AlignVerticalJustifyCenterIcon extends AnimatedSVGIcon {
  const AlignVerticalJustifyCenterIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 600),
    super.strokeWidth = 2.0,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
  });

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) => _AlignVerticalJustifyCenterPainter(
    color: color,
    animationValue: animationValue,
    strokeWidth: strokeWidth,
  );

  @override
  String get animationDescription =>
      'One rectangle grows while other shrinks, then return';
}

class _AlignVerticalJustifyCenterPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _AlignVerticalJustifyCenterPainter({
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
    // First half (0.0 to 0.5): change sizes
    // Second half (0.5 to 1.0): return to original sizes
    final animT = t <= 0.5 ? t * 2.0 : (1.0 - t) * 2.0;

    // First rectangle (bottom) - grows during animation
    final rect1OriginalWidth = 14.0 * scale;
    final rect1MaxWidth = 18.0 * scale; // Grow bigger
    final rect1Width =
        rect1OriginalWidth + (rect1MaxWidth - rect1OriginalWidth) * animT;
    final rect1Left =
        5.0 * scale -
        (rect1Width - rect1OriginalWidth) / 2; // Center horizontally

    final rect1Rect = RRect.fromRectAndRadius(
      Rect.fromLTWH(rect1Left, 16.0 * scale, rect1Width, 6.0 * scale),
      Radius.circular(2.0 * scale),
    );
    canvas.drawRRect(rect1Rect, paint);

    // Second rectangle (top) - shrinks during animation
    final rect2OriginalWidth = 10.0 * scale;
    final rect2MinWidth = 6.0 * scale; // Shrink smaller
    final rect2Width =
        rect2OriginalWidth - (rect2OriginalWidth - rect2MinWidth) * animT;
    final rect2Left =
        7.0 * scale +
        (rect2OriginalWidth - rect2Width) / 2; // Center horizontally

    final rect2Rect = RRect.fromRectAndRadius(
      Rect.fromLTWH(rect2Left, 2.0 * scale, rect2Width, 6.0 * scale),
      Radius.circular(2.0 * scale),
    );
    canvas.drawRRect(rect2Rect, paint);

    // Center line - horizontal line at y=12
    canvas.drawLine(
      Offset(2.0 * scale, 12.0 * scale),
      Offset(22.0 * scale, 12.0 * scale),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
