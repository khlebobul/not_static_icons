import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

class AlignHorizontalSpaceAroundIcon extends AnimatedSVGIcon {
  const AlignHorizontalSpaceAroundIcon({
    super.key,
    super.size = 24.0,
    super.color = Colors.black,
    super.animationDuration = const Duration(milliseconds: 600),
  });

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
  }) => _AlignHorizontalSpaceAroundPainter(
    color: color,
    animationValue: animationValue,
  );

  @override
  String get animationDescription =>
      'Rectangle shrinks and returns to original size';
}

class _AlignHorizontalSpaceAroundPainter extends CustomPainter {
  final Color color;
  final double animationValue;

  _AlignHorizontalSpaceAroundPainter({
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
    // First half (0.0 to 0.5): shrink rectangle
    // Second half (0.5 to 1.0): return to original size
    final animT = t <= 0.5 ? t * 2.0 : (1.0 - t) * 2.0;

    // Central rectangle - shrinks during animation
    final originalWidth = 6.0 * scale;
    final originalHeight = 10.0 * scale;
    final minWidth = 4.0 * scale; // Shrink to smaller size
    final minHeight = 6.0 * scale; // Shrink to smaller size

    final currentWidth = originalWidth - (originalWidth - minWidth) * animT;
    final currentHeight = originalHeight - (originalHeight - minHeight) * animT;

    // Center the shrinking rectangle
    final rectLeft = 9.0 * scale + (originalWidth - currentWidth) / 2;
    final rectTop = 7.0 * scale + (originalHeight - currentHeight) / 2;

    final rect = RRect.fromRectAndRadius(
      Rect.fromLTWH(rectLeft, rectTop, currentWidth, currentHeight),
      Radius.circular(2.0 * scale),
    );
    canvas.drawRRect(rect, paint);

    // Left vertical line
    canvas.drawLine(
      Offset(4.0 * scale, 2.0 * scale),
      Offset(4.0 * scale, 22.0 * scale),
      paint,
    );

    // Right vertical line
    canvas.drawLine(
      Offset(20.0 * scale, 2.0 * scale),
      Offset(20.0 * scale, 22.0 * scale),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
