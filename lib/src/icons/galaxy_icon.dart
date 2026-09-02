import 'package:flutter/material.dart';

import '../core/draw_icon_base.dart';

class GalaxyIcon extends DrawIconBase {
  const GalaxyIcon({
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
  String get animationDescription => 'Orbits rotate while stars twinkle';

  @override
  List<Path> get paths => [
        Path()
          ..moveTo(16.005, 15.108)
          ..arcToPoint(const Offset(7.997, 8.891),
              radius: const Radius.elliptical(5.041, 6.52),
              rotation: 28.25,
              clockwise: false)
          ..arcToPoint(const Offset(16.005, 15.108),
              radius: const Radius.elliptical(5.041, 6.52),
              rotation: 28.25,
              clockwise: false)
          ..arcToPoint(const Offset(4.029, 7.001),
              radius: const Radius.elliptical(11.884, 7.288), rotation: -60.76),
        Path()
          ..moveTo(17, 21)
          ..lineTo(17.01, 21),
        Path()
          ..moveTo(7, 3)
          ..lineTo(7.01, 3),
        Path()
          ..moveTo(7.997, 8.891)
          ..arcToPoint(const Offset(19.974, 16.998),
              radius: const Radius.elliptical(11.885, 7.288),
              rotation: -60.756),
        Path()
          ..addOval(Rect.fromCircle(center: const Offset(12, 12), radius: 1)),
      ];

  @override
  void paintIcon(Canvas canvas, Paint paint, double animationValue) {
    final pulse = iconPulse(animationValue);
    final wave = iconWave(animationValue);
    canvas.save();
    canvas.translate(12, 12);
    canvas.rotate(wave * .18);
    canvas.translate(-12, -12);
    drawIconPaths(canvas, paint, [paths[0], paths[3]]);
    canvas.restore();
    for (final entry in [
      (paths[1], const Offset(17, 21), 1.0),
      (paths[2], const Offset(7, 3), -1.0)
    ]) {
      canvas.save();
      canvas.translate(entry.$2.dx, entry.$2.dy);
      canvas.scale(1 + pulse * .5);
      canvas.translate(-entry.$2.dx, -entry.$2.dy);
      canvas.translate(wave * entry.$3 * .4, 0);
      canvas.drawPath(entry.$1, paint);
      canvas.restore();
    }

    final fill = Paint()..color = paint.color;
    canvas.save();
    canvas.translate(12, 12);
    canvas.scale(1 + pulse * .3);
    canvas.translate(-12, -12);
    canvas.drawPath(paths.last, fill);
    canvas.drawPath(paths.last, paint);
    canvas.restore();
  }
}
