import 'package:flutter/material.dart';

import '../core/draw_icon_base.dart';

class GlobeCheckIcon extends DrawIconBase {
  const GlobeCheckIcon({
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
  String get animationDescription => 'Globe check pops into place';

  @override
  List<Path> get paths => [
        Path()
          ..moveTo(15, 6)
          ..lineTo(17, 8)
          ..lineTo(21, 4),
        Path()
          ..moveTo(2, 12)
          ..lineTo(22, 12)
          ..arcToPoint(const Offset(12, 2),
              radius: const Radius.circular(10), largeArc: true)
          ..arcToPoint(const Offset(12, 22),
              radius: const Radius.circular(14.5), clockwise: false)
          ..arcToPoint(const Offset(16, 12),
              radius: const Radius.circular(14.5), clockwise: false),
      ];

  @override
  void paintIcon(Canvas canvas, Paint paint, double animationValue) {
    canvas.drawPath(paths[1], paint);
    final pulse = iconPulse(animationValue);
    canvas.save();
    canvas.translate(18, 6);
    canvas.scale(1 + pulse * .25);
    canvas.translate(-18, -6 - pulse * .5);
    canvas.drawPath(paths[0], paint);
    canvas.restore();
  }
}
