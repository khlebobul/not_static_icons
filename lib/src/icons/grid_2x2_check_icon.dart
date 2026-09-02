import 'package:flutter/material.dart';

import '../core/draw_icon_base.dart';

class Grid2x2CheckIcon extends DrawIconBase {
  const Grid2x2CheckIcon({
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
  String get animationDescription => 'Grid check pops into place';

  @override
  List<Path> get paths => [
        Path()
          ..moveTo(12, 3)
          ..lineTo(12, 20)
          ..arcToPoint(const Offset(11, 21), radius: const Radius.circular(1))
          ..lineTo(5, 21)
          ..arcToPoint(const Offset(3, 19), radius: const Radius.circular(2))
          ..lineTo(3, 5)
          ..arcToPoint(const Offset(5, 3), radius: const Radius.circular(2))
          ..lineTo(19, 3)
          ..arcToPoint(const Offset(21, 5), radius: const Radius.circular(2))
          ..lineTo(21, 11)
          ..arcToPoint(const Offset(20, 12), radius: const Radius.circular(1))
          ..lineTo(3, 12),
        Path()
          ..moveTo(16, 19)
          ..lineTo(18, 21)
          ..lineTo(22, 17),
      ];

  @override
  void paintIcon(Canvas canvas, Paint paint, double animationValue) {
    canvas.drawPath(paths[0], paint);
    final pulse = iconPulse(animationValue);
    canvas.save();
    canvas.translate(19, 19);
    canvas.scale(1 + pulse * .25);
    canvas.translate(-19, -19 - pulse * .5);
    canvas.drawPath(paths[1], paint);
    canvas.restore();
  }
}
