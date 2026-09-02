import 'package:flutter/material.dart';

import '../core/draw_icon_base.dart';

class Gamepad2Icon extends DrawIconBase {
  const Gamepad2Icon({
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
  String get animationDescription => 'D-pad and action buttons press';

  @override
  List<Path> get paths => [
        Path()
          ..moveTo(6, 11)
          ..lineTo(10, 11),
        Path()
          ..moveTo(8, 9)
          ..lineTo(8, 13),
        Path()
          ..moveTo(15, 12)
          ..lineTo(15.01, 12),
        Path()
          ..moveTo(18, 10)
          ..lineTo(18.01, 10),
        Path()
          ..moveTo(17.32, 5)
          ..lineTo(6.68, 5)
          ..arcToPoint(const Offset(2.702, 8.59),
              radius: const Radius.circular(4), clockwise: false)
          ..cubicTo(2.696, 8.642, 2.692, 8.691, 2.685, 8.742)
          ..cubicTo(2.604, 9.416, 2, 14.456, 2, 16)
          ..arcToPoint(const Offset(5, 19),
              radius: const Radius.circular(3), clockwise: false)
          ..cubicTo(6, 19, 6.5, 18.5, 7, 18)
          ..lineTo(8.414, 16.586)
          ..arcToPoint(const Offset(9.828, 16),
              radius: const Radius.circular(2))
          ..lineTo(14.172, 16)
          ..arcToPoint(const Offset(15.586, 16.586),
              radius: const Radius.circular(2))
          ..lineTo(17, 18)
          ..cubicTo(17.5, 18.5, 18, 19, 19, 19)
          ..arcToPoint(const Offset(22, 16),
              radius: const Radius.circular(3), clockwise: false)
          ..cubicTo(22, 14.455, 21.396, 9.416, 21.315, 8.742)
          ..cubicTo(21.308, 8.692, 21.304, 8.642, 21.298, 8.591)
          ..arcToPoint(const Offset(17.32, 5),
              radius: const Radius.circular(4), clockwise: false)
          ..close(),
      ];

  @override
  void paintIcon(Canvas canvas, Paint paint, double animationValue) {
    drawIconPaths(canvas, paint, [paths[4]]);
    final pulse = iconPulse(animationValue);
    canvas.save();
    canvas.translate(0, pulse * .7);
    drawIconPaths(canvas, paint, paths.take(2));
    canvas.restore();
    for (final entry in [
      (paths[2], const Offset(15, 12), .7),
      (paths[3], const Offset(18, 10), 1.0)
    ]) {
      canvas.save();
      canvas.translate(entry.$2.dx, entry.$2.dy + pulse * entry.$3);
      canvas.scale(1 - pulse * .25);
      canvas.translate(-entry.$2.dx, -entry.$2.dy);
      canvas.drawPath(entry.$1, paint);
      canvas.restore();
    }
  }
}
