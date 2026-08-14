import 'package:flutter/material.dart';

import '../core/draw_icon_base.dart';

class EjectIcon extends DrawIconBase {
  const EjectIcon({
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
  String get animationDescription => 'Eject triangle rises';

  @override
  List<Path> get paths => [
        Path()
          ..moveTo(4, 13)
          ..arcToPoint(const Offset(3.28, 11.305),
              radius: const Radius.circular(1))
          ..lineTo(10.537, 3.637)
          ..arcToPoint(const Offset(13.463, 3.637),
              radius: const Radius.circular(2))
          ..lineTo(20.719, 11.305)
          ..arcToPoint(const Offset(20, 13), radius: const Radius.circular(1))
          ..close(),
        Path()
          ..addRRect(RRect.fromRectAndRadius(
              const Rect.fromLTWH(3, 17, 18, 4), const Radius.circular(1))),
      ];

  @override
  void paintIcon(Canvas canvas, Paint paint, double animationValue) {
    canvas.save();
    canvas.translate(0, -iconPulse(animationValue) * 2);
    drawIconPaths(canvas, paint, [paths[0]]);
    canvas.restore();
    drawIconPaths(canvas, paint, [paths[1]]);
  }
}
