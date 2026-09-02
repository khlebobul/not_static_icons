import 'package:flutter/material.dart';

import '../core/draw_icon_base.dart';

class GripHorizontalIcon extends DrawIconBase {
  const GripHorizontalIcon({
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
  String get animationDescription => 'Horizontal grip dots ripple vertically';

  @override
  List<Path> get paths => [
        Path()
          ..addOval(Rect.fromCircle(center: const Offset(12, 9), radius: 1)),
        Path()
          ..addOval(Rect.fromCircle(center: const Offset(19, 9), radius: 1)),
        Path()..addOval(Rect.fromCircle(center: const Offset(5, 9), radius: 1)),
        Path()
          ..addOval(Rect.fromCircle(center: const Offset(12, 15), radius: 1)),
        Path()
          ..addOval(Rect.fromCircle(center: const Offset(19, 15), radius: 1)),
        Path()
          ..addOval(Rect.fromCircle(center: const Offset(5, 15), radius: 1)),
      ];

  @override
  void paintIcon(Canvas canvas, Paint paint, double animationValue) {
    final wave = iconWave(animationValue);
    final dotPaint = Paint()..color = paint.color;
    for (var i = 0; i < paths.length; i++) {
      canvas.save();
      canvas.translate(0, wave * ((i % 3) - 1) * .7);
      canvas.drawPath(paths[i], dotPaint);
      canvas.restore();
    }
  }
}
