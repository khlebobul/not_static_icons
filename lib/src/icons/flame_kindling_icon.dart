import 'package:flutter/material.dart';

import '../core/animated_svg_icon_base.dart';

/// Animated FlameKindling icon.
class FlameKindlingIcon extends AnimatedSVGIcon {
  const FlameKindlingIcon({
    super.key,
    super.size = 40,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 650),
    super.strokeWidth = 2,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
    super.onTap,
    super.interactive,
    super.controller,
  });

  @override
  String get animationDescription => 'flame flickers as kindling opens';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) =>
      _FlameKindlingPainter(
        color: color,
        animationValue: animationValue,
        strokeWidth: strokeWidth,
      );
}

class _FlameKindlingPainter extends CustomPainter {
  const _FlameKindlingPainter({
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
    canvas.translate(12, 10);
    canvas.rotate(t * .08);
    canvas.scale(1 - t * .08, 1 + t * .14);
    canvas.translate(-12, -10);
    final flame = Path()
      ..moveTo(12, 2)
      ..cubicTo(13, 5, 14.5, 5.5, 15.5, 6.5)
      ..arcToPoint(const Offset(17, 10), radius: const Radius.circular(5))
      ..arcToPoint(const Offset(7, 10),
          radius: const Radius.circular(5), largeArc: true)
      ..cubicTo(7, 9.7, 7, 9.4, 7.1, 9.1)
      ..arcToPoint(const Offset(10.4, 7.1),
          radius: const Radius.circular(2), largeArc: true, clockwise: false)
      ..cubicTo(8, 4.5, 11, 2, 12, 2)
      ..close();
    canvas.drawPath(flame, paint);
    canvas.restore();
    canvas.save();
    canvas.translate(12, 20);
    canvas.rotate(t * .04);
    canvas.translate(-12, -20);
    canvas.drawLine(const Offset(5, 22), const Offset(19, 18), paint);
    canvas.restore();
    canvas.save();
    canvas.translate(12, 20);
    canvas.rotate(-t * .04);
    canvas.translate(-12, -20);
    canvas.drawLine(const Offset(5, 18), const Offset(19, 22), paint);
    canvas.restore();
    canvas.restore();
  }

  @override
  bool shouldRepaint(_FlameKindlingPainter oldDelegate) =>
      oldDelegate.color != color ||
      oldDelegate.animationValue != animationValue ||
      oldDelegate.strokeWidth != strokeWidth;
}
