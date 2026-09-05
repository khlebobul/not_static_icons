import 'package:flutter/material.dart';

import '../core/draw_icon_base.dart';

class SearchIcon extends DrawIconBase {
  const SearchIcon({
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
  String get animationDescription => 'Magnifier scans';

  @override
  List<Path> get paths => [
        Path()
          ..moveTo(21, 21)
          ..lineTo(16.66, 16.66),
        Path()
          ..addOval(Rect.fromCircle(center: const Offset(11, 11), radius: 8)),
      ];

  @override
  void paintIcon(Canvas canvas, Paint paint, double animationValue) {
    final pulse = iconPulse(animationValue);
    canvas.save();
    canvas.translate(11, 11);
    canvas.scale(1 + pulse * .08);
    canvas.translate(-11, -11);
    canvas.drawPath(paths[1], paint);
    canvas.restore();
    canvas.save();
    canvas.translate(pulse * .5, pulse * .5);
    canvas.drawPath(paths[0], paint);
    canvas.restore();
  }
}
