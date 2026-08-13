import 'package:flutter/material.dart';

import '../core/draw_icon_base.dart';

class FunnelPlusIcon extends DrawIconBase {
  const FunnelPlusIcon({
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
          ..moveTo(13.354, 3)
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
          ..lineTo(15.735, 11.311),
        Path()
          ..moveTo(16, 6)
          ..lineTo(22, 6),
        Path()
          ..moveTo(19, 3)
          ..lineTo(19, 9),
      ];

  @override
  void paintIcon(Canvas canvas, Paint paint, double animationValue) {
    drawIconPaths(canvas, paint, [paths[0]]);
    final pulse = iconPulse(animationValue);
    canvas.save();
    canvas.translate(19, 6);
    canvas.rotate(pulse * 1.5708);
    canvas.scale(1 + pulse * .12);
    canvas.translate(-19, -6);
    drawIconPaths(canvas, paint, [paths[1], paths[2]]);
    canvas.restore();
  }
}
