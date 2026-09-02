import 'package:flutter/material.dart';

import '../core/draw_icon_base.dart';

class GitBranchPlusIcon extends DrawIconBase {
  const GitBranchPlusIcon({
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
  String get animationDescription => 'Branch addition pulses';

  @override
  List<Path> get paths => [
        Path()
          ..moveTo(6, 3)
          ..lineTo(6, 15),
        Path()
          ..moveTo(18, 9)
          ..arcToPoint(const Offset(18, 3),
              radius: const Radius.circular(3),
              largeArc: true,
              clockwise: false)
          ..arcToPoint(const Offset(18, 9),
              radius: const Radius.circular(3), clockwise: false)
          ..close(),
        Path()
          ..moveTo(6, 21)
          ..arcToPoint(const Offset(6, 15),
              radius: const Radius.circular(3),
              largeArc: true,
              clockwise: false)
          ..arcToPoint(const Offset(6, 21),
              radius: const Radius.circular(3), clockwise: false)
          ..close(),
        Path()
          ..moveTo(15, 6)
          ..arcToPoint(const Offset(6, 15),
              radius: const Radius.circular(9), clockwise: false),
        Path()
          ..moveTo(18, 15)
          ..lineTo(18, 21),
        Path()
          ..moveTo(21, 18)
          ..lineTo(15, 18),
      ];

  @override
  void paintIcon(Canvas canvas, Paint paint, double animationValue) {
    drawIconPaths(canvas, paint, paths.take(4));
    final pulse = iconPulse(animationValue);
    canvas.save();
    canvas.translate(18, 18);
    canvas.scale(1 + pulse * .3);
    canvas.translate(-18, -18);
    drawIconPaths(canvas, paint, paths.skip(4));
    canvas.restore();
  }
}
