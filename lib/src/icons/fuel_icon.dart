import 'package:flutter/material.dart';

import '../core/draw_icon_base.dart';

class FuelIcon extends DrawIconBase {
  const FuelIcon({
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
  List<Path> get paths => [
        Path()
          ..moveTo(14, 13)
          ..lineTo(16, 13)
          ..arcToPoint(const Offset(18, 15), radius: const Radius.circular(2))
          ..lineTo(18, 17)
          ..arcToPoint(
            const Offset(22, 17),
            radius: const Radius.circular(2),
            clockwise: false,
          )
          ..lineTo(22, 10.002)
          ..arcToPoint(
            const Offset(21.41, 8.582),
            radius: const Radius.circular(2),
            clockwise: false,
          )
          ..lineTo(18, 5),
        Path()
          ..moveTo(14, 21)
          ..lineTo(14, 5)
          ..arcToPoint(
            const Offset(12, 3),
            radius: const Radius.circular(2),
            clockwise: false,
          )
          ..lineTo(5, 3)
          ..arcToPoint(
            const Offset(3, 5),
            radius: const Radius.circular(2),
            clockwise: false,
          )
          ..lineTo(3, 21),
        Path()
          ..moveTo(2, 21)
          ..lineTo(15, 21),
        Path()
          ..moveTo(3, 9)
          ..lineTo(14, 9),
      ];

  @override
  void paintIcon(Canvas canvas, Paint paint, double animationValue) {
    final level = iconPulse(animationValue);
    drawIconPaths(canvas, paint, [paths[1], paths[2]]);
    canvas.save();
    canvas.translate(iconWave(animationValue) * .7, 0);
    drawIconPaths(canvas, paint, [paths[0]]);
    canvas.restore();
    canvas.save();
    canvas.translate(0, level * 2);
    drawIconPaths(canvas, paint, [paths[3]]);
    canvas.restore();
  }
}
