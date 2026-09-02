import 'package:flutter/material.dart';

import '../core/draw_icon_base.dart';

class GrapeIcon extends DrawIconBase {
  const GrapeIcon({
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
  String get animationDescription => 'Grapes jiggle across the bunch';

  @override
  List<Path> get paths => [
        Path()
          ..moveTo(22, 5)
          ..lineTo(22, 2)
          ..lineTo(16.11, 7.89),
        Path()
          ..addOval(
              Rect.fromCircle(center: const Offset(16.6, 15.89), radius: 3)),
        Path()
          ..addOval(
              Rect.fromCircle(center: const Offset(8.11, 7.4), radius: 3)),
        Path()
          ..addOval(
              Rect.fromCircle(center: const Offset(12.35, 11.65), radius: 3)),
        Path()
          ..addOval(
              Rect.fromCircle(center: const Offset(13.91, 5.85), radius: 3)),
        Path()
          ..addOval(
              Rect.fromCircle(center: const Offset(18.15, 10.09), radius: 3)),
        Path()
          ..addOval(
              Rect.fromCircle(center: const Offset(6.56, 13.2), radius: 3)),
        Path()
          ..addOval(
              Rect.fromCircle(center: const Offset(10.8, 17.44), radius: 3)),
        Path()
          ..addOval(Rect.fromCircle(center: const Offset(5, 19), radius: 3)),
      ];

  @override
  void paintIcon(Canvas canvas, Paint paint, double animationValue) {
    canvas.drawPath(paths[0], paint);
    final pulse = iconPulse(animationValue);
    final wave = iconWave(animationValue);
    for (var i = 1; i < paths.length; i++) {
      final center = paths[i].getBounds().center;
      canvas.save();
      canvas.translate(center.dx + wave * (i.isEven ? .35 : -.35),
          center.dy - pulse * (i % 3) * .2);
      canvas.scale(1 + pulse * (.03 + i * .01));
      canvas.translate(-center.dx, -center.dy);
      canvas.drawPath(paths[i], paint);
      canvas.restore();
    }
  }
}
