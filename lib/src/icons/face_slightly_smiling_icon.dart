import 'package:flutter/material.dart';

import '../core/draw_icon_base.dart';

class FaceSlightlySmilingIcon extends DrawIconBase {
  const FaceSlightlySmilingIcon({
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
  String get animationDescription => 'Smile lifts';

  @override
  List<Path> get paths => [
        Path()
          ..moveTo(15, 10)
          ..lineTo(15, 9),
        Path()
          ..moveTo(16.472, 15)
          ..arcToPoint(const Offset(7.529, 15),
              radius: const Radius.circular(6)),
        Path()
          ..moveTo(9, 10)
          ..lineTo(9, 9),
        Path()
          ..addOval(Rect.fromCircle(center: const Offset(12, 12), radius: 10)),
      ];

  @override
  void paintIcon(Canvas canvas, Paint paint, double animationValue) {
    drawIconPaths(canvas, paint, [paths[0], paths[2], paths[3]]);
    canvas.save();
    canvas.translate(0, -iconPulse(animationValue) * .7);
    drawIconPaths(canvas, paint, [paths[1]]);
    canvas.restore();
  }
}
