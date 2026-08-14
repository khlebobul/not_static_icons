import 'package:flutter/material.dart';

import '../core/draw_icon_base.dart';

class AudioLinesXIcon extends DrawIconBase {
  const AudioLinesXIcon({
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
  String get animationDescription => 'Audio lines pulse while X shakes';

  @override
  List<Path> get paths => [
        for (final line in const [
          (10.0, 3.0, 21.0),
          (14.0, 8.0, 14.35),
          (18.0, 5.0, 13.1),
          (2.0, 10.0, 13.0),
          (22.0, 10.0, 13.0),
          (6.0, 6.0, 17.0),
        ])
          Path()
            ..moveTo(line.$1, line.$2)
            ..lineTo(line.$1, line.$3),
        Path()
          ..moveTo(17, 17)
          ..lineTo(22, 22),
        Path()
          ..moveTo(22, 17)
          ..lineTo(17, 22),
      ];

  @override
  void paintIcon(Canvas canvas, Paint paint, double animationValue) {
    final pulse = iconPulse(animationValue);
    for (var i = 0; i < 6; i++) {
      final centerY =
          (paths[i].getBounds().top + paths[i].getBounds().bottom) / 2;
      canvas.save();
      canvas.translate(0, centerY);
      canvas.scale(1, 1 + pulse * (i.isEven ? .12 : -.08));
      canvas.translate(0, -centerY);
      drawIconPaths(canvas, paint, [paths[i]]);
      canvas.restore();
    }
    canvas.save();
    canvas.translate(iconWave(animationValue) * .5, 0);
    drawIconPaths(canvas, paint, paths.skip(6));
    canvas.restore();
  }
}
