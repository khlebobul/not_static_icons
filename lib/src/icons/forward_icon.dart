import 'package:flutter/material.dart';

import '../core/draw_icon_base.dart';

class ForwardIcon extends DrawIconBase {
  const ForwardIcon({
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
          ..moveTo(15, 17)
          ..lineTo(20, 12)
          ..lineTo(15, 7),
        Path()
          ..moveTo(4, 18)
          ..lineTo(4, 16)
          ..arcToPoint(const Offset(8, 12), radius: const Radius.circular(4))
          ..lineTo(20, 12),
      ];

  @override
  void paintIcon(Canvas canvas, Paint paint, double animationValue) {
    final forward = iconPulse(animationValue);
    canvas.save();
    canvas.translate(forward * .8, 0);
    drawIconPaths(canvas, paint, [paths[1]]);
    canvas.restore();
    canvas.save();
    canvas.translate(forward * 2.5, 0);
    drawIconPaths(canvas, paint, [paths[0]]);
    canvas.restore();
  }
}
