import 'package:flutter/material.dart';

import '../core/draw_icon_base.dart';

class GitBranchMinusIcon extends DrawIconBase {
  const GitBranchMinusIcon({
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
  String get animationDescription => 'Minus leaves the branch';

  @override
  List<Path> get paths => [
        Path()
          ..moveTo(15, 6)
          ..arcToPoint(const Offset(6, 15),
              radius: const Radius.circular(9), clockwise: false)
          ..lineTo(6, 3),
        Path()
          ..moveTo(21, 18)
          ..lineTo(15, 18),
        Path()
          ..addOval(Rect.fromCircle(center: const Offset(18, 6), radius: 3)),
        Path()
          ..addOval(Rect.fromCircle(center: const Offset(6, 18), radius: 3)),
      ];

  @override
  void paintIcon(Canvas canvas, Paint paint, double animationValue) {
    drawIconPaths(canvas, paint, [paths[0], paths[2], paths[3]]);
    canvas.save();
    canvas.translate(iconPulse(animationValue) * 2, 0);
    canvas.drawPath(paths[1], paint);
    canvas.restore();
  }
}
