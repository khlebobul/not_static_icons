import 'package:flutter/material.dart';

import '../core/draw_icon_base.dart';

class FaceNeutralIcon extends DrawIconBase {
  const FaceNeutralIcon({
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
  String get animationDescription => 'Neutral face blinks';

  @override
  List<Path> get paths => [
        Path()
          ..moveTo(15, 10)
          ..lineTo(15, 9),
        Path()
          ..moveTo(8, 16)
          ..lineTo(16, 16),
        Path()
          ..moveTo(9, 10)
          ..lineTo(9, 9),
        Path()
          ..addOval(Rect.fromCircle(center: const Offset(12, 12), radius: 10)),
      ];

  @override
  void paintIcon(Canvas canvas, Paint paint, double animationValue) {
    drawIconPaths(canvas, paint, [paths[1], paths[3]]);
    canvas.save();
    canvas.translate(0, 10);
    canvas.scale(1, 1 - iconPulse(animationValue) * .75);
    canvas.translate(0, -10);
    drawIconPaths(canvas, paint, [paths[0], paths[2]]);
    canvas.restore();
  }
}
