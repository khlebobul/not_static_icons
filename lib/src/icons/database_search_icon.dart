import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Database Search Icon - magnifier scans around the database
class DatabaseSearchIcon extends AnimatedSVGIcon {
  const DatabaseSearchIcon({
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
  String get animationDescription => 'Magnifier scans the database';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) =>
      _DatabaseSearchPainter(color, animationValue, strokeWidth);
}

class _DatabaseSearchPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _DatabaseSearchPainter(this.color, this.animationValue, this.strokeWidth);

  @override
  void paint(Canvas canvas, Size size) {
    final s = size.width / 24.0;
    final paint = _strokePaint(color, strokeWidth);
    final t = animationValue.clamp(0.0, 1.0);

    canvas.drawLine(Offset(21 * s, 11.693 * s), Offset(21 * s, 5 * s), paint);
    final mid = Path()
      ..moveTo(3 * s, 12 * s)
      ..arcToPoint(
        Offset(11.697 * s, 14.998 * s),
        radius: Radius.elliptical(9 * s, 3 * s),
        clockwise: false,
      );
    canvas.drawPath(mid, paint);
    final body = Path()
      ..moveTo(3 * s, 5 * s)
      ..lineTo(3 * s, 19 * s)
      ..arcToPoint(
        Offset(12.28 * s, 21.999 * s),
        radius: Radius.elliptical(9 * s, 3 * s),
        clockwise: false,
      );
    canvas.drawPath(body, paint);
    _drawDatabaseTop(canvas, s, paint);

    final scan = t == 0.0 ? 0.0 : math.sin(math.pi * t) * 1.2 * s;
    canvas.save();
    canvas.translate(-scan, -scan * 0.35);
    canvas.drawCircle(Offset(18 * s, 18 * s), 3 * s, paint);
    canvas.drawLine(
        Offset(20.125 * s, 20.125 * s), Offset(22 * s, 22 * s), paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(_DatabaseSearchPainter old) =>
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
