import 'package:flutter/material.dart';

import '../core/draw_icon_base.dart';

class CreditCardPlusIcon extends DrawIconBase {
  const CreditCardPlusIcon({
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
  String get animationDescription => 'Plus rotates and grows';

  @override
  List<Path> get paths => [
        Path()
          ..moveTo(16, 17)
          ..lineTo(22, 17),
        Path()
          ..moveTo(19, 14)
          ..lineTo(19, 20),
        Path()
          ..moveTo(22, 10)
          ..lineTo(2, 10),
        Path()
          ..moveTo(22, 11.354)
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
    drawIconPaths(canvas, paint, paths.skip(2));
    final pulse = iconPulse(animationValue);
    canvas.save();
    canvas.translate(19, 17);
    canvas.rotate(pulse * .7854);
    canvas.scale(1 + pulse * .15);
    canvas.translate(-19, -17);
    drawIconPaths(canvas, paint, paths.take(2));
    canvas.restore();
  }
}
