import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Beer Off Icon - initial state matches lucide beer-off; top foam gently moves; slash present
class BeerOffIcon extends AnimatedSVGIcon {
  const BeerOffIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 1200),
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
  String get animationDescription =>
      'Top foam gently bobs and tilts; slash static';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return _BeerOffPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class _BeerOffPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _BeerOffPainter({
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

    // ========== STATIC: original beer-off.svg ==========
    // Columns: M13 13v5, M17 11.47V8, M9 14.6V18
    canvas.drawLine(Offset(13 * s, 13 * s), Offset(13 * s, 18 * s), paint);
    canvas.drawLine(Offset(17 * s, 11.47 * s), Offset(17 * s, 8 * s), paint);
    canvas.drawLine(Offset(9 * s, 14.6 * s), Offset(9 * s, 18 * s), paint);

    // Handle path pieces: M17 11h1 a3 3 0 0 1 2.745 4.211
    final Path handle = Path()
      ..moveTo(17 * s, 11 * s)
      ..lineTo(18 * s, 11 * s)
      ..arcToPoint(
        Offset(20.745 * s, 15.211 * s),
        radius: Radius.circular(3 * s),
        clockwise: true,
      );
    canvas.drawPath(handle, paint);

    // Mug body: M5 8 v12 a2 2 0 0 0 2 2 h8 a2 2 0 0 0 2-2 v-3
    final Path body = Path()
      ..moveTo(5 * s, 8 * s)
      ..lineTo(5 * s, 20 * s)
      ..arcToPoint(
        Offset(7 * s, 22 * s),
        radius: Radius.circular(2 * s),
        clockwise: false,
      )
      ..lineTo(15 * s, 22 * s)
      ..arcToPoint(
        Offset(17 * s, 20 * s),
        radius: Radius.circular(2 * s),
        clockwise: false,
      )
      ..lineTo(17 * s, 17 * s);
    canvas.drawPath(body, paint);

    // Foam/Top strokes from svg (exact segments)
    // Path 1: M7.536 7.535 C6.766 7.649 6.154 8 5.5 8
    final Path foam1 = Path()
      ..moveTo(7.536 * s, 7.535 * s)
      ..cubicTo(6.766 * s, 7.649 * s, 6.154 * s, 8 * s, 5.5 * s, 8 * s);
    // draw later depending on animation state
    // Path 2: M5.5 8 a2.5 2.5 0 0 1 -1.768 -4.268
    final Path foam2 = Path()
      ..moveTo(5.5 * s, 8 * s)
      ..arcToPoint(
        Offset((5.5 - 1.768) * s, (8 - 4.268) * s),
        radius: Radius.circular(2.5 * s),
        clockwise: true,
      );
    // draw later depending on animation state
    // Path 3: M8.727 3.204 C9.306 2.767 9.885 2 11 2 c1.56 0 2 1.5 3 1.5 s1.72-.5 2.5-.5 a1 1 0 1 1 0 5 c-.78 0-1.5-.5-2.5-.5 a3.149 3.149 0 0 0 -.842 .12
    final Path foam3 = Path()
      ..moveTo(8.727 * s, 3.204 * s)
      ..cubicTo(9.306 * s, 2.767 * s, 9.885 * s, 2 * s, 11 * s, 2 * s)
      ..relativeCubicTo(1.56 * s, 0, 2 * s, 1.5 * s, 3 * s, 1.5 * s)
      ..relativeCubicTo(
          1.72 * s, -0.5 * s, 2.5 * s, -0.5 * s, 2.5 * s, -0.5 * s)
      ..arcToPoint(
        Offset(18.5 * s, 8 * s),
        radius: Radius.circular(1 * s),
        clockwise: true,
        rotation: 0,
        largeArc: false,
      )
      ..relativeCubicTo(-0.78 * s, 0, -1.5 * s, -0.5 * s, -2.5 * s, -0.5 * s)
      ..relativeCubicTo(-0.3 * s, 0, -0.57 * s, 0.04 * s, -0.842 * s, 0.12 * s);
    // draw later depending on animation state
    // ========== ANIMATED: foam bob/tilt (no bubbles) ==========
    final double t = animationValue.clamp(0.0, 1.0);
    if (t == 0.0) {
      // Draw as in original
      canvas.drawPath(foam1, paint);
      canvas.drawPath(foam2, paint);
      canvas.drawPath(foam3, paint);
    } else {
      final double wobbleY = 0.6 * s * math.sin(2 * math.pi * t);
      final double angle = 0.03 * math.sin(2 * math.pi * t);
      final Offset pivot = Offset(11 * s, 5.2 * s);
      canvas.save();
      canvas.translate(0, -wobbleY);
      canvas.translate(pivot.dx, pivot.dy);
      canvas.rotate(angle);
      canvas.translate(-pivot.dx, -pivot.dy);
      canvas.drawPath(foam1, paint);
      canvas.drawPath(foam2, paint);
      canvas.drawPath(foam3, paint);
      canvas.restore();
    }

    // Slash on top: m2 2 20 20
    canvas.drawLine(Offset(2 * s, 2 * s), Offset(22 * s, 22 * s), paint);
  }

  @override
  bool shouldRepaint(_BeerOffPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
