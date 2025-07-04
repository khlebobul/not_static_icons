import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

class AlignVerticalSpaceBetweenIcon extends AnimatedSVGIcon {
  const AlignVerticalSpaceBetweenIcon({
    super.key,
    super.size = 24.0,
    super.color = Colors.black,
    super.animationDuration = const Duration(milliseconds: 600),
    super.strokeWidth = 2.0,
  });

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) => _AlignVerticalSpaceBetweenPainter(
    color: color,
    animationValue: animationValue,
    strokeWidth: strokeWidth,
  );

  @override
  String get animationDescription =>
      'Rectangles change sizes with vertical space between distribution';
}

class _AlignVerticalSpaceBetweenPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _AlignVerticalSpaceBetweenPainter({
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

    // Top rectangle - gets wider during animation
    final rect1OriginalWidth = 10.0 * scale;
    final rect1MaxWidth = 14.0 * scale; // Bigger width
    final rect1Width =
        rect1OriginalWidth + (rect1MaxWidth - rect1OriginalWidth) * animT;
    final rect1Left =
        7.0 * scale -
        (rect1Width - rect1OriginalWidth) / 2; // Center horizontally

    final rect1Path = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(rect1Left, 3.0 * scale, rect1Width, 6.0 * scale),
          Radius.circular(2.0 * scale),
        ),
      );
    canvas.drawPath(rect1Path, paint);

    // Bottom rectangle - gets narrower during animation
    final rect2OriginalWidth = 14.0 * scale;
    final rect2MinWidth = 10.0 * scale; // Smaller width
    final rect2Width =
        rect2OriginalWidth - (rect2OriginalWidth - rect2MinWidth) * animT;
    final rect2Left =
        5.0 * scale +
        (rect2OriginalWidth - rect2Width) / 2; // Center horizontally

    final rect2Path = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(rect2Left, 15.0 * scale, rect2Width, 6.0 * scale),
          Radius.circular(2.0 * scale),
        ),
      );
    canvas.drawPath(rect2Path, paint);

    // Horizontal guide lines (borders showing the space between)
    // Top line at y=3
    canvas.drawLine(
      Offset(2.0 * scale, 3.0 * scale),
      Offset(22.0 * scale, 3.0 * scale),
      paint,
    );

    // Bottom line at y=21
    canvas.drawLine(
      Offset(2.0 * scale, 21.0 * scale),
      Offset(22.0 * scale, 21.0 * scale),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate is _AlignVerticalSpaceBetweenPainter &&
        (oldDelegate.color != color ||
            oldDelegate.animationValue != animationValue ||
            oldDelegate.strokeWidth != strokeWidth);
  }
}
