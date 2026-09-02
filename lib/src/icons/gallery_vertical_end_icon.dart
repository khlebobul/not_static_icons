import 'package:flutter/material.dart';

import '../core/draw_icon_base.dart';

class GalleryVerticalEndIcon extends DrawIconBase {
  const GalleryVerticalEndIcon({
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
  String get animationDescription => 'Card slides toward the vertical end rail';

  @override
  List<Path> get paths => [
        Path()
          ..moveTo(7, 2)
          ..lineTo(17, 2),
        Path()
          ..moveTo(5, 6)
          ..lineTo(19, 6),
        Path()
          ..addRRect(RRect.fromRectAndRadius(
              const Rect.fromLTWH(3, 10, 18, 12), const Radius.circular(2))),
      ];

  @override
  void paintIcon(Canvas canvas, Paint paint, double animationValue) {
    final pulse = iconPulse(animationValue);
    canvas.save();
    canvas.translate(0, -pulse * .8);
    drawIconPaths(canvas, paint, paths.take(2));
    canvas.restore();
    canvas.save();
    canvas.translate(0, pulse * 1.2);
    drawIconPaths(canvas, paint, [paths[2]]);
    canvas.restore();
  }
}
