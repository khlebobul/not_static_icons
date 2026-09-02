import 'package:flutter/material.dart';

import '../core/draw_icon_base.dart';

class GpuIcon extends DrawIconBase {
  const GpuIcon({
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
  String get animationDescription => 'GPU cores pulse independently';

  @override
  List<Path> get paths => [
        Path()
          ..moveTo(2, 17)
          ..lineTo(20, 17)
          ..arcToPoint(const Offset(22, 15),
              radius: const Radius.circular(2), clockwise: false)
          ..lineTo(22, 7)
          ..arcToPoint(const Offset(20, 5),
              radius: const Radius.circular(2), clockwise: false)
          ..lineTo(2, 5),
        Path()
          ..moveTo(2, 21)
          ..lineTo(2, 3),
        Path()
          ..moveTo(7, 17)
          ..lineTo(7, 20)
          ..arcToPoint(const Offset(8, 21),
              radius: const Radius.circular(1), clockwise: false)
          ..lineTo(13, 21)
          ..arcToPoint(const Offset(14, 20),
              radius: const Radius.circular(1), clockwise: false)
          ..lineTo(14, 17),
        Path()
          ..addOval(Rect.fromCircle(center: const Offset(16, 11), radius: 2)),
        Path()
          ..addOval(Rect.fromCircle(center: const Offset(8, 11), radius: 2)),
      ];

  @override
  void paintIcon(Canvas canvas, Paint paint, double animationValue) {
    drawIconPaths(canvas, paint, paths.take(3));
    final pulse = iconPulse(animationValue);
    for (final entry in [
      (paths[3], const Offset(16, 11), 1.0),
      (paths[4], const Offset(8, 11), -.7)
    ]) {
      canvas.save();
      canvas.translate(entry.$2.dx, entry.$2.dy);
      canvas.scale(1 + pulse * .2 * entry.$3.abs());
      canvas.translate(-entry.$2.dx, -entry.$2.dy + pulse * entry.$3 * .4);
      canvas.drawPath(entry.$1, paint);
      canvas.restore();
    }
  }
}
