import 'package:flutter/material.dart';

import '../core/draw_icon_base.dart';

class FullscreenIcon extends DrawIconBase {
  const FullscreenIcon({
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
          ..moveTo(3, 7)
          ..lineTo(3, 5)
          ..arcToPoint(const Offset(5, 3), radius: const Radius.circular(2))
          ..lineTo(7, 3),
        Path()
          ..moveTo(17, 3)
          ..lineTo(19, 3)
          ..arcToPoint(const Offset(21, 5), radius: const Radius.circular(2))
          ..lineTo(21, 7),
        Path()
          ..moveTo(21, 17)
          ..lineTo(21, 19)
          ..arcToPoint(const Offset(19, 21), radius: const Radius.circular(2))
          ..lineTo(17, 21),
        Path()
          ..moveTo(7, 21)
          ..lineTo(5, 21)
          ..arcToPoint(const Offset(3, 19), radius: const Radius.circular(2))
          ..lineTo(3, 17),
        Path()
          ..addRRect(
            RRect.fromRectAndRadius(
              const Rect.fromLTWH(7, 8, 10, 8),
              const Radius.circular(1),
            ),
          ),
      ];

  @override
  void paintIcon(Canvas canvas, Paint paint, double animationValue) {
    final expand = iconPulse(animationValue);
    final offsets = [
      Offset(-expand, -expand),
      Offset(expand, -expand),
      Offset(expand, expand),
      Offset(-expand, expand),
    ];
    for (var i = 0; i < 4; i++) {
      canvas.save();
      canvas.translate(offsets[i].dx, offsets[i].dy);
      drawIconPaths(canvas, paint, [paths[i]]);
      canvas.restore();
    }
    canvas.save();
    canvas.translate(12, 12);
    canvas.scale(1 - expand * .1);
    canvas.translate(-12, -12);
    drawIconPaths(canvas, paint, [paths[4]]);
    canvas.restore();
  }
}
