import 'package:flutter/material.dart';

import '../core/draw_icon_base.dart';

class GlassesIcon extends DrawIconBase {
  const GlassesIcon({
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
  String get animationDescription => 'Lenses widen apart';

  @override
  List<Path> get paths => [
        Path()
          ..addOval(Rect.fromCircle(center: const Offset(6, 15), radius: 4)),
        Path()
          ..addOval(Rect.fromCircle(center: const Offset(18, 15), radius: 4)),
        Path()
          ..moveTo(14, 15)
          ..arcToPoint(const Offset(12, 13),
              radius: const Radius.circular(2), clockwise: false)
          ..arcToPoint(const Offset(10, 15),
              radius: const Radius.circular(2), clockwise: false),
        Path()
          ..moveTo(2.5, 13)
          ..lineTo(5, 7)
          ..cubicTo(5.7, 5.7, 6.4, 5, 8, 5),
        Path()
          ..moveTo(21.5, 13)
          ..lineTo(19, 7)
          ..cubicTo(18.3, 5.7, 17.5, 5, 16, 5),
      ];

  @override
  void paintIcon(Canvas canvas, Paint paint, double animationValue) {
    drawIconPaths(canvas, paint, paths.skip(2));
    final pulse = iconPulse(animationValue);
    for (final entry in [
      (paths[0], const Offset(6, 15), -1.0),
      (paths[1], const Offset(18, 15), 1.0)
    ]) {
      canvas.save();
      canvas.translate(entry.$2.dx + entry.$3 * pulse * .4, entry.$2.dy);
      canvas.scale(1 + pulse * .08);
      canvas.translate(-entry.$2.dx, -entry.$2.dy);
      canvas.drawPath(entry.$1, paint);
      canvas.restore();
    }
  }
}
