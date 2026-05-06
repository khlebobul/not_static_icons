import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Delete Icon - keycap presses left and X flashes on hover/tap
class DeleteIcon extends AnimatedSVGIcon {
  const DeleteIcon({
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
  String get animationDescription => 'Delete key presses left; X flashes';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) =>
      _DeletePainter(color, animationValue, strokeWidth);
}

class _DeletePainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _DeletePainter(this.color, this.animationValue, this.strokeWidth);

  @override
  void paint(Canvas canvas, Size size) {
    final s = size.width / 24.0;
    final paint = _strokePaint(color, strokeWidth);
    final t = animationValue.clamp(0.0, 1.0);
    final dx = -math.sin(math.pi * t) * 1.6 * s;

    canvas.save();
    canvas.translate(dx, 0);
    final key = Path()
      ..moveTo(10 * s, 5 * s)
      ..arcToPoint(
        Offset(8.656 * s, 5.519 * s),
        radius: Radius.circular(2 * s),
        clockwise: false,
      )
      ..lineTo(2.328 * s, 11.259 * s)
      ..arcToPoint(
        Offset(2.328 * s, 12.74 * s),
        radius: Radius.circular(1 * s),
        clockwise: false,
      )
      ..lineTo(8.656 * s, 18.481 * s)
      ..arcToPoint(
        Offset(10 * s, 19 * s),
        radius: Radius.circular(2 * s),
        clockwise: false,
      )
      ..lineTo(20 * s, 19 * s)
      ..arcToPoint(
        Offset(22 * s, 17 * s),
        radius: Radius.circular(2 * s),
        clockwise: false,
      )
      ..lineTo(22 * s, 7 * s)
      ..arcToPoint(
        Offset(20 * s, 5 * s),
        radius: Radius.circular(2 * s),
        clockwise: false,
      )
      ..close();
    canvas.drawPath(key, paint);
    canvas.restore();

    final xPaint = _strokePaint(
        color.withValues(
            alpha: t == 0.0 ? 1 : 0.35 + 0.65 * math.sin(math.pi * t)),
        strokeWidth);
    canvas.drawLine(
        Offset(12 * s + dx, 9 * s), Offset(18 * s + dx, 15 * s), xPaint);
    canvas.drawLine(
        Offset(18 * s + dx, 9 * s), Offset(12 * s + dx, 15 * s), xPaint);
  }

  @override
  bool shouldRepaint(_DeletePainter old) =>
      old.color != color ||
      old.animationValue != animationValue ||
      old.strokeWidth != strokeWidth;
}

Paint _strokePaint(Color color, double strokeWidth) {
  return Paint()
    ..color = color
    ..strokeWidth = strokeWidth
    ..strokeCap = StrokeCap.round
    ..strokeJoin = StrokeJoin.round
    ..style = PaintingStyle.stroke;
}
