import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Eye Closed Icon - Lashes bounce
class EyeClosedIcon extends AnimatedSVGIcon {
  const EyeClosedIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 700),
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
  String get animationDescription => 'Closed eye lashes bounce outward';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) =>
      _EyeClosedPainter(color, animationValue, strokeWidth);
}

class _EyeClosedPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _EyeClosedPainter(this.color, this.animationValue, this.strokeWidth);

  @override
  void paint(Canvas canvas, Size size) {
    final s = size.width / 24.0;
    final paint = _paint(color, strokeWidth);
    final t = animationValue.clamp(0.0, 1.0);
    final bounce = math.sin(math.pi * t);
    final d = bounce * 1.2 * s;

    // Lid: M2 8a10.645 10.645 0 0 0 20 0
    final lid = Path()
      ..moveTo(2 * s, 8 * s)
      ..arcToPoint(Offset(22 * s, 8 * s),
          radius: Radius.circular(10.645 * s), clockwise: false);
    canvas.drawPath(lid, paint);

    // Lashes extend outward
    canvas.drawLine(
      Offset(15 * s, 18 * s),
      Offset(15 * s - 0.722 * s * 0.3, (18 - 3.25) * s - d),
      paint,
    );
    canvas.drawLine(
      Offset(9 * s, 18 * s),
      Offset(9 * s + 0.722 * s * 0.3, (18 - 3.25) * s - d),
      paint,
    );
    canvas.drawLine(
      Offset(20 * s, 15 * s),
      Offset((20 - 1.726) * s + d * 0.3, (15 - 2.05) * s - d),
      paint,
    );
    canvas.drawLine(
      Offset(4 * s, 15 * s),
      Offset((4 + 1.726) * s - d * 0.3, (15 - 2.05) * s - d),
      paint,
    );
  }

  @override
  bool shouldRepaint(_EyeClosedPainter old) =>
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
