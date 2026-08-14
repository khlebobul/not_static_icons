import 'package:flutter/material.dart';

import '../core/draw_icon_base.dart';

class CarBatteryIcon extends DrawIconBase {
  const CarBatteryIcon({
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
  String get animationDescription => 'Battery charge symbols pulse';

  @override
  List<Path> get paths => [
        Path()
          ..moveTo(14, 13)
          ..lineTo(18, 13),
        Path()
          ..moveTo(16, 15)
          ..lineTo(16, 11),
        Path()
          ..moveTo(18, 5)
          ..lineTo(18, 7),
        Path()
          ..moveTo(6, 13)
          ..lineTo(10, 13),
        Path()
          ..moveTo(6, 5)
          ..lineTo(6, 7),
        Path()
          ..addRRect(RRect.fromRectAndRadius(
              const Rect.fromLTWH(2, 7, 20, 12), const Radius.circular(2))),
      ];

  @override
  void paintIcon(Canvas canvas, Paint paint, double animationValue) {
    drawIconPaths(canvas, paint, paths.skip(2));
    final pulse = 1 + iconPulse(animationValue) * .2;
    canvas.save();
    canvas.translate(16, 13);
    canvas.scale(pulse);
    canvas.translate(-16, -13);
    drawIconPaths(canvas, paint, paths.take(2));
    canvas.restore();
  }
}
