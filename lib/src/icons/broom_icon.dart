import 'package:flutter/material.dart';

import '../core/draw_icon_base.dart';

class BroomIcon extends DrawIconBase {
  const BroomIcon({
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
  String get animationDescription => 'Broom sweeps side to side';

  @override
  List<Path> get paths => _broomPaths;

  @override
  void paintIcon(Canvas canvas, Paint paint, double animationValue) {
    canvas.save();
    canvas.translate(13.5, 10.5);
    canvas.rotate(iconWave(animationValue) * .08);
    canvas.translate(-13.5, -10.5);
    drawIconPaths(canvas, paint, paths);
    canvas.restore();
  }
}

List<Path> get _broomPaths => [
      Path()
        ..moveTo(13.5, 10.5)
        ..lineTo(22, 2),
      Path()
        ..moveTo(14.734, 13.841)
        ..arcToPoint(
          const Offset(14.42, 11.421),
          radius: const Radius.circular(2),
          clockwise: false,
        )
        ..lineTo(12.58, 9.58)
        ..arcToPoint(
          const Offset(10.159, 9.266),
          radius: const Radius.circular(2),
          clockwise: false,
        )
        ..lineTo(2.502, 13.727)
        ..arcToPoint(
          const Offset(2.3, 15.3),
          radius: const Radius.circular(1),
          clockwise: false,
        )
        ..lineTo(8.703, 21.703)
        ..arcToPoint(
          const Offset(10.274, 21.499),
          radius: const Radius.circular(1),
          clockwise: false,
        )
        ..close(),
      Path()
        ..moveTo(5, 18)
        ..lineTo(7, 16),
      Path()
        ..moveTo(7.699, 10.7)
        ..lineTo(13.301, 16.301),
    ];
