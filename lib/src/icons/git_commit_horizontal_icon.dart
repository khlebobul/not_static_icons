import 'package:flutter/material.dart';

import '../core/draw_icon_base.dart';

class GitCommitHorizontalIcon extends DrawIconBase {
  const GitCommitHorizontalIcon({
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
  String get animationDescription => 'Commit lands between horizontal rails';

  @override
  List<Path> get paths => [
        Path()
          ..addOval(Rect.fromCircle(center: const Offset(12, 12), radius: 3)),
        Path()
          ..moveTo(3, 12)
          ..lineTo(9, 12),
        Path()
          ..moveTo(15, 12)
          ..lineTo(21, 12),
      ];

  @override
  void paintIcon(Canvas canvas, Paint paint, double animationValue) {
    final pulse = iconPulse(animationValue);
    canvas.save();
    canvas.translate(-pulse, 0);
    canvas.drawPath(paths[1], paint);
    canvas.restore();
    canvas.save();
    canvas.translate(pulse, 0);
    canvas.drawPath(paths[2], paint);
    canvas.restore();
    canvas.save();
    canvas.translate(12, 12);
    canvas.scale(1 + pulse * .2);
    canvas.translate(-12, -12);
    canvas.drawPath(paths[0], paint);
    canvas.restore();
  }
}
