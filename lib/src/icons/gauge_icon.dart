import 'package:flutter/material.dart';

import '../core/draw_icon_base.dart';

class GaugeIcon extends DrawIconBase {
  const GaugeIcon({
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
  String get animationDescription => 'Gauge needle sweeps';

  @override
  List<Path> get paths => [
        Path()
          ..moveTo(12, 14)
          ..lineTo(16, 10),
        Path()
          ..moveTo(3.34, 19)
          ..arcToPoint(const Offset(20.66, 19),
              radius: const Radius.circular(10), largeArc: true),
      ];

  @override
  void paintIcon(Canvas canvas, Paint paint, double animationValue) {
    drawIconPaths(canvas, paint, [paths[1]]);
    canvas.save();
    canvas.translate(12, 14);
    canvas.rotate(iconWave(animationValue) * .45);
    canvas.translate(-12, -14);
    canvas.drawPath(paths[0], paint);
    canvas.restore();
  }
}
