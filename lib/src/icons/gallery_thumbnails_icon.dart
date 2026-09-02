import 'package:flutter/material.dart';

import '../core/draw_icon_base.dart';

class GalleryThumbnailsIcon extends DrawIconBase {
  const GalleryThumbnailsIcon({
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
  String get animationDescription => 'Preview grows while thumbnails bounce';

  @override
  List<Path> get paths => [
        Path()
          ..addRRect(RRect.fromRectAndRadius(
              const Rect.fromLTWH(3, 3, 18, 14), const Radius.circular(2))),
        Path()
          ..moveTo(4, 21)
          ..lineTo(5, 21),
        Path()
          ..moveTo(9, 21)
          ..lineTo(10, 21),
        Path()
          ..moveTo(14, 21)
          ..lineTo(15, 21),
        Path()
          ..moveTo(19, 21)
          ..lineTo(20, 21),
      ];

  @override
  void paintIcon(Canvas canvas, Paint paint, double animationValue) {
    final pulse = iconPulse(animationValue);
    canvas.save();
    canvas.translate(12, 10);
    canvas.scale(1 + pulse * .04);
    canvas.translate(-12, -10);
    drawIconPaths(canvas, paint, [paths[0]]);
    canvas.restore();
    for (var i = 1; i < paths.length; i++) {
      canvas.save();
      canvas.translate(0, -pulse * (i.isEven ? .8 : .35));
      canvas.drawPath(paths[i], paint);
      canvas.restore();
    }
  }
}
