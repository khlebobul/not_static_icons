import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

class AlignHorizontalJustifyCenterIcon extends AnimatedSVGIcon {
  const AlignHorizontalJustifyCenterIcon({
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
  }) => _AlignHorizontalJustifyCenterPainter(
    color: color,
    animationValue: animationValue,
    strokeWidth: strokeWidth,
  );

  @override
  String get animationDescription =>
      'One rectangle grows while other shrinks, then return';
}

class _AlignHorizontalJustifyCenterPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _AlignHorizontalJustifyCenterPainter({
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

    // First rectangle (left) - grows during animation
    final rect1OriginalHeight = 14.0 * scale;
    final rect1MaxHeight = 18.0 * scale; // Grow bigger
    final rect1Height =
        rect1OriginalHeight + (rect1MaxHeight - rect1OriginalHeight) * animT;
    final rect1Top =
        5.0 * scale -
        (rect1Height - rect1OriginalHeight) / 2; // Center vertically

    final rect1Rect = RRect.fromRectAndRadius(
      Rect.fromLTWH(2.0 * scale, rect1Top, 6.0 * scale, rect1Height),
      Radius.circular(2.0 * scale),
    );
    canvas.drawRRect(rect1Rect, paint);

    // Second rectangle (right) - shrinks during animation
    final rect2OriginalHeight = 10.0 * scale;
    final rect2MinHeight = 6.0 * scale; // Shrink smaller
    final rect2Height =
        rect2OriginalHeight - (rect2OriginalHeight - rect2MinHeight) * animT;
    final rect2Top =
        7.0 * scale +
        (rect2OriginalHeight - rect2Height) / 2; // Center vertically

    final rect2Rect = RRect.fromRectAndRadius(
      Rect.fromLTWH(16.0 * scale, rect2Top, 6.0 * scale, rect2Height),
      Radius.circular(2.0 * scale),
    );
    canvas.drawRRect(rect2Rect, paint);

    // Center line - vertical line at x=12
    canvas.drawLine(
      Offset(12.0 * scale, 2.0 * scale),
      Offset(12.0 * scale, 22.0 * scale),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
