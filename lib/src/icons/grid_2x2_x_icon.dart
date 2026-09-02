import 'package:flutter/material.dart';

import '../core/draw_icon_base.dart';

class Grid2x2XIcon extends DrawIconBase {
  const Grid2x2XIcon({
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
  String get animationDescription => 'Grid close mark twists';

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
          ..moveTo(16.5, 16.5)
          ..lineTo(21.5, 21.5),
        Path()
          ..moveTo(16.5, 21.5)
          ..lineTo(21.5, 16.5),
      ];

  @override
  void paintIcon(Canvas canvas, Paint paint, double animationValue) {
    canvas.drawPath(paths[0], paint);
    canvas.save();
    canvas.translate(19, 19);
    canvas.rotate(iconWave(animationValue) * .18);
    canvas.scale(1 + iconPulse(animationValue) * .18);
    canvas.translate(-19, -19);
    drawIconPaths(canvas, paint, paths.skip(1));
    canvas.restore();
  }
}
