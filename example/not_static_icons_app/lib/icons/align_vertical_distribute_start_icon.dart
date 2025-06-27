import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

class AlignVerticalDistributeStartIcon extends AnimatedSVGIcon {
  const AlignVerticalDistributeStartIcon({
    super.key,
    super.size = 24.0,
    super.color = Colors.black,
    super.animationDuration = const Duration(milliseconds: 600),
  });

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
  }) => _AlignVerticalDistributeStartPainter(
    color: color,
    animationValue: animationValue,
  );

  @override
  String get animationDescription =>
      'Rectangles change sizes with vertical start distribution';
}

class _AlignVerticalDistributeStartPainter extends CustomPainter {
  final Color color;
  final double animationValue;

  _AlignVerticalDistributeStartPainter({
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

    // First rectangle (top) - gets smaller during animation
    final rect1OriginalWidth = 10.0 * scale;
    final rect1MinWidth = 6.0 * scale; // Smaller width
    final rect1Width =
        rect1OriginalWidth - (rect1OriginalWidth - rect1MinWidth) * animT;
    final rect1Left =
        7.0 * scale +
        (rect1OriginalWidth - rect1Width) / 2; // Center horizontally

    final rect1Rect = RRect.fromRectAndRadius(
      Rect.fromLTWH(rect1Left, 4.0 * scale, rect1Width, 6.0 * scale),
      Radius.circular(2.0 * scale),
    );
    canvas.drawRRect(rect1Rect, paint);

    // Second rectangle (bottom) - gets bigger during animation
    final rect2OriginalWidth = 14.0 * scale;
    final rect2MaxWidth = 18.0 * scale; // Bigger width
    final rect2Width =
        rect2OriginalWidth + (rect2MaxWidth - rect2OriginalWidth) * animT;
    final rect2Left =
        5.0 * scale -
        (rect2Width - rect2OriginalWidth) / 2; // Center horizontally

    final rect2Rect = RRect.fromRectAndRadius(
      Rect.fromLTWH(rect2Left, 14.0 * scale, rect2Width, 6.0 * scale),
      Radius.circular(2.0 * scale),
    );
    canvas.drawRRect(rect2Rect, paint);

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
