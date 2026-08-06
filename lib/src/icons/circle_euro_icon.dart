import 'package:flutter/material.dart';

import '../core/animated_svg_icon_base.dart';

/// Animated CircleEuro icon.
class CircleEuroIcon extends AnimatedSVGIcon {
  const CircleEuroIcon({
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
  String get animationDescription => 'euro mark flips inside the coin';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) =>
      _CircleEuroPainter(
        color: color,
        animationValue: animationValue,
        strokeWidth: strokeWidth,
      );
}

class _CircleEuroPainter extends CustomPainter {
  const _CircleEuroPainter({
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
    canvas.drawCircle(const Offset(12, 12), 10, paint);
    canvas.save();
    canvas.translate(11, 12);
    canvas.scale(1 - t * .28, 1 + t * .08);
    canvas.translate(-11, -12);
    final euro = Path()
      ..moveTo(15, 9.4)
      ..arcToPoint(
        const Offset(15, 14.6),
        radius: const Radius.circular(4),
        largeArc: true,
        clockwise: false,
      )
      ..moveTo(7, 12)
      ..lineTo(12, 12);
    canvas.drawPath(euro, paint);
    canvas.restore();
    canvas.restore();
  }

  @override
  bool shouldRepaint(_CircleEuroPainter oldDelegate) =>
      oldDelegate.color != color ||
      oldDelegate.animationValue != animationValue ||
      oldDelegate.strokeWidth != strokeWidth;
}
