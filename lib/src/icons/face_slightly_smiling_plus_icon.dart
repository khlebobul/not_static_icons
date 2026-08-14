import 'package:flutter/material.dart';

import '../core/draw_icon_base.dart';

class FaceSlightlySmilingPlusIcon extends DrawIconBase {
  const FaceSlightlySmilingPlusIcon({
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
  String get animationDescription => 'Smile lifts while plus pulses';

  @override
  List<Path> get paths => [
        Path()
          ..moveTo(13.267, 2.08)
          ..arcToPoint(const Offset(21.92, 10.733),
              radius: const Radius.circular(10),
              largeArc: true,
              clockwise: false),
        Path()
          ..moveTo(15, 10)
          ..lineTo(15, 9),
        Path()
          ..moveTo(16, 5)
          ..lineTo(22, 5),
        Path()
          ..moveTo(16.472, 15)
          ..arcToPoint(const Offset(7.529, 15),
              radius: const Radius.circular(6)),
        Path()
          ..moveTo(19, 2)
          ..lineTo(19, 8),
        Path()
          ..moveTo(9, 10)
          ..lineTo(9, 9),
      ];

  @override
  void paintIcon(Canvas canvas, Paint paint, double animationValue) {
    drawIconPaths(canvas, paint, [paths[0], paths[1], paths[5]]);
    canvas.save();
    canvas.translate(0, -iconPulse(animationValue) * .7);
    drawIconPaths(canvas, paint, [paths[3]]);
    canvas.restore();
    final pulse = 1 + iconPulse(animationValue) * .18;
    canvas.save();
    canvas.translate(19, 5);
    canvas.scale(pulse);
    canvas.translate(-19, -5);
    drawIconPaths(canvas, paint, [paths[2], paths[4]]);
    canvas.restore();
  }
}
