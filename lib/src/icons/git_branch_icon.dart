import 'package:flutter/material.dart';

import '../core/draw_icon_base.dart';

class GitBranchIcon extends DrawIconBase {
  const GitBranchIcon({
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
  String get animationDescription => 'Branch nodes grow and shift';

  @override
  List<Path> get paths => [
        Path()
          ..moveTo(15, 6)
          ..arcToPoint(const Offset(6, 15),
              radius: const Radius.circular(9), clockwise: false)
          ..lineTo(6, 3),
        Path()
          ..addOval(Rect.fromCircle(center: const Offset(18, 6), radius: 3)),
        Path()
          ..addOval(Rect.fromCircle(center: const Offset(6, 18), radius: 3)),
      ];

  @override
  void paintIcon(Canvas canvas, Paint paint, double animationValue) {
    canvas.drawPath(paths[0], paint);
    final pulse = iconPulse(animationValue);
    for (final entry in [
      (paths[1], const Offset(18, 6), 1.0),
      (paths[2], const Offset(6, 18), -1.0)
    ]) {
      canvas.save();
      canvas.translate(entry.$2.dx, entry.$2.dy);
      canvas.scale(1 + pulse * .18);
      canvas.translate(-entry.$2.dx, -entry.$2.dy + pulse * entry.$3 * .6);
      canvas.drawPath(entry.$1, paint);
      canvas.restore();
    }
  }
}
