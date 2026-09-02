import 'package:flutter/material.dart';

import '../core/draw_icon_base.dart';

class GitMergeIcon extends DrawIconBase {
  const GitMergeIcon({
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
  String get animationDescription => 'Branches converge into the merge commit';

  @override
  List<Path> get paths => [
        Path()
          ..addOval(Rect.fromCircle(center: const Offset(18, 18), radius: 3)),
        Path()..addOval(Rect.fromCircle(center: const Offset(6, 6), radius: 3)),
        Path()
          ..moveTo(6, 21)
          ..lineTo(6, 9)
          ..arcToPoint(const Offset(15, 18),
              radius: const Radius.circular(9), clockwise: false),
      ];

  @override
  void paintIcon(Canvas canvas, Paint paint, double animationValue) {
    canvas.drawPath(paths[2], paint);
    final pulse = iconPulse(animationValue);
    canvas.save();
    canvas.translate(-pulse * .8, -pulse * .8);
    canvas.drawPath(paths[1], paint);
    canvas.restore();
    canvas.save();
    canvas.translate(18, 18);
    canvas.scale(1 + pulse * .2);
    canvas.translate(-18, -18);
    canvas.drawPath(paths[0], paint);
    canvas.restore();
  }
}
