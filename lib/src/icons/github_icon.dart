import 'package:flutter/material.dart';

import '../core/draw_icon_base.dart';

class GithubIcon extends DrawIconBase {
  const GithubIcon({
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
  String get animationDescription => 'Octocat bounces';

  @override
  List<Path> get paths => [
        Path()
          ..moveTo(15, 22)
          ..lineTo(15, 18)
          ..cubicTo(15, 16.5, 14.5, 15.3, 14, 14.5)
          ..cubicTo(17, 14.5, 20, 12.5, 20, 9)
          ..cubicTo(20.08, 7.75, 19.73, 6.52, 19, 5.5)
          ..cubicTo(19.28, 4.35, 19.28, 3.15, 19, 2)
          ..cubicTo(19, 2, 18, 2, 16, 3.5)
          ..cubicTo(13.36, 3, 10.64, 3, 8, 3.5)
          ..cubicTo(6, 2, 5, 2, 5, 2)
          ..cubicTo(4.7, 3.15, 4.7, 4.35, 5, 5.5)
          ..cubicTo(4.32, 6.5, 3.97, 7.72, 4, 9)
          ..cubicTo(4, 12.5, 7, 14.5, 10, 14.5)
          ..cubicTo(9.61, 14.99, 9.32, 15.55, 9.15, 16.15)
          ..cubicTo(8.98, 16.75, 8.93, 17.38, 9, 18)
          ..lineTo(9, 22),
        Path()
          ..moveTo(9, 18)
          ..cubicTo(4.49, 20, 4, 16, 2, 16),
      ];

  @override
  void paintIcon(Canvas canvas, Paint paint, double animationValue) {
    final pulse = iconPulse(animationValue);
    canvas.save();
    canvas.translate(12, 12);
    canvas.rotate(iconWave(animationValue) * .025);
    canvas.scale(1 + pulse * .05, 1 - pulse * .04);
    canvas.translate(-12, -12 - pulse * .35);
    drawIconPaths(canvas, paint, paths);
    canvas.restore();
  }
}
