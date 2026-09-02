import 'package:flutter/material.dart';

import '../core/draw_icon_base.dart';

class GamepadDirectionalIcon extends DrawIconBase {
  const GamepadDirectionalIcon({
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
  String get animationDescription => 'Directional pads press toward the center';

  @override
  List<Path> get paths => [
        Path()
          ..moveTo(11.146, 15.854)
          ..arcToPoint(const Offset(12.854, 15.854),
              radius: const Radius.circular(1.207))
          ..lineTo(14.414, 17.414)
          ..arcToPoint(const Offset(15, 18.828),
              radius: const Radius.circular(2))
          ..lineTo(15, 21)
          ..arcToPoint(const Offset(14, 22), radius: const Radius.circular(1))
          ..lineTo(10, 22)
          ..arcToPoint(const Offset(9, 21), radius: const Radius.circular(1))
          ..lineTo(9, 18.828)
          ..arcToPoint(const Offset(9.586, 17.414),
              radius: const Radius.circular(2))
          ..close(),
        Path()
          ..moveTo(18.828, 15)
          ..arcToPoint(const Offset(17.414, 14.414),
              radius: const Radius.circular(2))
          ..lineTo(15.854, 12.854)
          ..arcToPoint(const Offset(15.854, 11.146),
              radius: const Radius.circular(1.207))
          ..lineTo(17.414, 9.586)
          ..arcToPoint(const Offset(18.828, 9),
              radius: const Radius.circular(2))
          ..lineTo(21, 9)
          ..arcToPoint(const Offset(22, 10), radius: const Radius.circular(1))
          ..lineTo(22, 14)
          ..arcToPoint(const Offset(21, 15), radius: const Radius.circular(1))
          ..close(),
        Path()
          ..moveTo(6.586, 14.414)
          ..arcToPoint(const Offset(5.172, 15),
              radius: const Radius.circular(2))
          ..lineTo(3, 15)
          ..arcToPoint(const Offset(2, 14), radius: const Radius.circular(1))
          ..lineTo(2, 10)
          ..arcToPoint(const Offset(3, 9), radius: const Radius.circular(1))
          ..lineTo(5.172, 9)
          ..arcToPoint(const Offset(6.586, 9.586),
              radius: const Radius.circular(2))
          ..lineTo(8.146, 11.146)
          ..arcToPoint(const Offset(8.146, 12.854),
              radius: const Radius.circular(1.207))
          ..close(),
        Path()
          ..moveTo(9, 3)
          ..arcToPoint(const Offset(10, 2), radius: const Radius.circular(1))
          ..lineTo(14, 2)
          ..arcToPoint(const Offset(15, 3), radius: const Radius.circular(1))
          ..lineTo(15, 5.172)
          ..arcToPoint(const Offset(14.414, 6.586),
              radius: const Radius.circular(2))
          ..lineTo(12.854, 8.146)
          ..arcToPoint(const Offset(11.146, 8.146),
              radius: const Radius.circular(1.207))
          ..lineTo(9.586, 6.586)
          ..arcToPoint(const Offset(9, 5.172), radius: const Radius.circular(2))
          ..close(),
      ];

  @override
  void paintIcon(Canvas canvas, Paint paint, double animationValue) {
    final pulse = iconPulse(animationValue) * .9;
    final offsets = [
      Offset(0, -pulse),
      Offset(-pulse, 0),
      Offset(pulse, 0),
      Offset(0, pulse)
    ];
    for (var i = 0; i < paths.length; i++) {
      canvas.save();
      canvas.translate(offsets[i].dx, offsets[i].dy);
      canvas.drawPath(paths[i], paint);
      canvas.restore();
    }
  }
}
