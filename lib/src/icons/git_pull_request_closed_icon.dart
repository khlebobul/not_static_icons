import 'package:flutter/material.dart';

import '../core/draw_icon_base.dart';

class GitPullRequestClosedIcon extends DrawIconBase {
  const GitPullRequestClosedIcon({
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
  String get animationDescription => 'Closed pull request mark reacts';

  @override
  List<Path> get paths => [
        Path()
          ..moveTo(15.5, 3.5)
          ..lineTo(20.5, 8.5),
        Path()
          ..moveTo(15.5, 8.5)
          ..lineTo(20.5, 3.5),
        Path()
          ..moveTo(18, 11.62)
          ..lineTo(18, 15),
        Path()
          ..moveTo(6, 9)
          ..lineTo(6, 21),
        Path()
          ..addOval(Rect.fromCircle(center: const Offset(18, 18), radius: 3)),
        Path()..addOval(Rect.fromCircle(center: const Offset(6, 6), radius: 3)),
      ];

  @override
  void paintIcon(Canvas canvas, Paint paint, double animationValue) {
    drawIconPaths(canvas, paint, paths.skip(2));
    canvas.save();
    canvas.translate(18, 6);
    canvas.rotate(iconWave(animationValue) * .18);
    canvas.scale(1 + iconPulse(animationValue) * .15);
    canvas.translate(-18, -6);
    drawIconPaths(canvas, paint, paths.take(2));
    canvas.restore();
  }
}
