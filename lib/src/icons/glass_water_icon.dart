import 'package:flutter/material.dart';

import '../core/draw_icon_base.dart';

class GlassWaterIcon extends DrawIconBase {
  const GlassWaterIcon({
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
  String get animationDescription => 'Water sloshes inside the glass';

  @override
  List<Path> get paths => [
        Path()
          ..moveTo(5.116, 4.104)
          ..arcToPoint(const Offset(6.11, 3), radius: const Radius.circular(1))
          ..lineTo(17.89, 3)
          ..arcToPoint(const Offset(18.884, 4.105),
              radius: const Radius.circular(1))
          ..lineTo(17.19, 20.21)
          ..arcToPoint(const Offset(15.2, 22), radius: const Radius.circular(2))
          ..lineTo(8.8, 22)
          ..arcToPoint(const Offset(6.8, 20.21),
              radius: const Radius.circular(2))
          ..close(),
        Path()
          ..moveTo(6, 12)
          ..arcToPoint(const Offset(12, 12), radius: const Radius.circular(5))
          ..arcToPoint(const Offset(18, 12),
              radius: const Radius.circular(5), clockwise: false),
      ];

  @override
  void paintIcon(Canvas canvas, Paint paint, double animationValue) {
    canvas.drawPath(paths[0], paint);
    final pulse = iconPulse(animationValue);
    canvas.save();
    canvas.translate(12, iconWave(animationValue) * .6);
    canvas.scale(1 - pulse * .06, 1);
    canvas.translate(-12, 0);
    canvas.drawPath(paths[1], paint);
    canvas.restore();
  }
}
