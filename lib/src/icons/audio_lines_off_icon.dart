import 'package:flutter/material.dart';

import '../core/draw_icon_base.dart';

class AudioLinesOffIcon extends DrawIconBase {
  const AudioLinesOffIcon({
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
  String get animationDescription => 'Audio fragments collapse behind slash';

  @override
  List<Path> get paths => [
        for (final line in const [
          (10.0, 10.0, 21.0),
          (10.0, 3.0, 4.35),
          (14.0, 14.0, 15.0),
          (14.0, 8.0, 8.35),
          (18.0, 5.0, 12.35),
          (2.0, 10.0, 13.0),
          (22.0, 10.0, 13.0),
          (6.0, 6.0, 17.0),
        ])
          Path()
            ..moveTo(line.$1, line.$2)
            ..lineTo(line.$1, line.$3),
        Path()
          ..moveTo(2, 2)
          ..lineTo(22, 22),
      ];

  @override
  void paintIcon(Canvas canvas, Paint paint, double animationValue) {
    final pulse = iconPulse(animationValue);
    for (var i = 0; i < 8; i++) {
      final bounds = paths[i].getBounds();
      final centerY = (bounds.top + bounds.bottom) / 2;
      canvas.save();
      canvas.translate(0, centerY);
      canvas.scale(1, 1 - pulse * (.35 + i % 3 * .08));
      canvas.translate(0, -centerY);
      canvas.drawPath(paths[i], paint);
      canvas.restore();
    }
    canvas.drawPath(paths[8], paint);
  }
}
