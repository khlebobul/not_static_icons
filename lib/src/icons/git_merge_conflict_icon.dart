import 'package:flutter/material.dart';

import '../core/draw_icon_base.dart';

class GitMergeConflictIcon extends DrawIconBase {
  const GitMergeConflictIcon({
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
  String get animationDescription => 'Conflict mark shakes';

  @override
  List<Path> get paths => [
        Path()
          ..moveTo(12, 6)
          ..lineTo(16, 6)
          ..arcToPoint(const Offset(18, 8), radius: const Radius.circular(2))
          ..lineTo(18, 15),
        Path()
          ..moveTo(6, 12)
          ..lineTo(6, 21),
        Path()
          ..moveTo(8.5, 3.5)
          ..lineTo(3.5, 8.5),
        Path()
          ..moveTo(8.5, 8.5)
          ..lineTo(3.5, 3.5),
        Path()
          ..addOval(Rect.fromCircle(center: const Offset(18, 18), radius: 3)),
      ];

  @override
  void paintIcon(Canvas canvas, Paint paint, double animationValue) {
    drawIconPaths(canvas, paint, [paths[0], paths[1], paths[4]]);
    canvas.save();
    canvas.translate(iconWave(animationValue) * .8, 0);
    drawIconPaths(canvas, paint, [paths[2], paths[3]]);
    canvas.restore();
  }
}
