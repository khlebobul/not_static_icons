import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

class AlignHorizontalDistributeEndIcon extends AnimatedSVGIcon {
  const AlignHorizontalDistributeEndIcon({
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
      _AlignHorizontalDistributeEndPainter(
        color: color,
        animationValue: animationValue,
        strokeWidth: strokeWidth,
      );

  @override
  String get animationDescription =>
      'Rectangles change sizes with end distribution';
}

class _AlignHorizontalDistributeEndPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _AlignHorizontalDistributeEndPainter({
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

    // First rectangle - gets smaller during animation
    final rect1OriginalHeight = 14.0 * scale;
    final rect1MinHeight = 8.0 * scale; // Smaller height
    final rect1Height =
        rect1OriginalHeight - (rect1OriginalHeight - rect1MinHeight) * animT;
    final rect1Top = 5.0 * scale +
        (rect1OriginalHeight - rect1Height) / 2; // Center vertically

    // First rectangle with rounded left corners only (right edge is straight for end alignment)
    final rect1Path = Path()
      ..addRRect(
        RRect.fromRectAndCorners(
          Rect.fromLTWH(4.0 * scale, rect1Top, 6.0 * scale, rect1Height),
          topLeft: Radius.circular(2.0 * scale),
          bottomLeft: Radius.circular(2.0 * scale),
          topRight: Radius.zero,
          bottomRight: Radius.zero,
        ),
      );
    canvas.drawPath(rect1Path, paint);

    // Second rectangle - gets bigger during animation
    final rect2OriginalHeight = 10.0 * scale;
    final rect2MaxHeight = 16.0 * scale; // Bigger height
    final rect2Height =
        rect2OriginalHeight + (rect2MaxHeight - rect2OriginalHeight) * animT;
    final rect2Top = 7.0 * scale -
        (rect2Height - rect2OriginalHeight) / 2; // Center vertically

    // Second rectangle with rounded left corners only (right edge is straight for end alignment)
    final rect2Path = Path()
      ..addRRect(
        RRect.fromRectAndCorners(
          Rect.fromLTWH(14.0 * scale, rect2Top, 6.0 * scale, rect2Height),
          topLeft: Radius.circular(2.0 * scale),
          bottomLeft: Radius.circular(2.0 * scale),
          topRight: Radius.zero,
          bottomRight: Radius.zero,
        ),
      );
    canvas.drawPath(rect2Path, paint);

    // Guide lines - animate with rectangles (end distribution - right edges)
    // Left rectangle guide line at x=10 (right edge: 4+6)
    canvas.drawLine(
      Offset(10.0 * scale, 2.0 * scale),
      Offset(10.0 * scale, 22.0 * scale),
      paint,
    );

    // Right rectangle guide line at x=20 (right edge: 14+6)
    canvas.drawLine(
      Offset(20.0 * scale, 2.0 * scale),
      Offset(20.0 * scale, 22.0 * scale),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
