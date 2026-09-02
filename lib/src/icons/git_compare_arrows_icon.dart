import 'package:flutter/material.dart';

import '../core/draw_icon_base.dart';

class GitCompareArrowsIcon extends DrawIconBase {
  const GitCompareArrowsIcon({
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
  String get animationDescription =>
      'Compare arrows move in opposite directions';

  @override
  List<Path> get paths => [
        Path()..addOval(Rect.fromCircle(center: const Offset(5, 6), radius: 3)),
        Path()
          ..moveTo(12, 6)
          ..lineTo(17, 6)
          ..arcToPoint(const Offset(19, 8), radius: const Radius.circular(2))
          ..lineTo(19, 15),
        Path()
          ..moveTo(15, 9)
          ..lineTo(12, 6)
          ..lineTo(15, 3),
        Path()
          ..addOval(Rect.fromCircle(center: const Offset(19, 18), radius: 3)),
        Path()
          ..moveTo(12, 18)
          ..lineTo(7, 18)
          ..arcToPoint(const Offset(5, 16), radius: const Radius.circular(2))
          ..lineTo(5, 9),
        Path()
          ..moveTo(9, 15)
          ..lineTo(12, 18)
          ..lineTo(9, 21),
      ];

  @override
  void paintIcon(Canvas canvas, Paint paint, double animationValue) {
    drawIconPaths(canvas, paint, [paths[0], paths[1], paths[3], paths[4]]);
    final wave = iconWave(animationValue);
    canvas.save();
    canvas.translate(-wave, 0);
    canvas.drawPath(paths[2], paint);
    canvas.restore();
    canvas.save();
    canvas.translate(wave, 0);
    canvas.drawPath(paths[5], paint);
    canvas.restore();
  }
}
