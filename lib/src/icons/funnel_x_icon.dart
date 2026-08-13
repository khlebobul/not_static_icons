import 'package:flutter/material.dart';

import '../core/draw_icon_base.dart';

class FunnelXIcon extends DrawIconBase {
  const FunnelXIcon({
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
  List<Path> get paths => [
        Path()
          ..moveTo(12.531, 3)
          ..lineTo(3, 3)
          ..arcToPoint(
            const Offset(2.258, 4.67),
            radius: const Radius.circular(1),
            clockwise: false,
          )
          ..lineTo(9.483, 12.659)
          ..arcToPoint(const Offset(10, 14), radius: const Radius.circular(2))
          ..lineTo(10, 20)
          ..arcToPoint(
            const Offset(10.553, 20.895),
            radius: const Radius.circular(1),
            clockwise: false,
          )
          ..lineTo(12.553, 21.895)
          ..arcToPoint(
            const Offset(14, 21),
            radius: const Radius.circular(1),
            clockwise: false,
          )
          ..lineTo(14, 14)
          ..arcToPoint(
            const Offset(14.517, 12.659),
            radius: const Radius.circular(2),
          )
          ..lineTo(14.944, 12.186),
        Path()
          ..moveTo(16.5, 3.5)
          ..lineTo(21.5, 8.5),
        Path()
          ..moveTo(21.5, 3.5)
          ..lineTo(16.5, 8.5),
      ];

  @override
  void paintIcon(Canvas canvas, Paint paint, double animationValue) {
    drawIconPaths(canvas, paint, [paths[0]]);
    canvas.save();
    final pulse = iconPulse(animationValue);
    canvas.translate(19 + iconWave(animationValue) * 1.2, 6);
    canvas.scale(1 + pulse * .15);
    canvas.translate(-19, -6);
    drawIconPaths(canvas, paint, [paths[1], paths[2]]);
    canvas.restore();
  }
}
