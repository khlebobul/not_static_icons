import 'package:flutter/material.dart';

import '../core/animated_svg_icon_base.dart';

/// Animated Flower2 icon.
class Flower2Icon extends AnimatedSVGIcon {
  const Flower2Icon({
    super.key,
    super.size = 40,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 700),
    super.strokeWidth = 2,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
    super.onTap,
    super.interactive,
    super.controller,
  });

  @override
  String get animationDescription => 'blossom turns and leaves unfold';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) =>
      _Flower2Painter(
        color: color,
        animationValue: animationValue,
        strokeWidth: strokeWidth,
      );
}

class _Flower2Painter extends CustomPainter {
  const _Flower2Painter({
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
    canvas.save();
    canvas.translate(12, 8);
    canvas.rotate(t * .22);
    canvas.scale(1 + t * .08);
    canvas.translate(-12, -8);
    final petals = Path()
      ..moveTo(12, 5)
      ..arcToPoint(const Offset(15, 8),
          radius: const Radius.circular(3), largeArc: true)
      ..moveTo(12, 5)
      ..arcToPoint(const Offset(9, 8),
          radius: const Radius.circular(3), largeArc: true, clockwise: false)
      ..moveTo(12, 5)
      ..lineTo(12, 6)
      ..moveTo(9, 8)
      ..arcToPoint(const Offset(12, 11),
          radius: const Radius.circular(3), largeArc: true, clockwise: false)
      ..moveTo(9, 8)
      ..lineTo(10, 8)
      ..moveTo(15, 8)
      ..arcToPoint(const Offset(12, 11),
          radius: const Radius.circular(3), largeArc: true)
      ..moveTo(15, 8)
      ..lineTo(14, 8)
      ..moveTo(12, 11)
      ..lineTo(12, 10);
    canvas.drawPath(petals, paint);
    canvas.drawCircle(const Offset(12, 8), 2 - t * .2, paint);
    canvas.restore();

    canvas.drawLine(const Offset(12, 10), const Offset(12, 22), paint);
    canvas.save();
    canvas.translate(12, 22);
    canvas.rotate(-t * .12);
    canvas.translate(-12, -22);
    final rightLeaf = Path()
      ..moveTo(12, 22)
      ..cubicTo(16.2, 22, 19, 20.333, 19, 17)
      ..cubicTo(14.8, 17, 12, 18.667, 12, 22);
    canvas.drawPath(rightLeaf, paint);
    canvas.restore();
    canvas.save();
    canvas.translate(12, 22);
    canvas.rotate(t * .12);
    canvas.translate(-12, -22);
    final leftLeaf = Path()
      ..moveTo(12, 22)
      ..cubicTo(7.8, 22, 5, 20.333, 5, 17)
      ..cubicTo(9.2, 17, 12, 18.667, 12, 22);
    canvas.drawPath(leftLeaf, paint);
    canvas.restore();
    canvas.restore();
  }

  @override
  bool shouldRepaint(_Flower2Painter oldDelegate) =>
      oldDelegate.color != color ||
      oldDelegate.animationValue != animationValue ||
      oldDelegate.strokeWidth != strokeWidth;
}
