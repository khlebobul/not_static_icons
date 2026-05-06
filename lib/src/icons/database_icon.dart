import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Database Icon - middle layer ripples on hover/tap
class DatabaseIcon extends AnimatedSVGIcon {
  const DatabaseIcon({
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
  String get animationDescription => 'Database middle layer ripples';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) =>
      _DatabasePainter(color, animationValue, strokeWidth);
}

class _DatabasePainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _DatabasePainter(this.color, this.animationValue, this.strokeWidth);

  @override
  void paint(Canvas canvas, Size size) {
    final s = size.width / 24.0;
    final paint = _strokePaint(color, strokeWidth);
    final t = animationValue.clamp(0.0, 1.0);

    _drawDatabaseTop(canvas, s, paint);
    _drawDatabaseBody(canvas, s, paint);

    final dy = t == 0.0 ? 0.0 : math.sin(math.pi * t) * 1.2 * s;
    canvas.save();
    canvas.translate(0, dy);
    _drawDatabaseMiddle(canvas, s, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(_DatabasePainter old) =>
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

void _drawDatabaseTop(Canvas canvas, double s, Paint paint) {
  canvas.drawOval(
    Rect.fromCenter(
      center: Offset(12 * s, 5 * s),
      width: 18 * s,
      height: 6 * s,
    ),
    paint,
  );
}

void _drawDatabaseBody(Canvas canvas, double s, Paint paint) {
  final body = Path()
    ..moveTo(3 * s, 5 * s)
    ..lineTo(3 * s, 19 * s)
    ..arcToPoint(
      Offset(21 * s, 19 * s),
      radius: Radius.elliptical(9 * s, 3 * s),
      clockwise: false,
    )
    ..lineTo(21 * s, 5 * s);
  canvas.drawPath(body, paint);
}

void _drawDatabaseMiddle(Canvas canvas, double s, Paint paint) {
  final middle = Path()
    ..moveTo(3 * s, 12 * s)
    ..arcToPoint(
      Offset(21 * s, 12 * s),
      radius: Radius.elliptical(9 * s, 3 * s),
      clockwise: false,
    );
  canvas.drawPath(middle, paint);
}
