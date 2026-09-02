import 'package:flutter/material.dart';

import '../core/draw_icon_base.dart';

class GlobeIcon extends DrawIconBase {
  const GlobeIcon({
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
  String get animationDescription => 'Globe meridian travels sideways';

  @override
  List<Path> get paths => [
        Path()
          ..addOval(Rect.fromCircle(center: const Offset(12, 12), radius: 10)),
        Path()
          ..moveTo(12, 2)
          ..arcToPoint(const Offset(12, 22),
              radius: const Radius.circular(14.5), clockwise: false)
          ..arcToPoint(const Offset(12, 2),
              radius: const Radius.circular(14.5), clockwise: false),
        Path()
          ..moveTo(2, 12)
          ..lineTo(22, 12),
      ];

  @override
  void paintIcon(Canvas canvas, Paint paint, double animationValue) {
    drawIconPaths(canvas, paint, [paths[0], paths[2]]);
    canvas.save();
    canvas.translate(iconWave(animationValue) * .9, 0);
    canvas.drawPath(paths[1], paint);
    canvas.restore();
  }
}
