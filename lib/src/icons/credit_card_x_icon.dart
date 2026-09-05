import 'package:flutter/material.dart';

import '../core/draw_icon_base.dart';

class CreditCardXIcon extends DrawIconBase {
  const CreditCardXIcon({
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
  String get animationDescription => 'X rejects payment';

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
          ..lineTo(22, 10.5),
        Path()
          ..moveTo(16.5, 14.5)
          ..lineTo(21.5, 19.5),
        Path()
          ..moveTo(2, 10)
          ..lineTo(22, 10),
        Path()
          ..moveTo(21.5, 14.5)
          ..lineTo(16.5, 19.5),
      ];

  @override
  void paintIcon(Canvas canvas, Paint paint, double animationValue) {
    drawIconPaths(canvas, paint, [paths[0], paths[2]]);
    canvas.save();
    canvas.translate(iconWave(animationValue) * .8, 0);
    drawIconPaths(canvas, paint, [paths[1], paths[3]]);
    canvas.restore();
  }
}
