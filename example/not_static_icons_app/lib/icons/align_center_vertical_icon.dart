import 'package:flutter/material.dart';
import 'dart:math';

import '../core/animated_svg_icon_base.dart';

class AlignCenterVerticalIcon extends AnimatedSVGIcon {
  const AlignCenterVerticalIcon({
    super.key,
    super.size = 100.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 600),
    super.strokeWidth = 2.0,
  });

  @override
  String get animationDescription =>
      'A vertical line animates from the center outwards.';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return _AlignCenterVerticalIconPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class _AlignCenterVerticalIconPainter extends CustomPainter {
  _AlignCenterVerticalIconPainter({
    required this.color,
    required this.animationValue,
    required this.strokeWidth,
  });

  final Color color;
  final double animationValue;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final s = size.width / 24.0;
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    // d="M8 10H4a2 2 0 0 1-2-2V6c0-1.1.9-2 2-2h4"
    final path1 = Path()
      ..moveTo(8 * s, 10 * s)
      ..lineTo(4 * s, 10 * s)
      ..arcToPoint(
        Offset(2 * s, 8 * s),
        radius: Radius.circular(2 * s),
        clockwise: true,
      )
      ..lineTo(2 * s, 6 * s)
      ..relativeCubicTo(0, -1.1 * s, 0.9 * s, -2 * s, 2 * s, -2 * s)
      ..lineTo(8 * s, 4 * s);
    canvas.drawPath(path1, paint);

    // d="M16 10h4a2 2 0 0 0 2-2V6a2 2 0 0 0-2-2h-4"
    final path2 = Path()
      ..moveTo(16 * s, 10 * s)
      ..lineTo(20 * s, 10 * s)
      ..arcToPoint(
        Offset(22 * s, 8 * s),
        radius: Radius.circular(2 * s),
        clockwise: false,
      )
      ..lineTo(22 * s, 6 * s)
      ..arcToPoint(
        Offset(20 * s, 4 * s),
        radius: Radius.circular(2 * s),
        clockwise: false,
      )
      ..lineTo(16 * s, 4 * s);
    canvas.drawPath(path2, paint);

    // d="M8 20H7a2 2 0 0 1-2-2v-2c0-1.1.9-2 2-2h1"
    final path3 = Path()
      ..moveTo(8 * s, 20 * s)
      ..lineTo(7 * s, 20 * s)
      ..arcToPoint(
        Offset(5 * s, 18 * s),
        radius: Radius.circular(2 * s),
        clockwise: true,
      )
      ..lineTo(5 * s, 16 * s)
      ..relativeCubicTo(0, -1.1 * s, 0.9 * s, -2 * s, 2 * s, -2 * s)
      ..lineTo(8 * s, 14 * s);
    canvas.drawPath(path3, paint);

    // d="M16 14h1a2 2 0 0 1 2 2v2a2 2 0 0 1-2 2h-1"
    final path4 = Path()
      ..moveTo(16 * s, 14 * s)
      ..lineTo(17 * s, 14 * s)
      ..arcToPoint(
        Offset(19 * s, 16 * s),
        radius: Radius.circular(2 * s),
        clockwise: true,
      )
      ..lineTo(19 * s, 18 * s)
      ..arcToPoint(
        Offset(17 * s, 20 * s),
        radius: Radius.circular(2 * s),
        clockwise: true,
      )
      ..lineTo(16 * s, 20 * s);
    canvas.drawPath(path4, paint);

    // Animated line: d="M12 2v20"
    final completeness = 1.0 - sin(animationValue * pi);
    final centerY = 12 * s;
    final startY = 2 * s;
    final endY = 22 * s;

    final currentStartY = centerY - (centerY - startY) * completeness;
    final currentEndY = centerY + (endY - centerY) * completeness;

    canvas.drawLine(
      Offset(12 * s, currentStartY),
      Offset(12 * s, currentEndY),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant _AlignCenterVerticalIconPainter oldDelegate) {
    return oldDelegate.animationValue != animationValue ||
        oldDelegate.color != color ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
