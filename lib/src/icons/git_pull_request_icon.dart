import 'package:flutter/material.dart';

import '../core/draw_icon_base.dart';

class GitPullRequestIcon extends DrawIconBase {
  const GitPullRequestIcon({
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
  String get animationDescription => 'Pull request commits pulse';

  @override
  List<Path> get paths => [
        Path()
          ..addOval(Rect.fromCircle(center: const Offset(18, 18), radius: 3)),
        Path()..addOval(Rect.fromCircle(center: const Offset(6, 6), radius: 3)),
        Path()
          ..moveTo(13, 6)
          ..lineTo(16, 6)
          ..arcToPoint(const Offset(18, 8), radius: const Radius.circular(2))
          ..lineTo(18, 15),
        Path()
          ..moveTo(6, 9)
          ..lineTo(6, 21),
      ];

  @override
  void paintIcon(Canvas canvas, Paint paint, double animationValue) {
    drawIconPaths(canvas, paint, [paths[2], paths[3]]);
    final pulse = iconPulse(animationValue);
    for (final entry in [
      (paths[0], const Offset(18, 18)),
      (paths[1], const Offset(6, 6))
    ]) {
      canvas.save();
      canvas.translate(entry.$2.dx, entry.$2.dy);
      canvas.scale(1 + pulse * .2);
      canvas.translate(-entry.$2.dx, -entry.$2.dy);
      canvas.drawPath(entry.$1, paint);
      canvas.restore();
    }
  }
}
