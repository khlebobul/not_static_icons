import 'package:flutter/material.dart';

import '../core/draw_icon_base.dart';

class ForkliftIcon extends DrawIconBase {
  const ForkliftIcon({
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
  List<Path> get paths => [
        Path()
          ..moveTo(12, 12)
          ..lineTo(5, 12)
          ..arcToPoint(
            const Offset(3, 14),
            radius: const Radius.circular(2),
            clockwise: false,
          )
          ..lineTo(3, 19),
        Path()
          ..moveTo(15, 19)
          ..lineTo(22, 19),
        Path()
          ..moveTo(16, 19)
          ..lineTo(16, 2),
        Path()
          ..moveTo(6, 12)
          ..lineTo(6, 7)
          ..arcToPoint(const Offset(8, 5), radius: const Radius.circular(2))
          ..lineTo(10.172, 5)
          ..arcToPoint(
            const Offset(11.586, 5.586),
            radius: const Radius.circular(2),
          )
          ..lineTo(15.414, 9.414)
          ..arcToPoint(
            const Offset(16, 10.828),
            radius: const Radius.circular(2),
          ),
        Path()
          ..moveTo(7, 19)
          ..lineTo(11, 19),
        Path()
          ..addOval(Rect.fromCircle(center: const Offset(13, 19), radius: 2)),
        Path()
          ..addOval(Rect.fromCircle(center: const Offset(5, 19), radius: 2)),
      ];

  @override
  void paintIcon(Canvas canvas, Paint paint, double animationValue) {
    final lift = iconPulse(animationValue);
    drawIconPaths(canvas, paint, [paths[2]]);
    canvas.save();
    canvas.translate(0, -lift * .5);
    drawIconPaths(canvas, paint, [
      paths[0],
      paths[3],
      paths[4],
      paths[5],
      paths[6],
    ]);
    canvas.restore();
    canvas.save();
    canvas.translate(0, -lift * 3);
    drawIconPaths(canvas, paint, [paths[1]]);
    canvas.restore();
  }
}
