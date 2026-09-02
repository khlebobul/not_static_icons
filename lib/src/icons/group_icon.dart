import 'package:flutter/material.dart';

import '../core/draw_icon_base.dart';

class GroupIcon extends DrawIconBase {
  const GroupIcon({
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
  String get animationDescription => 'Group bounds expand as items separate';

  @override
  List<Path> get paths => [
        Path()
          ..moveTo(3, 7)
          ..lineTo(3, 5)
          ..cubicTo(3, 3.9, 3.9, 3, 5, 3)
          ..lineTo(7, 3),
        Path()
          ..moveTo(17, 3)
          ..lineTo(19, 3)
          ..cubicTo(20.1, 3, 21, 3.9, 21, 5)
          ..lineTo(21, 7),
        Path()
          ..moveTo(21, 17)
          ..lineTo(21, 19)
          ..cubicTo(21, 20.1, 20.1, 21, 19, 21)
          ..lineTo(17, 21),
        Path()
          ..moveTo(7, 21)
          ..lineTo(5, 21)
          ..cubicTo(3.9, 21, 3, 20.1, 3, 19)
          ..lineTo(3, 17),
        Path()
          ..addRRect(RRect.fromRectAndRadius(
              const Rect.fromLTWH(7, 7, 7, 5), const Radius.circular(1))),
        Path()
          ..addRRect(RRect.fromRectAndRadius(
              const Rect.fromLTWH(10, 12, 7, 5), const Radius.circular(1))),
      ];

  @override
  void paintIcon(Canvas canvas, Paint paint, double animationValue) {
    final pulse = iconPulse(animationValue);
    final offsets = [
      Offset(-pulse, -pulse),
      Offset(pulse, -pulse),
      Offset(pulse, pulse),
      Offset(-pulse, pulse)
    ];
    for (var i = 0; i < 4; i++) {
      canvas.save();
      canvas.translate(offsets[i].dx, offsets[i].dy);
      canvas.drawPath(paths[i], paint);
      canvas.restore();
    }
    canvas.save();
    canvas.translate(-pulse * .7, -pulse * .4);
    canvas.drawPath(paths[4], paint);
    canvas.restore();
    canvas.save();
    canvas.translate(pulse * .7, pulse * .4);
    canvas.drawPath(paths[5], paint);
    canvas.restore();
  }
}
