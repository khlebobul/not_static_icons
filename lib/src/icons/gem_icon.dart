import 'package:flutter/material.dart';

import '../core/draw_icon_base.dart';

class GemIcon extends DrawIconBase {
  const GemIcon({
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
  String get animationDescription => 'Gem facets shimmer';

  @override
  List<Path> get paths => [
        Path()
          ..moveTo(10.5, 3)
          ..lineTo(8, 9)
          ..lineTo(12, 22)
          ..lineTo(16, 9)
          ..lineTo(13.5, 3),
        Path()
          ..moveTo(17, 3)
          ..arcToPoint(const Offset(18.6, 3.8),
              radius: const Radius.circular(2))
          ..lineTo(21.6, 7.8)
          ..arcToPoint(const Offset(21.613, 10.182),
              radius: const Radius.circular(2))
          ..lineTo(13.623, 21.168)
          ..arcToPoint(const Offset(10.376, 21.168),
              radius: const Radius.circular(2))
          ..lineTo(2.386, 10.182)
          ..arcToPoint(const Offset(2.4, 7.8), radius: const Radius.circular(2))
          ..lineTo(5.398, 3.803)
          ..arcToPoint(const Offset(7, 3), radius: const Radius.circular(2))
          ..close(),
        Path()
          ..moveTo(2, 9)
          ..lineTo(22, 9),
      ];

  @override
  void paintIcon(Canvas canvas, Paint paint, double animationValue) {
    drawIconPaths(canvas, paint, [paths[1]]);
    final pulse = iconPulse(animationValue);
    canvas.save();
    canvas.translate(12, 9);
    canvas.scale(1 + pulse * .12, 1 - pulse * .08);
    canvas.translate(-12, -9);
    drawIconPaths(canvas, paint, [paths[0], paths[2]]);
    canvas.restore();
  }
}
