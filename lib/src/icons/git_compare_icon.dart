import 'package:flutter/material.dart';

import '../core/draw_icon_base.dart';

class GitCompareIcon extends DrawIconBase {
  const GitCompareIcon({
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
  String get animationDescription => 'Compared commits move past each other';

  @override
  List<Path> get paths => [
        Path()
          ..addOval(Rect.fromCircle(center: const Offset(18, 18), radius: 3)),
        Path()..addOval(Rect.fromCircle(center: const Offset(6, 6), radius: 3)),
        Path()
          ..moveTo(13, 6)
          ..lineTo(16, 6)
          ..arcToPoint(const Offset(18, 8), radius: const Radius.circular(2))
          ..lineTo(18, 15),
        Path()
          ..moveTo(11, 18)
          ..lineTo(8, 18)
          ..arcToPoint(const Offset(6, 16), radius: const Radius.circular(2))
          ..lineTo(6, 9),
      ];

  @override
  void paintIcon(Canvas canvas, Paint paint, double animationValue) {
    drawIconPaths(canvas, paint, [paths[2], paths[3]]);
    final wave = iconWave(animationValue);
    canvas.save();
    canvas.translate(-wave * .8, wave * .8);
    canvas.drawPath(paths[0], paint);
    canvas.restore();
    canvas.save();
    canvas.translate(wave * .8, -wave * .8);
    canvas.drawPath(paths[1], paint);
    canvas.restore();
  }
}
