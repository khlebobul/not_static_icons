import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Bike Icon - wheels spin slightly and frame draws to imply motion
class BikeIcon extends AnimatedSVGIcon {
  const BikeIcon({
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
  });

  @override
  String get animationDescription =>
      'Bike: wheels spin a bit, frame draws progressively';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) =>
      _BikePainter(
        color: color,
        animationValue: animationValue,
        strokeWidth: strokeWidth,
      );
}

class _BikePainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _BikePainter({
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

    final scale = size.width / 24.0;

    // Wheels: circles spin subtly by drawing arcs according to animation
    _drawWheel(canvas, scale, paint,
        center: Offset(18.5 * scale, 17.5 * scale), radius: 3.5 * scale);
    _drawWheel(canvas, scale, paint,
        center: Offset(5.5 * scale, 17.5 * scale), radius: 3.5 * scale);

    // Head light/handle circle: <circle cx="15" cy="5" r="1"/>
    canvas.drawCircle(Offset(15 * scale, 5 * scale), 1 * scale, paint);

    // Frame path: M12 17.5 V14 l-3 -3 4 -3 2 3 h2
    final frame = Path()
      ..moveTo(12 * scale, 17.5 * scale)
      ..lineTo(12 * scale, 14 * scale)
      ..relativeLineTo(-3 * scale, -3 * scale)
      ..relativeLineTo(4 * scale, -3 * scale)
      ..relativeLineTo(2 * scale, 3 * scale)
      ..relativeLineTo(2 * scale, 0);

    if (animationValue == 0.0) {
      canvas.drawPath(frame, paint);
    } else {
      final m = frame.computeMetrics().first;
      final p = m.extractPath(0.0, m.length * animationValue);
      canvas.drawPath(p, paint);
    }
  }

  void _drawWheel(Canvas canvas, double scale, Paint paint,
      {required Offset center, required double radius}) {
    if (animationValue == 0.0) {
      canvas.drawCircle(center, radius, paint);
      return;
    }
    final sweep = 2 * math.pi * (0.25 + 0.5 * animationValue); // 90°..180°
    final start = -math.pi / 2 + 2 * math.pi * animationValue * 0.5;
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), start,
        sweep, false, paint);
  }

  @override
  bool shouldRepaint(_BikePainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
