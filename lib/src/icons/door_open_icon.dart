import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Door Open Icon - light rays appear from the open doorway
class DoorOpenIcon extends AnimatedSVGIcon {
  const DoorOpenIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 800),
    super.strokeWidth = 2.0,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
    super.resetToStartOnComplete = true,
    super.onTap,
    super.interactive,
    super.controller,
  });

  @override
  String get animationDescription => 'Light rays appear from open doorway';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) =>
      _DoorOpenPainter(color, animationValue, strokeWidth);
}

class _DoorOpenPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _DoorOpenPainter(this.color, this.animationValue, this.strokeWidth);

  @override
  void paint(Canvas canvas, Size size) {
    final s = size.width / 24.0;
    final paint = _paint(color, strokeWidth);
    final t = animationValue.clamp(0.0, 1.0);

    canvas.drawLine(Offset(11 * s, 20 * s), Offset(2 * s, 20 * s), paint);
    final frame = Path()
      ..moveTo(11 * s, 4 * s)
      ..lineTo(8 * s, 4 * s)
      ..arcToPoint(
        Offset(6 * s, 6 * s),
        radius: Radius.circular(2 * s),
        clockwise: false,
      )
      ..lineTo(6 * s, 20 * s);
    canvas.drawPath(frame, paint);
    canvas.drawLine(Offset(22 * s, 20 * s), Offset(19 * s, 20 * s), paint);

    final panel = Path()
      ..moveTo(11 * s, 4.562 * s)
      ..lineTo(11 * s, 20.719 * s)
      ..arcToPoint(
        Offset(12.242 * s, 21.689 * s),
        radius: Radius.circular(1 * s),
        clockwise: false,
      )
      ..lineTo(19 * s, 20 * s)
      ..lineTo(19 * s, 5.562 * s)
      ..arcToPoint(
        Offset(17.485 * s, 3.622 * s),
        radius: Radius.circular(2 * s),
        clockwise: false,
      )
      ..lineTo(13.485 * s, 2.622 * s)
      ..arcToPoint(
        Offset(11 * s, 4.561 * s),
        radius: Radius.circular(2 * s),
        clockwise: false,
      );
    canvas.drawPath(panel, paint);
    canvas.drawLine(Offset(14 * s, 12 * s), Offset(14.01 * s, 12 * s), paint);

    if (t == 0.0) return;

    // Light from the open doorway: rays grow out and fade back on completion.
    final rayPaint = _paint(color, strokeWidth);
    final rayT = t <= 0.5 ? t / 0.5 : (1.0 - t) / 0.5;
    final rayLength = rayT.clamp(0.0, 1.0);
    final rays = [
      (Offset(9.4 * s, 8 * s), Offset(6.8 * s, 6.2 * s)),
      (Offset(9.2 * s, 12 * s), Offset(5.8 * s, 12 * s)),
      (Offset(9.4 * s, 16 * s), Offset(6.8 * s, 17.8 * s)),
    ];

    for (final ray in rays) {
      final start = ray.$1;
      final end = ray.$2;
      final current = Offset(
        start.dx + (end.dx - start.dx) * rayLength,
        start.dy + (end.dy - start.dy) * rayLength,
      );
      canvas.drawLine(start, current, rayPaint);
    }
  }

  @override
  bool shouldRepaint(_DoorOpenPainter old) =>
      old.color != color ||
      old.animationValue != animationValue ||
      old.strokeWidth != strokeWidth;
}

Paint _paint(Color color, double strokeWidth) {
  return Paint()
    ..color = color
    ..strokeWidth = strokeWidth
    ..strokeCap = StrokeCap.round
    ..strokeJoin = StrokeJoin.round
    ..style = PaintingStyle.stroke;
}
