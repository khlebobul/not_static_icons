import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Download Icon - original arrow pulses into the tray
class DownloadIcon extends AnimatedSVGIcon {
  const DownloadIcon({
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
  String get animationDescription => 'Arrow pulses into the tray';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) =>
      _DownloadPainter(color, animationValue, strokeWidth);
}

class _DownloadPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _DownloadPainter(this.color, this.animationValue, this.strokeWidth);

  @override
  void paint(Canvas canvas, Size size) {
    final s = size.width / 24.0;
    final paint = _paint(color, strokeWidth);
    final t = animationValue.clamp(0.0, 1.0);

    final tray = Path()
      ..moveTo(21 * s, 15 * s)
      ..lineTo(21 * s, 19 * s)
      ..arcToPoint(Offset(19 * s, 21 * s),
          radius: Radius.circular(2 * s), clockwise: true)
      ..lineTo(5 * s, 21 * s)
      ..arcToPoint(Offset(3 * s, 19 * s),
          radius: Radius.circular(2 * s), clockwise: true)
      ..lineTo(3 * s, 15 * s);
    canvas.drawPath(tray, paint);

    final dy = t == 0 ? 0.0 : math.sin(math.pi * t) * 1.2 * s;
    canvas.save();
    canvas.translate(0, dy);
    canvas.drawLine(Offset(12 * s, 3 * s), Offset(12 * s, 15 * s), paint);
    final arrow = Path()
      ..moveTo(7 * s, 10 * s)
      ..lineTo(12 * s, 15 * s)
      ..lineTo(17 * s, 10 * s);
    canvas.drawPath(arrow, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(_DownloadPainter old) =>
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
