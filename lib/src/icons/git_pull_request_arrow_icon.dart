import 'package:flutter/material.dart';

import '../core/draw_icon_base.dart';

class GitPullRequestArrowIcon extends DrawIconBase {
  const GitPullRequestArrowIcon({
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
  String get animationDescription => 'Pull request arrow points back';

  @override
  List<Path> get paths => [
        Path()..addOval(Rect.fromCircle(center: const Offset(5, 6), radius: 3)),
        Path()
          ..moveTo(5, 9)
          ..lineTo(5, 21),
        Path()
          ..addOval(Rect.fromCircle(center: const Offset(19, 18), radius: 3)),
        Path()
          ..moveTo(15, 9)
          ..lineTo(12, 6)
          ..lineTo(15, 3),
        Path()
          ..moveTo(12, 6)
          ..lineTo(17, 6)
          ..arcToPoint(const Offset(19, 8), radius: const Radius.circular(2))
          ..lineTo(19, 15),
      ];

  @override
  void paintIcon(Canvas canvas, Paint paint, double animationValue) {
    drawIconPaths(canvas, paint, [paths[0], paths[1], paths[2], paths[4]]);
    canvas.save();
    canvas.translate(-iconWave(animationValue), 0);
    canvas.drawPath(paths[3], paint);
    canvas.restore();
  }
}
