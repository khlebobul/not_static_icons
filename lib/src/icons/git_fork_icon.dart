import 'package:flutter/material.dart';

import '../core/draw_icon_base.dart';

class GitForkIcon extends DrawIconBase {
  const GitForkIcon({
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
  String get animationDescription => 'Fork nodes spread apart';

  @override
  List<Path> get paths => [
        Path()
          ..addOval(Rect.fromCircle(center: const Offset(12, 18), radius: 3)),
        Path()..addOval(Rect.fromCircle(center: const Offset(6, 6), radius: 3)),
        Path()
          ..addOval(Rect.fromCircle(center: const Offset(18, 6), radius: 3)),
        Path()
          ..moveTo(18, 9)
          ..lineTo(18, 11)
          ..cubicTo(18, 11.6, 17.6, 12, 17, 12)
          ..lineTo(7, 12)
          ..cubicTo(6.4, 12, 6, 11.6, 6, 11)
          ..lineTo(6, 9),
        Path()
          ..moveTo(12, 12)
          ..lineTo(12, 15),
      ];

  @override
  void paintIcon(Canvas canvas, Paint paint, double animationValue) {
    drawIconPaths(canvas, paint, [paths[3], paths[4]]);
    final pulse = iconPulse(animationValue);
    final offsets = [Offset(0, pulse), Offset(-pulse, 0), Offset(pulse, 0)];
    for (var i = 0; i < 3; i++) {
      canvas.save();
      canvas.translate(offsets[i].dx, offsets[i].dy);
      canvas.drawPath(paths[i], paint);
      canvas.restore();
    }
  }
}
