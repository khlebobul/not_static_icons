import 'package:flutter/material.dart';

import '../core/draw_icon_base.dart';

class GraduationCapIcon extends DrawIconBase {
  const GraduationCapIcon({
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
  String get animationDescription => 'Graduation cap tosses upward';

  @override
  List<Path> get paths => [
        Path()
          ..moveTo(21.42, 10.922)
          ..arcToPoint(const Offset(21.401, 9.084),
              radius: const Radius.circular(1), clockwise: false)
          ..lineTo(12.83, 5.18)
          ..arcToPoint(const Offset(11.17, 5.18),
              radius: const Radius.circular(2), clockwise: false)
          ..lineTo(2.6, 9.08)
          ..arcToPoint(const Offset(2.6, 10.912),
              radius: const Radius.circular(1), clockwise: false)
          ..lineTo(11.17, 14.82)
          ..arcToPoint(const Offset(12.83, 14.82),
              radius: const Radius.circular(2), clockwise: false)
          ..close(),
        Path()
          ..moveTo(22, 10)
          ..lineTo(22, 16),
        Path()
          ..moveTo(6, 12.5)
          ..lineTo(6, 16)
          ..arcToPoint(const Offset(18, 16),
              radius: const Radius.elliptical(6, 3), clockwise: false)
          ..lineTo(18, 12.5),
      ];

  @override
  void paintIcon(Canvas canvas, Paint paint, double animationValue) {
    canvas.drawPath(paths[2], paint);
    final toss = iconPulse(animationValue);
    canvas.save();
    canvas.translate(12, 10);
    canvas.rotate(iconWave(animationValue) * .06);
    canvas.translate(-12, -10 - toss * 1.8);
    drawIconPaths(canvas, paint, paths.take(2));
    canvas.restore();
  }
}
