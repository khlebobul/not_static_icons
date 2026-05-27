import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Factory Icon - machine indicator lights pulse in sequence
class FactoryIcon extends AnimatedSVGIcon {
  const FactoryIcon({
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
  String get animationDescription => 'Factory machine lights pulse';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) =>
      _FactoryPainter(color, animationValue, strokeWidth);
}

class _FactoryPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _FactoryPainter(this.color, this.animationValue, this.strokeWidth);

  @override
  void paint(Canvas canvas, Size size) {
    final s = size.width / 24.0;
    final paint = _paint(color, strokeWidth);
    final t = animationValue.clamp(0.0, 1.0);

    // Factory building:
    // M3 19a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2V8.5
    //   a.5.5 0 0 0-.769-.422l-4.462 2.844A.5.5 0 0 1 15 10.5v-2
    //   a.5.5 0 0 0-.769-.422L9.77 10.922A.5.5 0 0 1 9 10.5
    //   V5a2 2 0 0 0-2-2H5a2 2 0 0 0-2 2z
    final building = Path()
      ..moveTo(3 * s, 19 * s)
      ..arcToPoint(Offset(5 * s, 21 * s),
          radius: Radius.circular(2 * s), clockwise: false)
      ..lineTo(19 * s, 21 * s)
      ..arcToPoint(Offset(21 * s, 19 * s),
          radius: Radius.circular(2 * s), clockwise: false)
      ..lineTo(21 * s, 8.5 * s)
      // first conveyor flap (approx 0.5 r corners as straight lines)
      ..lineTo(20.231 * s, 8.078 * s)
      ..lineTo(15.769 * s, 10.922 * s)
      ..lineTo(15 * s, 10.5 * s)
      ..lineTo(15 * s, 8.5 * s)
      // second conveyor flap
      ..lineTo(14.231 * s, 8.078 * s)
      ..lineTo(9.77 * s, 10.922 * s)
      ..lineTo(9 * s, 10.5 * s)
      // tall left section
      ..lineTo(9 * s, 5 * s)
      ..arcToPoint(Offset(7 * s, 3 * s),
          radius: Radius.circular(2 * s), clockwise: false)
      ..lineTo(5 * s, 3 * s)
      ..arcToPoint(Offset(3 * s, 5 * s),
          radius: Radius.circular(2 * s), clockwise: false)
      ..close();
    canvas.drawPath(building, paint);

    // Machine indicator dots: M8 16h.01, M12 16h.01, M16 16h.01
    // Pulse left → center → right with sequential phase
    final dotPositions = [8.0, 12.0, 16.0];
    for (int i = 0; i < 3; i++) {
      final phase = i / 3.0;
      double alpha;
      if (t == 0) {
        alpha = 1.0;
      } else {
        alpha =
            (math.sin(2 * math.pi * (t - phase)).clamp(0.0, 1.0)).toDouble();
        if (alpha < 0) alpha = 0;
      }
      final dotPaint = Paint()
        ..color = color.withValues(alpha: alpha.clamp(0.3, 1.0))
        ..style = PaintingStyle.fill;
      canvas.drawCircle(
          Offset(dotPositions[i] * s, 16 * s), strokeWidth * 0.65, dotPaint);
    }
  }

  @override
  bool shouldRepaint(_FactoryPainter old) =>
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
