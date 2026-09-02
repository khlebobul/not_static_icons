import 'package:flutter/material.dart';

import '../core/draw_icon_base.dart';

class GhostIcon extends DrawIconBase {
  const GhostIcon({
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
  String get animationDescription => 'Ghost floats and blinks';

  @override
  List<Path> get paths => [
        Path()
          ..moveTo(15, 10)
          ..lineTo(15, 11),
        Path()
          ..moveTo(7.528, 20.472)
          ..arcToPoint(const Offset(9.805, 20.472),
              radius: const Radius.circular(1.6))
          ..lineTo(10.862, 21.528)
          ..arcToPoint(const Offset(13.138, 21.528),
              radius: const Radius.circular(1.6), clockwise: false)
          ..lineTo(14.195, 20.472)
          ..arcToPoint(const Offset(16.472, 20.472),
              radius: const Radius.circular(1.6))
          ..lineTo(17.586, 21.586)
          ..arcToPoint(const Offset(20, 20.586),
              radius: const Radius.circular(1.4), clockwise: false)
          ..lineTo(20, 10)
          ..arcToPoint(const Offset(4, 10),
              radius: const Radius.circular(8), clockwise: false)
          ..lineTo(4, 20.586)
          ..arcToPoint(const Offset(6.414, 21.586),
              radius: const Radius.circular(1.4), clockwise: false)
          ..close(),
        Path()
          ..moveTo(9, 10)
          ..lineTo(9, 11),
      ];

  @override
  void paintIcon(Canvas canvas, Paint paint, double animationValue) {
    final lift = iconPulse(animationValue);
    canvas.save();
    canvas.translate(0, -lift);
    canvas.drawPath(paths[1], paint);
    canvas.save();
    canvas.translate(0, 10.5);
    canvas.scale(1, 1 - lift * .75);
    canvas.translate(0, -10.5);
    drawIconPaths(canvas, paint, [paths[0], paths[2]]);
    canvas.restore();
    canvas.restore();
  }
}
