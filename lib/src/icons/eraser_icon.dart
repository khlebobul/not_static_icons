import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Eraser Icon - Eraser slides as if erasing
class EraserIcon extends AnimatedSVGIcon {
  const EraserIcon({
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
  String get animationDescription => 'Eraser slides diagonally as if erasing';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) =>
      _EraserPainter(color, animationValue, strokeWidth);
}

class _EraserPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _EraserPainter(this.color, this.animationValue, this.strokeWidth);

  @override
  void paint(Canvas canvas, Size size) {
    final s = size.width / 24.0;
    final paint = _paint(color, strokeWidth);
    final t = animationValue.clamp(0.0, 1.0);
    final shake = math.sin(t * math.pi * 4) * 1.0 * s;

    canvas.save();
    canvas.translate(shake, -shake);

    final body = Path()
      ..moveTo(21 * s, 21 * s)
      ..lineTo(8 * s, 21 * s)
      ..arcToPoint(Offset(6.58 * s, 20.413 * s),
          radius: Radius.circular(2 * s), clockwise: true)
      ..lineTo(2.586 * s, 16.414 * s)
      ..arcToPoint(Offset(2.586 * s, 13.586 * s),
          radius: Radius.circular(2 * s), clockwise: true)
      ..lineTo(12.586 * s, 3.586 * s)
      ..arcToPoint(Offset(15.415 * s, 3.586 * s),
          radius: Radius.circular(2 * s), clockwise: true)
      ..lineTo(21.414 * s, 9.586 * s)
      ..arcToPoint(Offset(21.414 * s, 12.414 * s),
          radius: Radius.circular(2 * s), clockwise: true)
      ..lineTo(12.834 * s, 21 * s);
    final crease = Path()
      ..moveTo(5.082 * s, 11.09 * s)
      ..lineTo(13.91 * s, 19.918 * s);

    canvas.drawPath(body, paint);
    canvas.drawPath(crease, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(_EraserPainter old) =>
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
