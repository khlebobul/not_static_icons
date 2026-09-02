import 'package:flutter/material.dart';

import '../core/draw_icon_base.dart';

class GitPullRequestCreateIcon extends DrawIconBase {
  const GitPullRequestCreateIcon({
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
  String get animationDescription => 'Create marker grows';

  @override
  List<Path> get paths => [
        Path()..addOval(Rect.fromCircle(center: const Offset(6, 6), radius: 3)),
        Path()
          ..moveTo(6, 9)
          ..lineTo(6, 21),
        Path()
          ..moveTo(13, 6)
          ..lineTo(16, 6)
          ..arcToPoint(const Offset(18, 8), radius: const Radius.circular(2))
          ..lineTo(18, 11),
        Path()
          ..moveTo(18, 15)
          ..lineTo(18, 21),
        Path()
          ..moveTo(21, 18)
          ..lineTo(15, 18),
      ];

  @override
  void paintIcon(Canvas canvas, Paint paint, double animationValue) {
    drawIconPaths(canvas, paint, paths.take(3));
    final pulse = iconPulse(animationValue);
    canvas.save();
    canvas.translate(18, 18);
    canvas.scale(1 + pulse * .3);
    canvas.translate(-18, -18);
    drawIconPaths(canvas, paint, paths.skip(3));
    canvas.restore();
  }
}
