import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Feather Icon - feather sways gently around its quill tip
class FeatherIcon extends AnimatedSVGIcon {
  const FeatherIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 900),
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
  String get animationDescription => 'Feather sways gently';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) =>
      _FeatherPainter(color, animationValue, strokeWidth);
}

class _FeatherPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _FeatherPainter(this.color, this.animationValue, this.strokeWidth);

  @override
  void paint(Canvas canvas, Size size) {
    final s = size.width / 24.0;
    final paint = _paint(color, strokeWidth);
    final t = animationValue.clamp(0.0, 1.0);

    // Sway around quill tip at (2, 22)
    final pivot = Offset(2 * s, 22 * s);
    canvas.save();
    canvas.translate(pivot.dx, pivot.dy);
    canvas.rotate(math.sin(math.pi * t) * 0.10);
    canvas.translate(-pivot.dx, -pivot.dy);

    // Feather outline:
    // M12.67 19a2 2 0 0 0 1.416-.588l6.154-6.172a6 6 0 0 0-8.49-8.49
    //   L5.586 9.914A2 2 0 0 0 5 11.328V18a1 1 0 0 0 1 1z
    final outline = Path()
      ..moveTo(12.67 * s, 19 * s)
      ..arcToPoint(Offset(14.086 * s, 18.412 * s),
          radius: Radius.circular(2 * s), clockwise: false)
      ..lineTo(20.24 * s, 12.24 * s)
      ..arcToPoint(Offset(11.75 * s, 3.75 * s),
          radius: Radius.circular(6 * s), clockwise: false)
      ..lineTo(5.586 * s, 9.914 * s)
      ..arcToPoint(Offset(5 * s, 11.328 * s),
          radius: Radius.circular(2 * s), clockwise: false)
      ..lineTo(5 * s, 18 * s)
      ..arcToPoint(Offset(6 * s, 19 * s),
          radius: Radius.circular(1 * s), clockwise: false)
      ..close();
    canvas.drawPath(outline, paint);

    // Quill line: M16 8 2 22
    canvas.drawLine(Offset(16 * s, 8 * s), Offset(2 * s, 22 * s), paint);

    // Barb line: M17.5 15H9
    canvas.drawLine(Offset(17.5 * s, 15 * s), Offset(9 * s, 15 * s), paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(_FeatherPainter old) =>
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
