import 'package:flutter/material.dart';

import '../core/draw_icon_base.dart';

class CreditCardCheckIcon extends DrawIconBase {
  const CreditCardCheckIcon({
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
  String get animationDescription => 'Check confirms payment';

  @override
  List<Path> get paths => [
        Path()
          ..moveTo(12.5, 19)
          ..lineTo(4, 19)
          ..arcToPoint(const Offset(2, 17), radius: const Radius.circular(2))
          ..lineTo(2, 7)
          ..arcToPoint(const Offset(4, 5), radius: const Radius.circular(2))
          ..lineTo(20, 5)
          ..arcToPoint(const Offset(22, 7), radius: const Radius.circular(2))
          ..lineTo(22, 11),
        Path()
          ..moveTo(16, 17)
          ..lineTo(18, 19)
          ..lineTo(22, 15),
        Path()
          ..moveTo(2, 10)
          ..lineTo(22, 10),
      ];

  @override
  void paintIcon(Canvas canvas, Paint paint, double animationValue) {
    drawIconPaths(canvas, paint, [paths[0], paths[2]]);
    final pulse = iconPulse(animationValue);
    canvas.save();
    canvas.translate(19, 17);
    canvas.scale(1 + pulse * .18);
    canvas.translate(-19, -17 - pulse * .5);
    canvas.drawPath(paths[1], paint);
    canvas.restore();
  }
}
