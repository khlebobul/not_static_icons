import 'package:flutter/material.dart';

import '../core/draw_icon_base.dart';

class GoalIcon extends DrawIconBase {
  const GoalIcon({
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
  String get animationDescription => 'Target expands while flag waves';

  @override
  List<Path> get paths => [
        Path()
          ..moveTo(12, 13)
          ..lineTo(12, 2)
          ..lineTo(20, 6)
          ..lineTo(12, 10),
        Path()
          ..moveTo(20.561, 10.222)
          ..arcToPoint(const Offset(8.011, 4.932),
              radius: const Radius.circular(9), largeArc: true),
        Path()
          ..moveTo(8.002, 9.997)
          ..arcToPoint(const Offset(16.902, 12.017),
              radius: const Radius.circular(5),
              largeArc: true,
              clockwise: false),
      ];

  @override
  void paintIcon(Canvas canvas, Paint paint, double animationValue) {
    final pulse = iconPulse(animationValue);
    canvas.save();
    canvas.translate(12, 12);
    canvas.scale(1 + pulse * .05);
    canvas.translate(-12, -12);
    drawIconPaths(canvas, paint, paths.skip(1));
    canvas.restore();
    canvas.save();
    canvas.translate(12, 2);
    canvas.rotate(iconWave(animationValue) * .1);
    canvas.translate(-12, -2);
    canvas.drawPath(paths[0], paint);
    canvas.restore();
  }
}
