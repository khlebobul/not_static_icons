import 'package:flutter/material.dart';

import '../core/draw_icon_base.dart';

class Grid3x3Icon extends DrawIconBase {
  const Grid3x3Icon({
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
  String get animationDescription => 'Grid dividers weave';

  @override
  List<Path> get paths => [
        Path()
          ..addRRect(RRect.fromRectAndRadius(
              const Rect.fromLTWH(3, 3, 18, 18), const Radius.circular(2))),
        Path()
          ..moveTo(3, 9)
          ..lineTo(21, 9),
        Path()
          ..moveTo(3, 15)
          ..lineTo(21, 15),
        Path()
          ..moveTo(9, 3)
          ..lineTo(9, 21),
        Path()
          ..moveTo(15, 3)
          ..lineTo(15, 21),
      ];

  @override
  void paintIcon(Canvas canvas, Paint paint, double animationValue) {
    canvas.drawPath(paths[0], paint);
    final wave = iconWave(animationValue) * .5;
    for (var i = 1; i < paths.length; i++) {
      canvas.save();
      canvas.translate(i < 3 ? 0 : (i.isEven ? wave : -wave),
          i < 3 ? (i.isEven ? wave : -wave) : 0);
      canvas.drawPath(paths[i], paint);
      canvas.restore();
    }
  }
}
