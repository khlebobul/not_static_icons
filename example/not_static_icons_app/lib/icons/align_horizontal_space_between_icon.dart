import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

class AlignHorizontalSpaceBetweenIcon extends AnimatedSVGIcon {
  const AlignHorizontalSpaceBetweenIcon({
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
  }) => _AlignHorizontalSpaceBetweenPainter(
    color: color,
    animationValue: animationValue,
    strokeWidth: strokeWidth,
  );

  @override
  String get animationDescription =>
      'Rectangles change sizes with horizontal space between distribution';
}

class _AlignHorizontalSpaceBetweenPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _AlignHorizontalSpaceBetweenPainter({
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

    // Left rectangle - gets taller during animation
    final rect1OriginalHeight = 14.0 * scale;
    final rect1MaxHeight = 18.0 * scale; // Bigger height
    final rect1Height =
        rect1OriginalHeight + (rect1MaxHeight - rect1OriginalHeight) * animT;
    final rect1Top =
        5.0 * scale -
        (rect1Height - rect1OriginalHeight) / 2; // Center vertically

    final rect1Path = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(3.0 * scale, rect1Top, 6.0 * scale, rect1Height),
          Radius.circular(2.0 * scale),
        ),
      );
    canvas.drawPath(rect1Path, paint);

    // Right rectangle - gets shorter during animation
    final rect2OriginalHeight = 10.0 * scale;
    final rect2MinHeight = 6.0 * scale; // Smaller height
    final rect2Height =
        rect2OriginalHeight - (rect2OriginalHeight - rect2MinHeight) * animT;
    final rect2Top =
        7.0 * scale +
        (rect2OriginalHeight - rect2Height) / 2; // Center vertically

    final rect2Path = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(15.0 * scale, rect2Top, 6.0 * scale, rect2Height),
          Radius.circular(2.0 * scale),
        ),
      );
    canvas.drawPath(rect2Path, paint);

    // Vertical guide lines (borders showing the space between)
    // Left line at x=3
    canvas.drawLine(
      Offset(3.0 * scale, 2.0 * scale),
      Offset(3.0 * scale, 22.0 * scale),
      paint,
    );

    // Right line at x=21
    canvas.drawLine(
      Offset(21.0 * scale, 2.0 * scale),
      Offset(21.0 * scale, 22.0 * scale),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
