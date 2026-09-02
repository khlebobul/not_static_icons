import 'package:flutter/material.dart';

import '../core/draw_icon_base.dart';

class GamepadIcon extends DrawIconBase {
  const GamepadIcon({
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
          ..moveTo(6, 12)
          ..lineTo(10, 12),
        Path()
          ..moveTo(8, 10)
          ..lineTo(8, 14),
        Path()
          ..moveTo(15, 13)
          ..lineTo(15.01, 13),
        Path()
          ..moveTo(18, 11)
          ..lineTo(18.01, 11),
        Path()
          ..addRRect(RRect.fromRectAndRadius(
              const Rect.fromLTWH(2, 6, 20, 12), const Radius.circular(2))),
      ];

  @override
  void paintIcon(Canvas canvas, Paint paint, double animationValue) {
    drawIconPaths(canvas, paint, [paths[4]]);
    final pulse = iconPulse(animationValue);
    canvas.save();
    canvas.translate(0, pulse * .7);
    drawIconPaths(canvas, paint, paths.take(2));
    canvas.restore();
    for (var i = 2; i < 4; i++) {
      final center = paths[i].getBounds().center;
      canvas.save();
      canvas.translate(center.dx, center.dy + pulse * (i - 1) * .4);
      canvas.scale(1 - pulse * .25);
      canvas.translate(-center.dx, -center.dy);
      canvas.drawPath(paths[i], paint);
      canvas.restore();
    }
  }
}
