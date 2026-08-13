import 'package:flutter/material.dart';

import '../core/draw_icon_base.dart';

class FormIcon extends DrawIconBase {
  const FormIcon({
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
  List<Path> get paths => [
        Path()
          ..moveTo(4, 14)
          ..lineTo(10, 14),
        Path()
          ..moveTo(4, 2)
          ..lineTo(14, 2),
        Path()
          ..addRRect(
            RRect.fromRectAndRadius(
              const Rect.fromLTWH(4, 18, 16, 4),
              const Radius.circular(1),
            ),
          ),
        Path()
          ..addRRect(
            RRect.fromRectAndRadius(
              const Rect.fromLTWH(4, 6, 16, 4),
              const Radius.circular(1),
            ),
          ),
      ];

  @override
  void paintIcon(Canvas canvas, Paint paint, double animationValue) {
    final focus = iconPulse(animationValue);
    canvas.save();
    canvas.translate(focus * 2, 0);
    drawIconPaths(canvas, paint, [paths[0]]);
    canvas.restore();
    canvas.save();
    canvas.translate(-focus * 2, 0);
    drawIconPaths(canvas, paint, [paths[1]]);
    canvas.restore();
    canvas.save();
    canvas.translate(12, 8);
    canvas.scale(1 + focus * .08, 1);
    canvas.translate(-12, -8);
    drawIconPaths(canvas, paint, [paths[3]]);
    canvas.restore();
    canvas.save();
    canvas.translate(12, 20);
    canvas.scale(1 - focus * .08, 1);
    canvas.translate(-12, -20);
    drawIconPaths(canvas, paint, [paths[2]]);
    canvas.restore();
  }
}
