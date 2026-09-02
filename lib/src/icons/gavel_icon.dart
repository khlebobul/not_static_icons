import 'package:flutter/material.dart';

import '../core/draw_icon_base.dart';

class GavelIcon extends DrawIconBase {
  const GavelIcon({
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
  String get animationDescription => 'Gavel strikes';

  @override
  List<Path> get paths => [
        Path()
          ..moveTo(14, 13)
          ..lineTo(5.619, 21.38)
          ..arcToPoint(const Offset(2.618, 18.38),
              radius: const Radius.circular(1))
          ..lineTo(11.002, 9.999),
        Path()
          ..moveTo(16, 16)
          ..lineTo(22, 10),
        Path()
          ..moveTo(21.5, 10.5)
          ..lineTo(13.5, 2.5),
        Path()
          ..moveTo(8, 8)
          ..lineTo(14, 2),
        Path()
          ..moveTo(8.5, 7.5)
          ..lineTo(16.5, 15.5),
      ];

  @override
  void paintIcon(Canvas canvas, Paint paint, double animationValue) {
    final strike = iconPulse(animationValue);
    canvas.save();
    canvas.translate(5.6, 21.38);
    canvas.rotate(-strike * .28);
    canvas.translate(-5.6, -21.38);
    drawIconPaths(canvas, paint, paths);
    canvas.restore();
  }
}
