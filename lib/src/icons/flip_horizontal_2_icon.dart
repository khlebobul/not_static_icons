import 'package:flutter/material.dart';

import '../core/animated_svg_icon_base.dart';

/// Animated FlipHorizontal2 icon.
class FlipHorizontal2Icon extends AnimatedSVGIcon {
  const FlipHorizontal2Icon({
    super.key,
    super.size = 40,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 600),
    super.strokeWidth = 2,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
    super.onTap,
    super.interactive,
    super.controller,
  });

  @override
  String get animationDescription => 'both halves mirror across the axis';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) =>
      _FlipHorizontal2Painter(
        color: color,
        animationValue: animationValue,
        strokeWidth: strokeWidth,
      );
}

class _FlipHorizontal2Painter extends CustomPainter {
  const _FlipHorizontal2Painter({
    required this.color,
    required this.animationValue,
    required this.strokeWidth,
  });

  final Color color;
  final double animationValue;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final scale = size.width / 24;
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth / scale
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;

    canvas.save();
    canvas.scale(scale);
    final t = 4 * animationValue * (1 - animationValue);
    final axis = Path()
      ..moveTo(12, 20)
      ..lineTo(12, 22)
      ..moveTo(12, 14)
      ..lineTo(12, 16)
      ..moveTo(12, 8)
      ..lineTo(12, 10)
      ..moveTo(12, 2)
      ..lineTo(12, 4);
    canvas.drawPath(axis, paint);

    canvas.save();
    canvas.translate(5.5, 12);
    canvas.scale(1 - 2 * t, 1);
    canvas.translate(-5.5, -12);
    final left = Path()
      ..moveTo(3, 7)
      ..lineTo(8, 12)
      ..lineTo(3, 17)
      ..close();
    canvas.drawPath(left, paint);
    canvas.restore();

    canvas.save();
    canvas.translate(18.5, 12);
    canvas.scale(1 - 2 * t, 1);
    canvas.translate(-18.5, -12);
    final right = Path()
      ..moveTo(21, 7)
      ..lineTo(16, 12)
      ..lineTo(21, 17)
      ..close();
    canvas.drawPath(right, paint);
    canvas.restore();
    canvas.restore();
  }

  @override
  bool shouldRepaint(_FlipHorizontal2Painter oldDelegate) =>
      oldDelegate.color != color ||
      oldDelegate.animationValue != animationValue ||
      oldDelegate.strokeWidth != strokeWidth;
}
