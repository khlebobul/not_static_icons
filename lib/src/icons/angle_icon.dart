import 'package:flutter/material.dart';

import '../core/draw_icon_base.dart';

class AngleIcon extends DrawIconBase {
  const AngleIcon({
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
  String get animationDescription => 'Angle arc opens and closes';

  @override
  List<Path> get paths => [
        Path()
          ..moveTo(3, 3)
          ..lineTo(3, 19)
          ..arcToPoint(
            const Offset(5, 21),
            radius: const Radius.circular(2),
            clockwise: false,
          )
          ..lineTo(21, 21),
        Path()
          ..moveTo(3, 11)
          ..arcToPoint(const Offset(13, 21), radius: const Radius.circular(10)),
      ];

  @override
  void paintIcon(Canvas canvas, Paint paint, double animationValue) {
    drawIconPaths(canvas, paint, [paths[0]]);
    canvas.save();
    canvas.translate(3, 21);
    canvas.scale(1 - iconPulse(animationValue) * .12, 1);
    canvas.translate(-3, -21);
    drawIconPaths(canvas, paint, [paths[1]]);
    canvas.restore();
  }
}
