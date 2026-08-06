import 'package:flutter/material.dart';

import '../core/animated_svg_icon_base.dart';

/// Animated EyeDashed icon.
class EyeDashedIcon extends AnimatedSVGIcon {
  const EyeDashedIcon({
    super.key,
    super.size = 40,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 800),
    super.strokeWidth = 2,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
    super.onTap,
    super.interactive,
    super.controller,
  });

  @override
  String get animationDescription => 'dashed gaze orbits around a pulsing iris';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) =>
      _EyeDashedPainter(
        color: color,
        animationValue: animationValue,
        strokeWidth: strokeWidth,
      );
}

class _EyeDashedPainter extends CustomPainter {
  const _EyeDashedPainter({
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
    canvas.translate(12, 12);
    canvas.rotate(t * .22);
    canvas.translate(-12, -12);
    final dashes = Path()
      ..moveTo(13.054, 18.946)
      ..arcToPoint(const Offset(10.944, 18.946),
          radius: const Radius.circular(11))
      ..moveTo(13.054, 5.054)
      ..arcToPoint(
        const Offset(10.944, 5.053),
        radius: const Radius.circular(11),
        clockwise: false,
      )
      ..moveTo(17.072, 6.274)
      ..arcToPoint(const Offset(18.825, 7.447),
          radius: const Radius.circular(11))
      ..moveTo(18.825, 16.552)
      ..arcToPoint(const Offset(17.072, 17.726),
          radius: const Radius.circular(11))
      ..moveTo(2.514, 13.303)
      ..arcToPoint(const Offset(2.062, 12.349),
          radius: const Radius.circular(11))
      ..arcToPoint(const Offset(2.062, 11.652),
          radius: const Radius.circular(1))
      ..arcToPoint(const Offset(2.512, 10.697),
          radius: const Radius.circular(11))
      ..moveTo(21.485, 10.697)
      ..arcToPoint(const Offset(21.938, 11.652),
          radius: const Radius.circular(11))
      ..arcToPoint(const Offset(21.938, 12.349),
          radius: const Radius.circular(1))
      ..arcToPoint(const Offset(21.485, 13.303),
          radius: const Radius.circular(11))
      ..moveTo(5.173, 7.448)
      ..arcToPoint(const Offset(6.926, 6.274),
          radius: const Radius.circular(11))
      ..moveTo(6.926, 17.726)
      ..arcToPoint(const Offset(5.173, 16.552),
          radius: const Radius.circular(11));
    canvas.drawPath(dashes, paint);
    canvas.restore();
    canvas.drawCircle(const Offset(12, 12), 3 + t * .35, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(_EyeDashedPainter oldDelegate) =>
      oldDelegate.color != color ||
      oldDelegate.animationValue != animationValue ||
      oldDelegate.strokeWidth != strokeWidth;
}
