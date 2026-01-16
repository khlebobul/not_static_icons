import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

class AlignHorizontalDistributeCenterIcon extends AnimatedSVGIcon {
  const AlignHorizontalDistributeCenterIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 600),
    super.strokeWidth = 2.0,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
    super.onTap,
    super.interactive,
    super.controller,
  });

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) =>
      _AlignHorizontalDistributeCenterPainter(
        color: color,
        animationValue: animationValue,
        strokeWidth: strokeWidth,
      );

  @override
  String get animationDescription =>
      'Rectangles change sizes to demonstrate distribution';
}

class _AlignHorizontalDistributeCenterPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _AlignHorizontalDistributeCenterPainter({
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

    final rect1Rect = RRect.fromRectAndRadius(
      Rect.fromLTWH(4.0 * scale, rect1Top, 6.0 * scale, rect1Height),
      Radius.circular(2.0 * scale),
    );
    canvas.drawRRect(rect1Rect, paint);

    // Second rectangle - gets bigger during animation
    final rect2OriginalHeight = 10.0 * scale;
    final rect2MaxHeight = 16.0 * scale; // Bigger height
    final rect2Height =
        rect2OriginalHeight + (rect2MaxHeight - rect2OriginalHeight) * animT;
    final rect2Top = 7.0 * scale -
        (rect2Height - rect2OriginalHeight) / 2; // Center vertically

    final rect2Rect = RRect.fromRectAndRadius(
      Rect.fromLTWH(14.0 * scale, rect2Top, 6.0 * scale, rect2Height),
      Radius.circular(2.0 * scale),
    );
    canvas.drawRRect(rect2Rect, paint);

    // Guide lines - animate with rectangles
    // Left rectangle guide lines - adjust with rect1 height
    final rect1BottomY = rect1Top + rect1Height;
    canvas.drawLine(
      Offset(7.0 * scale, 2.0 * scale),
      Offset(7.0 * scale, rect1Top),
      paint,
    );
    canvas.drawLine(
      Offset(7.0 * scale, rect1BottomY),
      Offset(7.0 * scale, 22.0 * scale),
      paint,
    );

    // Right rectangle guide lines - adjust with rect2 height
    final rect2BottomY = rect2Top + rect2Height;
    canvas.drawLine(
      Offset(17.0 * scale, 2.0 * scale),
      Offset(17.0 * scale, rect2Top),
      paint,
    );
    canvas.drawLine(
      Offset(17.0 * scale, rect2BottomY),
      Offset(17.0 * scale, 22.0 * scale),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
