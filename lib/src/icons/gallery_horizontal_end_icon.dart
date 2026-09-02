import 'package:flutter/material.dart';

import '../core/draw_icon_base.dart';

class GalleryHorizontalEndIcon extends DrawIconBase {
  const GalleryHorizontalEndIcon({
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
  String get animationDescription =>
      'Card slides toward the horizontal end rail';

  @override
  List<Path> get paths => [
        Path()
          ..moveTo(2, 7)
          ..lineTo(2, 17),
        Path()
          ..moveTo(6, 5)
          ..lineTo(6, 19),
        Path()
          ..addRRect(RRect.fromRectAndRadius(
              const Rect.fromLTWH(10, 3, 12, 18), const Radius.circular(2))),
      ];

  @override
  void paintIcon(Canvas canvas, Paint paint, double animationValue) {
    final pulse = iconPulse(animationValue);
    canvas.save();
    canvas.translate(-pulse * .8, 0);
    drawIconPaths(canvas, paint, paths.take(2));
    canvas.restore();
    canvas.save();
    canvas.translate(pulse * 1.2, 0);
    drawIconPaths(canvas, paint, [paths[2]]);
    canvas.restore();
  }
}
