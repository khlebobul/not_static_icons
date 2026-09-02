import 'package:flutter/material.dart';

import '../core/draw_icon_base.dart';

class Grid3x2Icon extends DrawIconBase {
  const Grid3x2Icon({
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
  String get animationDescription => 'Grid columns shift apart';

  @override
  List<Path> get paths => [
        Path()
          ..moveTo(15, 3)
          ..lineTo(15, 21),
        Path()
          ..moveTo(3, 12)
          ..lineTo(21, 12),
        Path()
          ..moveTo(9, 3)
          ..lineTo(9, 21),
        Path()
          ..addRRect(RRect.fromRectAndRadius(
              const Rect.fromLTWH(3, 3, 18, 18), const Radius.circular(2))),
      ];

  @override
  void paintIcon(Canvas canvas, Paint paint, double animationValue) {
    canvas.drawPath(paths[3], paint);
    final wave = iconWave(animationValue);
    canvas.save();
    canvas.translate(wave * .6, 0);
    canvas.drawPath(paths[0], paint);
    canvas.restore();
    canvas.drawPath(paths[1], paint);
    canvas.save();
    canvas.translate(-wave * .6, 0);
    canvas.drawPath(paths[2], paint);
    canvas.restore();
  }
}
