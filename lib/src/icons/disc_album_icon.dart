import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Disc Album Icon - visible groove spins inside the sleeve
class DiscAlbumIcon extends AnimatedSVGIcon {
  const DiscAlbumIcon({
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
  String get animationDescription => 'Visible groove spins inside album sleeve';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) =>
      _DiscAlbumPainter(color, animationValue, strokeWidth);
}

class _DiscAlbumPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _DiscAlbumPainter(this.color, this.animationValue, this.strokeWidth);

  @override
  void paint(Canvas canvas, Size size) {
    final s = size.width / 24.0;
    final paint = _paint(color, strokeWidth);
    final t = animationValue.clamp(0.0, 1.0);
    final center = Offset(12 * s, 12 * s);

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(3 * s, 3 * s, 18 * s, 18 * s),
        Radius.circular(2 * s),
      ),
      paint,
    );

    canvas.drawCircle(center, 5 * s, paint);
    canvas.drawLine(center, Offset(12.01 * s, 12 * s), paint);

    if (t == 0.0) return;

    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(2 * math.pi * t);
    canvas.translate(-center.dx, -center.dy);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: 3.4 * s),
      -0.45,
      0.9,
      false,
      paint,
    );
    canvas.drawLine(Offset(12 * s, 7.2 * s), Offset(12 * s, 9.2 * s), paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(_DiscAlbumPainter old) =>
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
