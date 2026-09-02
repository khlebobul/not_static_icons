import 'package:flutter/material.dart';

import '../core/draw_icon_base.dart';

class GripVerticalIcon extends DrawIconBase {
  const GripVerticalIcon({
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
  String get animationDescription => 'Vertical grip dots ripple horizontally';

  @override
  List<Path> get paths => [
        Path()
          ..addOval(Rect.fromCircle(center: const Offset(9, 12), radius: 1)),
        Path()..addOval(Rect.fromCircle(center: const Offset(9, 5), radius: 1)),
        Path()
          ..addOval(Rect.fromCircle(center: const Offset(9, 19), radius: 1)),
        Path()
          ..addOval(Rect.fromCircle(center: const Offset(15, 12), radius: 1)),
        Path()
          ..addOval(Rect.fromCircle(center: const Offset(15, 5), radius: 1)),
        Path()
          ..addOval(Rect.fromCircle(center: const Offset(15, 19), radius: 1)),
      ];

  @override
  void paintIcon(Canvas canvas, Paint paint, double animationValue) {
    final wave = iconWave(animationValue);
    final dotPaint = Paint()..color = paint.color;
    for (var i = 0; i < paths.length; i++) {
      canvas.save();
      canvas.translate(wave * ((i % 3) - 1) * .7, 0);
      canvas.drawPath(paths[i], dotPaint);
      canvas.restore();
    }
  }
}
