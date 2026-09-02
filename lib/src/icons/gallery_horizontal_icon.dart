import 'package:flutter/material.dart';

import '../core/draw_icon_base.dart';

class GalleryHorizontalIcon extends DrawIconBase {
  const GalleryHorizontalIcon({
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
  String get animationDescription => 'Card moves between horizontal rails';

  @override
  List<Path> get paths => [
        Path()
          ..moveTo(2, 3)
          ..lineTo(2, 21),
        Path()
          ..addRRect(RRect.fromRectAndRadius(
              const Rect.fromLTWH(6, 3, 12, 18), const Radius.circular(2))),
        Path()
          ..moveTo(22, 3)
          ..lineTo(22, 21),
      ];

  @override
  void paintIcon(Canvas canvas, Paint paint, double animationValue) {
    final pulse = iconPulse(animationValue);
    canvas.save();
    canvas.translate(-pulse, 0);
    drawIconPaths(canvas, paint, [paths[0]]);
    canvas.restore();
    canvas.save();
    canvas.translate(iconWave(animationValue) * 1.2, 0);
    drawIconPaths(canvas, paint, [paths[1]]);
    canvas.restore();
    canvas.save();
    canvas.translate(pulse, 0);
    drawIconPaths(canvas, paint, [paths[2]]);
    canvas.restore();
  }
}
