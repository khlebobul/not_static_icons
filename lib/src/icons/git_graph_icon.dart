import 'package:flutter/material.dart';

import '../core/draw_icon_base.dart';

class GitGraphIcon extends DrawIconBase {
  const GitGraphIcon({
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
  String get animationDescription => 'Graph nodes pulse in sequence';

  @override
  List<Path> get paths => [
        Path()..addOval(Rect.fromCircle(center: const Offset(5, 6), radius: 3)),
        Path()
          ..moveTo(5, 9)
          ..lineTo(5, 15),
        Path()
          ..addOval(Rect.fromCircle(center: const Offset(5, 18), radius: 3)),
        Path()
          ..moveTo(12, 3)
          ..lineTo(12, 21),
        Path()
          ..addOval(Rect.fromCircle(center: const Offset(19, 6), radius: 3)),
        Path()
          ..moveTo(16, 15.7)
          ..arcToPoint(const Offset(19, 9),
              radius: const Radius.circular(9), clockwise: false),
      ];

  @override
  void paintIcon(Canvas canvas, Paint paint, double animationValue) {
    drawIconPaths(canvas, paint, [paths[1], paths[3], paths[5]]);
    final pulse = iconPulse(animationValue);
    final centers = [
      const Offset(5, 6),
      const Offset(5, 18),
      const Offset(19, 6)
    ];
    for (var i = 0; i < centers.length; i++) {
      final path = paths[[0, 2, 4][i]];
      canvas.save();
      canvas.translate(centers[i].dx, centers[i].dy);
      canvas.scale(1 + pulse * (.1 + i * .06));
      canvas.translate(-centers[i].dx, -centers[i].dy);
      canvas.drawPath(path, paint);
      canvas.restore();
    }
  }
}
