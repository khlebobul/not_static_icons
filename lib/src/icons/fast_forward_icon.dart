import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Fast Forward Icon - chevrons pulse forward
class FastForwardIcon extends AnimatedSVGIcon {
  const FastForwardIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 600),
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
  String get animationDescription => 'Chevrons pulse forward';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) =>
      _FastForwardPainter(color, animationValue, strokeWidth);
}

class _FastForwardPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _FastForwardPainter(this.color, this.animationValue, this.strokeWidth);

  @override
  void paint(Canvas canvas, Size size) {
    final s = size.width / 24.0;
    final paint = _paint(color, strokeWidth);
    final t = animationValue.clamp(0.0, 1.0);

    // Shift both chevrons to the right in an arc
    final dx = math.sin(math.pi * t) * 1.2 * s;
    canvas.save();
    canvas.translate(dx, 0);

    // Right chevron: M12 6a2 2 0 0 1 3.414-1.414l6 6a2 2 0 0 1 0 2.828l-6 6A2 2 0 0 1 12 18z
    final right = Path()
      ..moveTo(12 * s, 6 * s)
      ..arcToPoint(Offset(15.414 * s, 4.586 * s),
          radius: Radius.circular(2 * s), clockwise: true)
      ..lineTo(21.414 * s, 10.586 * s)
      ..arcToPoint(Offset(21.414 * s, 13.414 * s),
          radius: Radius.circular(2 * s), clockwise: true)
      ..lineTo(15.414 * s, 19.414 * s)
      ..arcToPoint(Offset(12 * s, 18 * s),
          radius: Radius.circular(2 * s), clockwise: true)
      ..close();
    canvas.drawPath(right, paint);

    // Left chevron: M2 6a2 2 0 0 1 3.414-1.414l6 6a2 2 0 0 1 0 2.828l-6 6A2 2 0 0 1 2 18z
    final left = Path()
      ..moveTo(2 * s, 6 * s)
      ..arcToPoint(Offset(5.414 * s, 4.586 * s),
          radius: Radius.circular(2 * s), clockwise: true)
      ..lineTo(11.414 * s, 10.586 * s)
      ..arcToPoint(Offset(11.414 * s, 13.414 * s),
          radius: Radius.circular(2 * s), clockwise: true)
      ..lineTo(5.414 * s, 19.414 * s)
      ..arcToPoint(Offset(2 * s, 18 * s),
          radius: Radius.circular(2 * s), clockwise: true)
      ..close();
    canvas.drawPath(left, paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(_FastForwardPainter old) =>
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
