import 'package:flutter/material.dart';

import '../core/draw_icon_base.dart';

class GiftIcon extends DrawIconBase {
  const GiftIcon({
    super.key,
    super.size,
    super.color,
    super.hoverColor,
    super.animationDuration,
    super.strokeWidth,
    super.reverseOnExit,
    super.enableTouchInteraction,
    super.infiniteLoop,
    super.onTap,
    super.interactive,
    super.controller,
  });

  @override
  String get animationDescription => 'Gift lid and bow pop open';

  @override
  List<Path> get paths => [
        Path()
          ..moveTo(12, 7)
          ..lineTo(12, 21),
        Path()
          ..moveTo(20, 11)
          ..lineTo(20, 19)
          ..arcToPoint(const Offset(18, 21), radius: const Radius.circular(2))
          ..lineTo(6, 21)
          ..arcToPoint(const Offset(4, 19), radius: const Radius.circular(2))
          ..lineTo(4, 11),
        Path()
          ..moveTo(7.5, 7)
          ..arcToPoint(const Offset(7.5, 2), radius: const Radius.circular(1))
          ..arcToPoint(const Offset(12, 7),
              radius: const Radius.elliptical(4.8, 8))
          ..arcToPoint(const Offset(16.5, 2),
              radius: const Radius.elliptical(4.8, 8))
          ..arcToPoint(const Offset(16.5, 7), radius: const Radius.circular(1)),
        Path()
          ..addRRect(RRect.fromRectAndRadius(
              const Rect.fromLTWH(3, 7, 18, 4), const Radius.circular(1))),
      ];

  @override
  void paintIcon(Canvas canvas, Paint paint, double animationValue) {
    drawIconPaths(canvas, paint, [paths[0], paths[1]]);
    final pop = iconPulse(animationValue);
    canvas.save();
    canvas.translate(12, 7);
    canvas.scale(1 + pop * .08);
    canvas.translate(-12, -7 - pop * 1.5);
    drawIconPaths(canvas, paint, [paths[2], paths[3]]);
    canvas.restore();
  }
}
