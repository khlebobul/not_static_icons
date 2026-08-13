import 'package:flutter/material.dart';

import '../core/draw_icon_base.dart';

class FrameIcon extends DrawIconBase {
  const FrameIcon({
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
  List<Path> get paths => [
        Path()
          ..moveTo(22, 6)
          ..lineTo(2, 6),
        Path()
          ..moveTo(22, 18)
          ..lineTo(2, 18),
        Path()
          ..moveTo(6, 2)
          ..lineTo(6, 22),
        Path()
          ..moveTo(18, 2)
          ..lineTo(18, 22),
      ];

  @override
  void paintIcon(Canvas canvas, Paint paint, double animationValue) {
    final expand = iconPulse(animationValue) * .8;
    final offsets = [
      Offset(0, -expand),
      Offset(0, expand),
      Offset(-expand, 0),
      Offset(expand, 0),
    ];
    for (var i = 0; i < paths.length; i++) {
      canvas.save();
      canvas.translate(offsets[i].dx, offsets[i].dy);
      drawIconPaths(canvas, paint, [paths[i]]);
      canvas.restore();
    }
  }
}
