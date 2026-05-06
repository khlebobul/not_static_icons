import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Drumstick Icon - original SVG arcs make a small tap
class DrumstickIcon extends AnimatedSVGIcon {
  const DrumstickIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 850),
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
  String get animationDescription => 'Drumstick swings around its knob';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) =>
      _DrumstickPainter(color, animationValue, strokeWidth);
}

class _DrumstickPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _DrumstickPainter(this.color, this.animationValue, this.strokeWidth);

  @override
  void paint(Canvas canvas, Size size) {
    final s = size.width / 24.0;
    final paint = _paint(color, strokeWidth);
    final t = animationValue.clamp(0.0, 1.0);
    final swing = t == 0 ? 0.0 : math.sin(2 * math.pi * t) * 0.32;
    final pivot = Offset(5.5 * s, 18.5 * s);
    canvas.save();
    canvas.translate(pivot.dx, pivot.dy);
    canvas.rotate(swing);
    canvas.translate(-pivot.dx, -pivot.dy);
    final meat = Path()
      ..moveTo(15.4 * s, 15.63 * s)
      ..arcToPoint(
        Offset(21.63 * s, 9.4 * s),
        radius: Radius.elliptical(7.875 * s, 6 * s),
        rotation: 135,
        largeArc: true,
        clockwise: true,
      )
      ..arcToPoint(
        Offset(15.4 * s, 15.63 * s),
        radius: Radius.elliptical(4.5 * s, 3.43 * s),
        rotation: 135,
        clockwise: false,
      );
    canvas.drawPath(meat, paint);
    final bone = Path()
      ..moveTo(8.29 * s, 12.71 * s)
      ..lineTo(5.69 * s, 15.31 * s)
      ..arcToPoint(Offset(4.04 * s, 19.96 * s),
          radius: Radius.circular(2.5 * s), largeArc: true, clockwise: false)
      ..arcToPoint(Offset(8.7 * s, 18.3 * s),
          radius: Radius.circular(2.5 * s), largeArc: true, clockwise: false)
      ..lineTo(11.29 * s, 15.71 * s);
    canvas.drawPath(bone, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(_DrumstickPainter old) =>
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
