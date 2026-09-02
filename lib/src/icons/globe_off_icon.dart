import 'package:flutter/material.dart';

import '../core/draw_icon_base.dart';

class GlobeOffIcon extends DrawIconBase {
  const GlobeOffIcon({
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
  String get animationDescription => 'Disable slash slides across the globe';

  @override
  List<Path> get paths => [
        Path()
          ..moveTo(10.114, 4.462)
          ..arcToPoint(const Offset(12, 2), radius: const Radius.circular(14.5))
          ..arcToPoint(const Offset(21.313, 15.643),
              radius: const Radius.circular(10)),
        Path()
          ..moveTo(15.557, 15.556)
          ..arcToPoint(const Offset(12, 22),
              radius: const Radius.circular(14.5))
          ..arcToPoint(const Offset(4.929, 4.929),
              radius: const Radius.circular(10)),
        Path()
          ..moveTo(15.892, 10.234)
          ..arcToPoint(const Offset(12, 2),
              radius: const Radius.circular(14.5), clockwise: false)
          ..arcToPoint(const Offset(8.357, 2.687),
              radius: const Radius.circular(10), clockwise: false),
        Path()
          ..moveTo(17.656, 12)
          ..lineTo(22, 12),
        Path()
          ..moveTo(19.071, 19.071)
          ..arcToPoint(const Offset(12, 22), radius: const Radius.circular(10))
          ..arcToPoint(const Offset(8.44, 8.45),
              radius: const Radius.circular(14.5)),
        Path()
          ..moveTo(2, 12)
          ..lineTo(12, 12),
        Path()
          ..moveTo(2, 2)
          ..lineTo(22, 22),
      ];

  @override
  void paintIcon(Canvas canvas, Paint paint, double animationValue) {
    drawIconPaths(canvas, paint, paths.take(6));
    canvas.save();
    canvas.translate(
        iconWave(animationValue) * .9, iconWave(animationValue) * .9);
    canvas.drawPath(paths[6], paint);
    canvas.restore();
  }
}
