import 'package:flutter/material.dart';
import 'dart:math';

import '../core/animated_svg_icon_base.dart';

class AlignCenterHorizontalIcon extends AnimatedSVGIcon {
  const AlignCenterHorizontalIcon({
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
  String get animationDescription =>
      'A horizontal line animates from the center outwards.';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return _AlignCenterHorizontalIconPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class _AlignCenterHorizontalIconPainter extends CustomPainter {
  _AlignCenterHorizontalIconPainter({
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

    // d="M10 16v4a2 2 0 0 1-2 2H6a2 2 0 0 1-2-2v-4"
    final path1 = Path()
      ..moveTo(10 * s, 16 * s)
      ..lineTo(10 * s, 20 * s)
      ..arcToPoint(
        Offset(8 * s, 22 * s),
        radius: Radius.circular(2 * s),
        clockwise: true,
      )
      ..lineTo(6 * s, 22 * s)
      ..arcToPoint(
        Offset(4 * s, 20 * s),
        radius: Radius.circular(2 * s),
        clockwise: true,
      )
      ..lineTo(4 * s, 16 * s);
    canvas.drawPath(path1, paint);

    // d="M10 8V4a2 2 0 0 0-2-2H6a2 2 0 0 0-2 2v4"
    final path2 = Path()
      ..moveTo(10 * s, 8 * s)
      ..lineTo(10 * s, 4 * s)
      ..arcToPoint(
        Offset(8 * s, 2 * s),
        radius: Radius.circular(2 * s),
        clockwise: false,
      )
      ..lineTo(6 * s, 2 * s)
      ..arcToPoint(
        Offset(4 * s, 4 * s),
        radius: Radius.circular(2 * s),
        clockwise: false,
      )
      ..lineTo(4 * s, 8 * s);
    canvas.drawPath(path2, paint);

    // d="M20 16v1a2 2 0 0 1-2 2h-2a2 2 0 0 1-2-2v-1"
    final path3 = Path()
      ..moveTo(20 * s, 16 * s)
      ..lineTo(20 * s, 17 * s)
      ..arcToPoint(
        Offset(18 * s, 19 * s),
        radius: Radius.circular(2 * s),
        clockwise: true,
      )
      ..lineTo(16 * s, 19 * s)
      ..arcToPoint(
        Offset(14 * s, 17 * s),
        radius: Radius.circular(2 * s),
        clockwise: true,
      )
      ..lineTo(14 * s, 16 * s);
    canvas.drawPath(path3, paint);

    // d="M14 8V7c0-1.1.9-2 2-2h2a2 2 0 0 1 2 2v1"
    final path4 = Path()
      ..moveTo(14 * s, 8 * s)
      ..lineTo(14 * s, 7 * s)
      ..relativeCubicTo(0, -1.1 * s, 0.9 * s, -2 * s, 2 * s, -2 * s)
      ..relativeLineTo(2 * s, 0)
      ..arcToPoint(
        Offset(20 * s, 7 * s),
        radius: Radius.circular(2 * s),
        clockwise: true,
      )
      ..relativeLineTo(0, 1 * s);
    canvas.drawPath(path4, paint);

    // Animated line: d="M2 12h20"
    final completeness = 1.0 - sin(animationValue * pi);
    final centerX = 12 * s;
    final startX = 2 * s;
    final endX = 22 * s;

    final currentStartX = centerX - (centerX - startX) * completeness;
    final currentEndX = centerX + (endX - centerX) * completeness;

    canvas.drawLine(
      Offset(currentStartX, 12 * s),
      Offset(currentEndX, 12 * s),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant _AlignCenterHorizontalIconPainter oldDelegate) {
    return oldDelegate.animationValue != animationValue ||
        oldDelegate.color != color ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
