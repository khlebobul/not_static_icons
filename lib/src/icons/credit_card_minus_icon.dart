import 'package:flutter/material.dart';

import '../core/draw_icon_base.dart';

class CreditCardMinusIcon extends DrawIconBase {
  const CreditCardMinusIcon({
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
  String get animationDescription => 'Minus contracts';

  @override
  List<Path> get paths => [
        Path()
          ..moveTo(16, 17)
          ..lineTo(22, 17),
        Path()
          ..moveTo(22, 10)
          ..lineTo(2, 10),
        Path()
          ..moveTo(22, 13)
          ..lineTo(22, 7)
          ..arcToPoint(
            const Offset(20, 5),
            radius: const Radius.circular(2),
            clockwise: false,
          )
          ..lineTo(4, 5)
          ..arcToPoint(
            const Offset(2, 7),
            radius: const Radius.circular(2),
            clockwise: false,
          )
          ..lineTo(2, 17)
          ..arcToPoint(
            const Offset(4, 19),
            radius: const Radius.circular(2),
            clockwise: false,
          )
          ..lineTo(12.536, 19),
      ];

  @override
  void paintIcon(Canvas canvas, Paint paint, double animationValue) {
    drawIconPaths(canvas, paint, paths.skip(1));
    final pulse = iconPulse(animationValue);
    canvas.save();
    canvas.translate(19, 17);
    canvas.scale(1 - pulse * .45, 1);
    canvas.translate(-19, -17);
    canvas.drawPath(paths[0], paint);
    canvas.restore();
  }
}
