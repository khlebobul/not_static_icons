import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

class AlignHorizontalDistributeStartIcon extends AnimatedSVGIcon {
  const AlignHorizontalDistributeStartIcon({
    super.key,
    super.size = 24.0,
    super.color = Colors.black,
    super.animationDuration = const Duration(milliseconds: 600),
  });

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
  }) => _AlignHorizontalDistributeStartPainter(
    color: color,
    animationValue: animationValue,
  );

  @override
  String get animationDescription =>
      'Rectangles change sizes with start distribution';
}

class _AlignHorizontalDistributeStartPainter extends CustomPainter {
  final Color color;
  final double animationValue;

  _AlignHorizontalDistributeStartPainter({
    required this.color,
    required this.animationValue,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2.0
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
    final rect1Top =
        5.0 * scale +
        (rect1OriginalHeight - rect1Height) / 2; // Center vertically

    // First rectangle with rounded right corners only (left edge is straight for start alignment)
    final rect1Path = Path()
      ..addRRect(
        RRect.fromRectAndCorners(
          Rect.fromLTWH(4.0 * scale, rect1Top, 6.0 * scale, rect1Height),
          topLeft: Radius.zero,
          bottomLeft: Radius.zero,
          topRight: Radius.circular(2.0 * scale),
          bottomRight: Radius.circular(2.0 * scale),
        ),
      );
    canvas.drawPath(rect1Path, paint);

    // Second rectangle - gets bigger during animation
    final rect2OriginalHeight = 10.0 * scale;
    final rect2MaxHeight = 16.0 * scale; // Bigger height
    final rect2Height =
        rect2OriginalHeight + (rect2MaxHeight - rect2OriginalHeight) * animT;
    final rect2Top =
        7.0 * scale -
        (rect2Height - rect2OriginalHeight) / 2; // Center vertically

    // Second rectangle with rounded right corners only (left edge is straight for start alignment)
    final rect2Path = Path()
      ..addRRect(
        RRect.fromRectAndCorners(
          Rect.fromLTWH(14.0 * scale, rect2Top, 6.0 * scale, rect2Height),
          topLeft: Radius.zero,
          bottomLeft: Radius.zero,
          topRight: Radius.circular(2.0 * scale),
          bottomRight: Radius.circular(2.0 * scale),
        ),
      );
    canvas.drawPath(rect2Path, paint);

    // Guide lines - animate with rectangles (start distribution - left edges)
    // Left rectangle guide line at x=4 (left edge)
    canvas.drawLine(
      Offset(4.0 * scale, 2.0 * scale),
      Offset(4.0 * scale, 22.0 * scale),
      paint,
    );

    // Right rectangle guide line at x=14 (left edge)
    canvas.drawLine(
      Offset(14.0 * scale, 2.0 * scale),
      Offset(14.0 * scale, 22.0 * scale),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
