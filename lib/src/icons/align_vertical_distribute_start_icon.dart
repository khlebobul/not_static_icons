import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

class AlignVerticalDistributeStartIcon extends AnimatedSVGIcon {
  const AlignVerticalDistributeStartIcon({
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
      _AlignVerticalDistributeStartPainter(
        color: color,
        animationValue: animationValue,
        strokeWidth: strokeWidth,
      );

  @override
  String get animationDescription =>
      'Rectangles change sizes with vertical start distribution';
}

class _AlignVerticalDistributeStartPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _AlignVerticalDistributeStartPainter({
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
    // First half (0.0 to 0.5): original to modified
    // Second half (0.5 to 1.0): modified back to original
    final animT = t <= 0.5 ? t * 2.0 : (1.0 - t) * 2.0;

    // First rectangle (top) - gets smaller during animation
    final rect1OriginalWidth = 10.0 * scale;
    final rect1MinWidth = 6.0 * scale; // Smaller width
    final rect1Width =
        rect1OriginalWidth - (rect1OriginalWidth - rect1MinWidth) * animT;
    final rect1Left = 7.0 * scale +
        (rect1OriginalWidth - rect1Width) / 2; // Center horizontally

    // First rectangle with rounded bottom corners only (top edge is straight for start alignment)
    final rect1Path = Path()
      ..addRRect(
        RRect.fromRectAndCorners(
          Rect.fromLTWH(rect1Left, 4.0 * scale, rect1Width, 6.0 * scale),
          topLeft: Radius.zero,
          topRight: Radius.zero,
          bottomLeft: Radius.circular(2.0 * scale),
          bottomRight: Radius.circular(2.0 * scale),
        ),
      );
    canvas.drawPath(rect1Path, paint);

    // Second rectangle (bottom) - gets bigger during animation
    final rect2OriginalWidth = 14.0 * scale;
    final rect2MaxWidth = 18.0 * scale; // Bigger width
    final rect2Width =
        rect2OriginalWidth + (rect2MaxWidth - rect2OriginalWidth) * animT;
    final rect2Left = 5.0 * scale -
        (rect2Width - rect2OriginalWidth) / 2; // Center horizontally

    // Second rectangle with rounded bottom corners only (top edge is straight for start alignment)
    final rect2Path = Path()
      ..addRRect(
        RRect.fromRectAndCorners(
          Rect.fromLTWH(rect2Left, 14.0 * scale, rect2Width, 6.0 * scale),
          topLeft: Radius.zero,
          topRight: Radius.zero,
          bottomLeft: Radius.circular(2.0 * scale),
          bottomRight: Radius.circular(2.0 * scale),
        ),
      );
    canvas.drawPath(rect2Path, paint);

    // Guide lines - animate with rectangles (start distribution - top edges)
    // Top rectangle guide line at y=4 (top edge)
    canvas.drawLine(
      Offset(2.0 * scale, 4.0 * scale),
      Offset(22.0 * scale, 4.0 * scale),
      paint,
    );

    // Bottom rectangle guide line at y=14 (top edge)
    canvas.drawLine(
      Offset(2.0 * scale, 14.0 * scale),
      Offset(22.0 * scale, 14.0 * scale),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
