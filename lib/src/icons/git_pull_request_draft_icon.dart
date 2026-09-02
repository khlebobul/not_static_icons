import 'package:flutter/material.dart';

import '../core/draw_icon_base.dart';

class GitPullRequestDraftIcon extends DrawIconBase {
  const GitPullRequestDraftIcon({
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
  String get animationDescription => 'Draft segments alternate';

  @override
  List<Path> get paths => [
        Path()
          ..addOval(Rect.fromCircle(center: const Offset(18, 18), radius: 3)),
        Path()..addOval(Rect.fromCircle(center: const Offset(6, 6), radius: 3)),
        Path()
          ..moveTo(18, 6)
          ..lineTo(18, 5),
        Path()
          ..moveTo(18, 11)
          ..lineTo(18, 10),
        Path()
          ..moveTo(6, 9)
          ..lineTo(6, 21),
      ];

  @override
  void paintIcon(Canvas canvas, Paint paint, double animationValue) {
    drawIconPaths(canvas, paint, [paths[0], paths[1], paths[4]]);
    final wave = iconWave(animationValue);
    canvas.save();
    canvas.translate(0, wave * .8);
    canvas.drawPath(paths[2], paint);
    canvas.translate(0, -wave * 1.6);
    canvas.drawPath(paths[3], paint);
    canvas.restore();
  }
}
