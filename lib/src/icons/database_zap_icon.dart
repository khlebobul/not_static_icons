import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Database Zap Icon - lightning bolt flashes next to the database
class DatabaseZapIcon extends AnimatedSVGIcon {
  const DatabaseZapIcon({
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
  String get animationDescription => 'Lightning bolt flashes';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) =>
      _DatabaseZapPainter(color, animationValue, strokeWidth);
}

class _DatabaseZapPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _DatabaseZapPainter(this.color, this.animationValue, this.strokeWidth);

  @override
  void paint(Canvas canvas, Size size) {
    final s = size.width / 24.0;
    final paint = _strokePaint(color, strokeWidth);
    final t = animationValue.clamp(0.0, 1.0);

    _drawDatabaseTop(canvas, s, paint);
    final body = Path()
      ..moveTo(3 * s, 5 * s)
      ..lineTo(3 * s, 19 * s)
      ..arcToPoint(
        Offset(15 * s, 21.84 * s),
        radius: Radius.elliptical(9 * s, 3 * s),
        clockwise: false,
      );
    canvas.drawPath(body, paint);
    canvas.drawLine(Offset(21 * s, 5 * s), Offset(21 * s, 8 * s), paint);
    final mid = Path()
      ..moveTo(3 * s, 12 * s)
      ..arcToPoint(
        Offset(14.59 * s, 14.87 * s),
        radius: Radius.elliptical(9 * s, 3 * s),
        clockwise: false,
      );
    canvas.drawPath(mid, paint);

    final bolt = Path()
      ..moveTo(21 * s, 12 * s)
      ..lineTo(18 * s, 17 * s)
      ..lineTo(22 * s, 17 * s)
      ..lineTo(19 * s, 22 * s);

    if (t == 0.0) {
      canvas.drawPath(bolt, paint);
    } else {
      final scale = 1.0 + 0.18 * math.sin(math.pi * t);
      final center = Offset(20 * s, 17 * s);
      canvas.save();
      canvas.translate(center.dx, center.dy);
      canvas.scale(scale, scale);
      canvas.translate(-center.dx, -center.dy);
      canvas.drawPath(_extractPath(bolt, _segment(t, 0.1, 0.85)), paint);
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(_DatabaseZapPainter old) =>
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

Path _extractPath(Path path, double fraction) {
  final out = Path();
  final f = fraction.clamp(0.0, 1.0);
  for (final metric in path.computeMetrics()) {
    final end = metric.length * f;
    if (end > 0) {
      out.addPath(metric.extractPath(0, end), Offset.zero);
    }
  }
  return out;
}

double _segment(double value, double start, double end) {
  return ((value - start) / (end - start)).clamp(0.0, 1.0);
}
