import 'package:flutter/material.dart';

import '../core/draw_icon_base.dart';

class GeorgianLariIcon extends DrawIconBase {
  const GeorgianLariIcon({
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
  String get animationDescription => 'Lari stems sway apart';

  @override
  List<Path> get paths => [
        Path()
          ..moveTo(11.5, 21)
          ..arcToPoint(const Offset(18.85, 12),
              radius: const Radius.circular(7.5), largeArc: true),
        Path()
          ..moveTo(13, 12)
          ..lineTo(13, 3),
        Path()
          ..moveTo(4, 21)
          ..lineTo(20, 21),
        Path()
          ..moveTo(9, 12)
          ..lineTo(9, 3),
      ];

  @override
  void paintIcon(Canvas canvas, Paint paint, double animationValue) {
    drawIconPaths(canvas, paint, [paths[0], paths[2]]);
    final wave = iconWave(animationValue);
    canvas.save();
    canvas.translate(wave * .6, 0);
    canvas.drawPath(paths[1], paint);
    canvas.restore();
    canvas.save();
    canvas.translate(-wave * .6, 0);
    canvas.drawPath(paths[3], paint);
    canvas.restore();
  }
}
