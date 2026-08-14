import 'package:flutter/material.dart';

import '../core/draw_icon_base.dart';

class FaceExpressionlessIcon extends DrawIconBase {
  const FaceExpressionlessIcon({
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
  String get animationDescription => 'Expressionless eyes glance sideways';

  @override
  List<Path> get paths => [
        Path()
          ..moveTo(14, 10)
          ..lineTo(16, 10),
        Path()
          ..moveTo(8, 10)
          ..lineTo(10, 10),
        Path()
          ..moveTo(8, 16)
          ..lineTo(16, 16),
        Path()
          ..addOval(Rect.fromCircle(center: const Offset(12, 12), radius: 10)),
      ];

  @override
  void paintIcon(Canvas canvas, Paint paint, double animationValue) {
    drawIconPaths(canvas, paint, paths.skip(2));
    canvas.save();
    canvas.translate(iconWave(animationValue) * .6, 0);
    drawIconPaths(canvas, paint, paths.take(2));
    canvas.restore();
  }
}
