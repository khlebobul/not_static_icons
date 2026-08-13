import 'package:flutter/material.dart';

import '../core/draw_icon_base.dart';

class FootprintsIcon extends DrawIconBase {
  const FootprintsIcon({
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
          ..moveTo(4, 16)
          ..lineTo(4, 13.62)
          ..cubicTo(4, 11.5, 2.97, 10.5, 3, 8)
          ..cubicTo(3.03, 5.28, 4.49, 2, 7.5, 2)
          ..cubicTo(9.37, 2, 10, 3.8, 10, 5.5)
          ..cubicTo(10, 8.61, 8, 11.16, 8, 14.18)
          ..lineTo(8, 16)
          ..arcToPoint(
            const Offset(4, 16),
            radius: const Radius.circular(2),
            largeArc: true,
          )
          ..close(),
        Path()
          ..moveTo(20, 20)
          ..lineTo(20, 17.62)
          ..cubicTo(20, 15.5, 21.03, 14.5, 21, 12)
          ..cubicTo(20.97, 9.28, 19.51, 6, 16.5, 6)
          ..cubicTo(14.63, 6, 14, 7.8, 14, 9.5)
          ..cubicTo(14, 12.61, 16, 15.16, 16, 18.18)
          ..lineTo(16, 20)
          ..arcToPoint(
            const Offset(20, 20),
            radius: const Radius.circular(2),
            largeArc: true,
            clockwise: false,
          )
          ..close(),
        Path()
          ..moveTo(16, 17)
          ..lineTo(20, 17),
        Path()
          ..moveTo(4, 13)
          ..lineTo(8, 13),
      ];

  @override
  void paintIcon(Canvas canvas, Paint paint, double animationValue) {
    final step = iconPulse(animationValue) * 1.2;
    canvas.save();
    canvas.translate(0, -step);
    drawIconPaths(canvas, paint, [paths[0], paths[3]]);
    canvas.restore();
    canvas.save();
    canvas.translate(0, step);
    drawIconPaths(canvas, paint, [paths[1], paths[2]]);
    canvas.restore();
  }
}
