import 'package:flutter/material.dart';

import '../core/draw_icon_base.dart';

class GlobeLockIcon extends DrawIconBase {
  const GlobeLockIcon({
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
  String get animationDescription => 'Globe lock lifts and grows';

  @override
  List<Path> get paths => [
        Path()
          ..moveTo(15.686, 15)
          ..arcToPoint(const Offset(12, 22),
              radius: const Radius.circular(14.5))
          ..arcToPoint(const Offset(12, 2), radius: const Radius.circular(14.5))
          ..arcToPoint(const Offset(21.542, 15),
              radius: const Radius.circular(10),
              largeArc: true,
              clockwise: false),
        Path()
          ..moveTo(2, 12)
          ..lineTo(10.5, 12),
        Path()
          ..moveTo(20, 6)
          ..lineTo(20, 4)
          ..arcToPoint(const Offset(16, 4),
              radius: const Radius.circular(2),
              largeArc: true,
              clockwise: false)
          ..lineTo(16, 6),
        Path()
          ..addRRect(RRect.fromRectAndRadius(
              const Rect.fromLTWH(14, 6, 8, 5), const Radius.circular(1))),
      ];

  @override
  void paintIcon(Canvas canvas, Paint paint, double animationValue) {
    drawIconPaths(canvas, paint, paths.take(2));
    final pulse = iconPulse(animationValue);
    canvas.save();
    canvas.translate(18, 8.5);
    canvas.scale(1 + pulse * .12);
    canvas.translate(-18, -8.5 - pulse * .7);
    drawIconPaths(canvas, paint, paths.skip(2));
    canvas.restore();
  }
}
