import 'package:flutter/material.dart';

import '../core/draw_icon_base.dart';

class GuitarIcon extends DrawIconBase {
  const GuitarIcon({
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
  String get animationDescription => 'Guitar tilts while the string vibrates';

  @override
  List<Path> get paths => [
        Path()
          ..moveTo(11.9, 12.1)
          ..lineTo(16.414, 7.586),
        Path()
          ..moveTo(20.1, 2.3)
          ..arcToPoint(const Offset(18.7, 2.3),
              radius: const Radius.circular(1), clockwise: false)
          ..lineTo(17.586, 3.414)
          ..arcToPoint(const Offset(17, 4.828),
              radius: const Radius.circular(2), clockwise: false)
          ..lineTo(17, 6.172)
          ..arcToPoint(const Offset(16.414, 7.586),
              radius: const Radius.circular(2))
          ..arcToPoint(const Offset(17.828, 7),
              radius: const Radius.circular(2))
          ..lineTo(19.172, 7)
          ..arcToPoint(const Offset(20.586, 6.414),
              radius: const Radius.circular(2), clockwise: false)
          ..lineTo(21.7, 5.3)
          ..arcToPoint(const Offset(21.7, 3.9),
              radius: const Radius.circular(1), clockwise: false)
          ..close(),
        Path()
          ..moveTo(6, 16)
          ..lineTo(8, 18),
        Path()
          ..moveTo(8.23, 9.85)
          ..arcToPoint(const Offset(11, 8), radius: const Radius.circular(3))
          ..arcToPoint(const Offset(16, 13), radius: const Radius.circular(5))
          ..arcToPoint(const Offset(14.15, 15.77),
              radius: const Radius.circular(3))
          ..lineTo(13.23, 16.15)
          ..arcToPoint(const Offset(12, 18),
              radius: const Radius.circular(2), clockwise: false)
          ..arcToPoint(const Offset(8, 22), radius: const Radius.circular(4))
          ..arcToPoint(const Offset(2, 16), radius: const Radius.circular(6))
          ..arcToPoint(const Offset(6, 12), radius: const Radius.circular(4))
          ..arcToPoint(const Offset(7.85, 10.77),
              radius: const Radius.circular(2), clockwise: false)
          ..close(),
      ];

  @override
  void paintIcon(Canvas canvas, Paint paint, double animationValue) {
    final wave = iconWave(animationValue);
    canvas.save();
    canvas.translate(8, 18);
    canvas.rotate(wave * .06);
    canvas.translate(-8, -18);
    drawIconPaths(canvas, paint, [paths[0], paths[1], paths[3]]);
    canvas.restore();
    canvas.save();
    canvas.translate(wave * .7, -wave * .7);
    canvas.drawPath(paths[2], paint);
    canvas.restore();
  }
}
