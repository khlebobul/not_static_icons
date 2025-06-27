import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

class AlignVerticalDistributeCenterIcon extends AnimatedSVGIcon {
  const AlignVerticalDistributeCenterIcon({
    super.key,
    super.size = 24.0,
    super.color = Colors.black,
    super.animationDuration = const Duration(milliseconds: 600),
  });

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
  }) => _AlignVerticalDistributeCenterPainter(
    color: color,
    animationValue: animationValue,
  );

  @override
  String get animationDescription =>
      'Rectangles change sizes to demonstrate distribution';
}

class _AlignVerticalDistributeCenterPainter extends CustomPainter {
  final Color color;
  final double animationValue;

  _AlignVerticalDistributeCenterPainter({
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

    // Guide lines - animate with rectangles
    // Top rectangle guide lines - adjust with rect1 width
    final rect1RightX = rect1Left + rect1Width;
    canvas.drawLine(
      Offset(2.0 * scale, 7.0 * scale),
      Offset(rect1Left, 7.0 * scale),
      paint,
    );
    canvas.drawLine(
      Offset(rect1RightX, 7.0 * scale),
      Offset(22.0 * scale, 7.0 * scale),
      paint,
    );

    // Bottom rectangle guide lines - adjust with rect2 width
    final rect2RightX = rect2Left + rect2Width;
    canvas.drawLine(
      Offset(2.0 * scale, 17.0 * scale),
      Offset(rect2Left, 17.0 * scale),
      paint,
    );
    canvas.drawLine(
      Offset(rect2RightX, 17.0 * scale),
      Offset(22.0 * scale, 17.0 * scale),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
