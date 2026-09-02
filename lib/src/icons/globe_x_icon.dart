import 'package:flutter/material.dart';

import '../core/draw_icon_base.dart';

class GlobeXIcon extends DrawIconBase {
  const GlobeXIcon({
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
  String get animationDescription => 'Globe close mark shakes';

  @override
  List<Path> get paths => [
        Path()
          ..moveTo(16, 3)
          ..lineTo(21, 8),
        Path()
          ..moveTo(2, 12)
          ..lineTo(22, 12)
          ..arcToPoint(const Offset(12, 2),
              radius: const Radius.circular(10), largeArc: true)
          ..arcToPoint(const Offset(12, 22),
              radius: const Radius.circular(14.5), clockwise: false)
          ..arcToPoint(const Offset(16, 12),
              radius: const Radius.circular(14.5), clockwise: false),
        Path()
          ..moveTo(21, 3)
          ..lineTo(16, 8),
      ];

  @override
  void paintIcon(Canvas canvas, Paint paint, double animationValue) {
    canvas.drawPath(paths[1], paint);
    final pulse = iconPulse(animationValue);
    canvas.save();
    canvas.translate(18.5 + iconWave(animationValue) * .5, 5.5);
    canvas.scale(1 + pulse * .2);
    canvas.translate(-18.5, -5.5);
    drawIconPaths(canvas, paint, [paths[0], paths[2]]);
    canvas.restore();
  }
}
