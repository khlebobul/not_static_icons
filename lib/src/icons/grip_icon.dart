import 'package:flutter/material.dart';

import '../core/draw_icon_base.dart';

class GripIcon extends DrawIconBase {
  const GripIcon({
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
  String get animationDescription => 'Grip dots expand from the center';

  @override
  List<Path> get paths => [
        Path()
          ..addOval(Rect.fromCircle(center: const Offset(12, 5), radius: 1)),
        Path()
          ..addOval(Rect.fromCircle(center: const Offset(19, 5), radius: 1)),
        Path()..addOval(Rect.fromCircle(center: const Offset(5, 5), radius: 1)),
        Path()
          ..addOval(Rect.fromCircle(center: const Offset(12, 12), radius: 1)),
        Path()
          ..addOval(Rect.fromCircle(center: const Offset(19, 12), radius: 1)),
        Path()
          ..addOval(Rect.fromCircle(center: const Offset(5, 12), radius: 1)),
        Path()
          ..addOval(Rect.fromCircle(center: const Offset(12, 19), radius: 1)),
        Path()
          ..addOval(Rect.fromCircle(center: const Offset(19, 19), radius: 1)),
        Path()
          ..addOval(Rect.fromCircle(center: const Offset(5, 19), radius: 1)),
      ];

  @override
  void paintIcon(Canvas canvas, Paint paint, double animationValue) {
    final pulse = iconPulse(animationValue);
    final dotPaint = Paint()..color = paint.color;
    for (var i = 0; i < paths.length; i++) {
      final center = paths[i].getBounds().center;
      final distance = (center - const Offset(12, 12)) * (pulse * .08);
      canvas.save();
      canvas.translate(center.dx + distance.dx, center.dy + distance.dy);
      canvas.scale(1 + pulse * (i == 3 ? .35 : .12));
      canvas.translate(-center.dx, -center.dy);
      canvas.drawPath(paths[i], dotPaint);
      canvas.restore();
    }
  }
}
