import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Bell Check Icon - bell swings while the check mark draws in
class BellCheckIcon extends AnimatedSVGIcon {
  const BellCheckIcon({
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
  String get animationDescription => 'Bell swings; check mark draws in';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return _BellCheckPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class _BellCheckPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _BellCheckPainter({
    required this.color,
    required this.animationValue,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;

    final double s = size.width / 24.0;
    final double t = animationValue.clamp(0.0, 1.0);

    final Offset pivot = Offset(12 * s, 8 * s);
    final double angle = 0.16 * math.sin(math.pi * t);

    canvas.save();
    canvas.translate(pivot.dx, pivot.dy);
    canvas.rotate(angle);
    canvas.translate(-pivot.dx, -pivot.dy);
    _drawClapper(canvas, s, paint);
    _drawBody(canvas, s, paint);
    canvas.restore();

    _drawCheck(canvas, s, paint, t);
  }

  void _drawClapper(Canvas canvas, double s, Paint paint) {
    final Path clapper = Path()
      ..moveTo(10.268 * s, 21 * s)
      ..arcToPoint(
        Offset(13.732 * s, 21 * s),
        radius: Radius.circular(2 * s),
        clockwise: false,
      );
    canvas.drawPath(clapper, paint);
  }

  void _drawBody(Canvas canvas, double s, Paint paint) {
    // Path 3 from bell-check.svg:
    // M16.8607 4.4824A6 6 0 0 0 6 8C6 12.499 4.589 13.956 3.262 15.326
    final Path leftBody = Path()
      ..moveTo(16.8607 * s, 4.4824 * s)
      ..arcToPoint(
        Offset(6 * s, 8 * s),
        radius: Radius.circular(6 * s),
        clockwise: false,
      )
      ..cubicTo(
        6 * s,
        12.499 * s,
        4.589 * s,
        13.956 * s,
        3.262 * s,
        15.326 * s,
      );
    canvas.drawPath(leftBody, paint);

    // Path 4 from bell-check.svg:
    // M3.262 15.326A1 1 0 0 0 4 17H20A1 1 0 0 0 20.74 15.327
    // C20.209 14.779 19.665 14.218 19.203 13.454
    final Path bottomBody = Path()
      ..moveTo(3.262 * s, 15.326 * s)
      ..arcToPoint(
        Offset(4 * s, 17 * s),
        radius: Radius.circular(1 * s),
        clockwise: false,
      )
      ..lineTo(20 * s, 17 * s)
      ..arcToPoint(
        Offset(20.74 * s, 15.327 * s),
        radius: Radius.circular(1 * s),
        clockwise: false,
      )
      ..cubicTo(
        20.209 * s,
        14.779 * s,
        19.665 * s,
        14.218 * s,
        19.203 * s,
        13.454 * s,
      );
    canvas.drawPath(bottomBody, paint);
  }

  void _drawCheck(Canvas canvas, double s, Paint paint, double t) {
    final Path check = Path()
      ..moveTo(15 * s, 8 * s)
      ..lineTo(17 * s, 10 * s)
      ..lineTo(21 * s, 6 * s);

    if (t == 0.0) {
      canvas.drawPath(check, paint);
      return;
    }

    final double checkProgress = ((t - 0.2) / 0.8).clamp(0.0, 1.0);
    final Path out = Path();
    for (final metric in check.computeMetrics()) {
      final double end = metric.length * checkProgress;
      if (end > 0) {
        out.addPath(metric.extractPath(0, end), Offset.zero);
      }
    }
    canvas.drawPath(out, paint);
  }

  @override
  bool shouldRepaint(_BellCheckPainter old) =>
      old.color != color ||
      old.animationValue != animationValue ||
      old.strokeWidth != strokeWidth;
}
