import 'package:flutter/material.dart';

import '../core/draw_icon_base.dart';

class BroomSparklesIcon extends DrawIconBase {
  const BroomSparklesIcon({
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
  String get animationDescription => 'Broom sweeps while sparkles pulse';

  @override
  List<Path> get paths => [
        Path()
          ..moveTo(13.5, 10.5)
          ..lineTo(22, 2),
        Path()
          ..moveTo(14.734, 13.841)
          ..arcToPoint(const Offset(14.42, 11.421),
              radius: const Radius.circular(2), clockwise: false)
          ..lineTo(12.58, 9.58)
          ..arcToPoint(const Offset(10.159, 9.266),
              radius: const Radius.circular(2), clockwise: false)
          ..lineTo(2.502, 13.727)
          ..arcToPoint(const Offset(2.3, 15.3),
              radius: const Radius.circular(1), clockwise: false)
          ..lineTo(8.703, 21.703)
          ..arcToPoint(const Offset(10.274, 21.499),
              radius: const Radius.circular(1), clockwise: false)
          ..close(),
        Path()
          ..moveTo(5, 18)
          ..lineTo(7, 16),
        Path()
          ..moveTo(7.699, 10.7)
          ..lineTo(13.301, 16.301),
        for (final line in const [
          (11.0, 2.0, 11.0, 4.0),
          (12.0, 3.0, 10.0, 3.0),
          (20.0, 15.0, 20.0, 19.0),
          (22.0, 17.0, 18.0, 17.0),
          (4.0, 4.0, 4.0, 8.0),
          (6.0, 6.0, 2.0, 6.0),
        ])
          Path()
            ..moveTo(line.$1, line.$2)
            ..lineTo(line.$3, line.$4),
      ];

  @override
  void paintIcon(Canvas canvas, Paint paint, double animationValue) {
    canvas.save();
    canvas.translate(13.5, 10.5);
    canvas.rotate(iconWave(animationValue) * .08);
    canvas.translate(-13.5, -10.5);
    drawIconPaths(canvas, paint, paths.take(4));
    canvas.restore();
    final pulse = 1 + iconPulse(animationValue) * .18;
    for (final centerAndPaths in [
      (const Offset(11, 3), paths.sublist(4, 6)),
      (const Offset(20, 17), paths.sublist(6, 8)),
      (const Offset(4, 6), paths.sublist(8, 10)),
    ]) {
      canvas.save();
      canvas.translate(centerAndPaths.$1.dx, centerAndPaths.$1.dy);
      canvas.scale(pulse);
      canvas.translate(-centerAndPaths.$1.dx, -centerAndPaths.$1.dy);
      drawIconPaths(canvas, paint, centerAndPaths.$2);
      canvas.restore();
    }
  }
}
