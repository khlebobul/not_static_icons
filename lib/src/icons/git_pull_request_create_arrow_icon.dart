import 'package:flutter/material.dart';

import '../core/draw_icon_base.dart';

class GitPullRequestCreateArrowIcon extends DrawIconBase {
  const GitPullRequestCreateArrowIcon({
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
  String get animationDescription => 'Create arrow moves as plus grows';

  @override
  List<Path> get paths => [
        Path()..addOval(Rect.fromCircle(center: const Offset(5, 6), radius: 3)),
        Path()
          ..moveTo(5, 9)
          ..lineTo(5, 21),
        Path()
          ..moveTo(15, 9)
          ..lineTo(12, 6)
          ..lineTo(15, 3),
        Path()
          ..moveTo(12, 6)
          ..lineTo(17, 6)
          ..arcToPoint(const Offset(19, 8), radius: const Radius.circular(2))
          ..lineTo(19, 11),
        Path()
          ..moveTo(19, 15)
          ..lineTo(19, 21),
        Path()
          ..moveTo(22, 18)
          ..lineTo(16, 18),
      ];

  @override
  void paintIcon(Canvas canvas, Paint paint, double animationValue) {
    drawIconPaths(canvas, paint, [paths[0], paths[1], paths[3]]);
    final pulse = iconPulse(animationValue);
    canvas.save();
    canvas.translate(-iconWave(animationValue), 0);
    canvas.drawPath(paths[2], paint);
    canvas.restore();
    canvas.save();
    canvas.translate(19, 18);
    canvas.scale(1 + pulse * .25);
    canvas.translate(-19, -18);
    drawIconPaths(canvas, paint, paths.skip(4));
    canvas.restore();
  }
}
