import 'package:flutter/material.dart';

import '../core/draw_icon_base.dart';

class FaceAngryIcon extends DrawIconBase {
  const FaceAngryIcon({
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
  String get animationDescription => 'Angry face shakes';

  @override
  List<Path> get paths => [
        Path()
          ..moveTo(15, 11)
          ..lineTo(15, 9.416),
        Path()
          ..moveTo(17, 9)
          ..arcToPoint(const Offset(14, 10),
              radius: const Radius.circular(5), clockwise: false),
        Path()
          ..moveTo(7, 9)
          ..arcToPoint(const Offset(10, 10), radius: const Radius.circular(5)),
        Path()
          ..moveTo(9, 11)
          ..lineTo(9, 9.416),
        Path()
          ..moveTo(9, 16)
          ..arcToPoint(const Offset(15.001, 16),
              radius: const Radius.circular(5)),
        Path()
          ..addOval(Rect.fromCircle(center: const Offset(12, 12), radius: 10)),
      ];

  @override
  void paintIcon(Canvas canvas, Paint paint, double animationValue) {
    canvas.save();
    canvas.translate(iconWave(animationValue) * .7, 0);
    drawIconPaths(canvas, paint, paths);
    canvas.restore();
  }
}
