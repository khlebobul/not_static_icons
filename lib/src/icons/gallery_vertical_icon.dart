import 'package:flutter/material.dart';

import '../core/draw_icon_base.dart';

class GalleryVerticalIcon extends DrawIconBase {
  const GalleryVerticalIcon({
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
  String get animationDescription => 'Card moves between vertical rails';

  @override
  List<Path> get paths => [
        Path()
          ..moveTo(3, 2)
          ..lineTo(21, 2),
        Path()
          ..addRRect(RRect.fromRectAndRadius(
              const Rect.fromLTWH(3, 6, 18, 12), const Radius.circular(2))),
        Path()
          ..moveTo(3, 22)
          ..lineTo(21, 22),
      ];

  @override
  void paintIcon(Canvas canvas, Paint paint, double animationValue) {
    final pulse = iconPulse(animationValue);
    canvas.save();
    canvas.translate(0, -pulse);
    drawIconPaths(canvas, paint, [paths[0]]);
    canvas.restore();
    canvas.save();
    canvas.translate(0, iconWave(animationValue) * 1.2);
    drawIconPaths(canvas, paint, [paths[1]]);
    canvas.restore();
    canvas.save();
    canvas.translate(0, pulse);
    drawIconPaths(canvas, paint, [paths[2]]);
    canvas.restore();
  }
}
