import 'package:flutter/material.dart';

import '../core/draw_icon_base.dart';

class FunnelIcon extends DrawIconBase {
  const FunnelIcon({
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
  List<Path> get paths => [_funnelPath(21.74)];

  @override
  void paintIcon(Canvas canvas, Paint paint, double animationValue) {
    final filter = iconPulse(animationValue);
    canvas.save();
    canvas.translate(12, 0);
    canvas.scale(1 - filter * .1, 1);
    canvas.translate(-12, 0);
    drawIconPaths(canvas, paint, paths);
    canvas.restore();
  }
}

Path _funnelPath(double topRight) => Path()
  ..moveTo(10, 20)
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
  ..lineTo(topRight, 4.67)
  ..arcToPoint(
    const Offset(21, 3),
    radius: const Radius.circular(1),
    clockwise: false,
  )
  ..lineTo(3, 3)
  ..arcToPoint(
    const Offset(2.258, 4.67),
    radius: const Radius.circular(1),
    clockwise: false,
  )
  ..lineTo(9.483, 12.659)
  ..arcToPoint(const Offset(10, 14), radius: const Radius.circular(2))
  ..close();
