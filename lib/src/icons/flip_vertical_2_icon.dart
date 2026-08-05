import 'package:flutter/material.dart';

import '../core/animated_svg_icon_base.dart';

/// Animated FlipVertical2 icon.
class FlipVertical2Icon extends AnimatedSVGIcon {
  const FlipVertical2Icon({
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
      _FlipVertical2Painter(
        color: color,
        animationValue: animationValue,
        strokeWidth: strokeWidth,
      );
}

class _FlipVertical2Painter extends CustomPainter {
  const _FlipVertical2Painter({
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
      ..moveTo(4, 12)
      ..lineTo(2, 12)
      ..moveTo(10, 12)
      ..lineTo(8, 12)
      ..moveTo(16, 12)
      ..lineTo(14, 12)
      ..moveTo(22, 12)
      ..lineTo(20, 12);
    canvas.drawPath(axis, paint);

    canvas.save();
    canvas.translate(12, 5.5);
    canvas.scale(1, 1 - 2 * t);
    canvas.translate(-12, -5.5);
    final top = Path()
      ..moveTo(17, 3)
      ..lineTo(12, 8)
      ..lineTo(7, 3)
      ..close();
    canvas.drawPath(top, paint);
    canvas.restore();

    canvas.save();
    canvas.translate(12, 18.5);
    canvas.scale(1, 1 - 2 * t);
    canvas.translate(-12, -18.5);
    final bottom = Path()
      ..moveTo(17, 21)
      ..lineTo(12, 16)
      ..lineTo(7, 21)
      ..close();
    canvas.drawPath(bottom, paint);
    canvas.restore();
    canvas.restore();
  }

  @override
  bool shouldRepaint(_FlipVertical2Painter oldDelegate) =>
      oldDelegate.color != color ||
      oldDelegate.animationValue != animationValue ||
      oldDelegate.strokeWidth != strokeWidth;
}
