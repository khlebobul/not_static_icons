import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Beer Icon - initial state matches lucide beer; top foam gently moves on animate
class BeerIcon extends AnimatedSVGIcon {
  const BeerIcon({
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
  String get animationDescription => 'Top foam gently bobs and tilts';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return _BeerPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class _BeerPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _BeerPainter({
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

    // ========== STATIC: original beer.svg ==========
    // Handle: M17 11 h1 a3 3 0 0 1 0 6 h-1
    final Path handle = Path()
      ..moveTo(17 * s, 11 * s)
      ..lineTo(18 * s, 11 * s)
      ..arcToPoint(
        Offset(18 * s, 17 * s),
        radius: Radius.circular(3 * s),
        clockwise: true,
      )
      ..lineTo(17 * s, 17 * s);
    canvas.drawPath(handle, paint);

    // Columns: M9 12v6, M13 12v6
    canvas.drawLine(Offset(9 * s, 12 * s), Offset(9 * s, 18 * s), paint);
    canvas.drawLine(Offset(13 * s, 12 * s), Offset(13 * s, 18 * s), paint);

    // Mug body: M5 8 v12 a2 2 0 0 0 2 2 h8 a2 2 0 0 0 2 -2 V8
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
      ..lineTo(17 * s, 8 * s);
    canvas.drawPath(body, paint);

    // Foam cap closed path from beer.svg translated exactly
    final Path foam = Path();
    // M14 7.5
    foam.moveTo(14 * s, 7.5 * s);
    // c -1 0 -1.44 .5 -3 .5 (relative cubic)
    foam.relativeCubicTo(-1 * s, 0, -1.44 * s, 0.5 * s, -3 * s, 0.5 * s);
    // s -2 -.5 -3 -.5 (smooth cubic computed explicitly)
    {
      final Offset cp = Offset(11 * s, 8 * s);
      final Offset prevC2 = Offset((14 - 1.44) * s, (7.5 + 0.5) * s);
      final Offset p1 = Offset(2 * cp.dx - prevC2.dx, 2 * cp.dy - prevC2.dy);
      final Offset c2 = Offset((11 - 2) * s, (8 - 0.5) * s);
      final Offset end = Offset((11 - 3) * s, (8 - 0.5) * s);
      foam.cubicTo(p1.dx, p1.dy, c2.dx, c2.dy, end.dx, end.dy);
    }
    // s -1.72 .5 -2.5 .5
    {
      final Offset cp = Offset(8 * s, 7.5 * s);
      final Offset prevC2 = Offset((11 - 2) * s, (8 - 0.5) * s);
      final Offset p1 = Offset(2 * cp.dx - prevC2.dx, 2 * cp.dy - prevC2.dy);
      final Offset c2 = Offset((8 - 1.72) * s, (7.5 + 0.5) * s);
      final Offset end = Offset((8 - 2.5) * s, (7.5 + 0.5) * s);
      foam.cubicTo(p1.dx, p1.dy, c2.dx, c2.dy, end.dx, end.dy);
    }
    // a 2.5 2.5 0 0 1 0 -5
    foam.relativeArcToPoint(Offset(0, -5 * s),
        radius: Radius.circular(2.5 * s), clockwise: true);
    // c .78 0 1.57 .5 2.5 .5
    foam.relativeCubicTo(0.78 * s, 0, 1.57 * s, 0.5 * s, 2.5 * s, 0.5 * s);
    // S 9.44 2 11 2 (absolute smooth cubic)
    {
      final Offset cp = Offset(8 * s, 3.5 * s);
      final Offset prevC2 = Offset((5.5 + 1.57) * s, (3 + 0.5) * s);
      final Offset p1 = Offset(2 * cp.dx - prevC2.dx, 2 * cp.dy - prevC2.dy);
      foam.cubicTo(p1.dx, p1.dy, 9.44 * s, 2 * s, 11 * s, 2 * s);
    }
    // s 2 1.5 3 1.5
    {
      final Offset cp = Offset(11 * s, 2 * s);
      final Offset prevC2 = Offset(9.44 * s, 2 * s);
      final Offset p1 = Offset(2 * cp.dx - prevC2.dx, 2 * cp.dy - prevC2.dy);
      final Offset c2 = Offset((11 + 2) * s, (2 + 1.5) * s);
      final Offset end = Offset((11 + 3) * s, (2 + 1.5) * s);
      foam.cubicTo(p1.dx, p1.dy, c2.dx, c2.dy, end.dx, end.dy);
    }
    // s 1.72 -.5 2.5 -.5
    {
      final Offset cp = Offset(14 * s, 3.5 * s);
      final Offset prevC2 = Offset((11 + 2) * s, (2 + 1.5) * s);
      final Offset p1 = Offset(2 * cp.dx - prevC2.dx, 2 * cp.dy - prevC2.dy);
      final Offset c2 = Offset((14 + 1.72) * s, (3.5 - 0.5) * s);
      final Offset end = Offset((14 + 2.5) * s, (3.5 - 0.5) * s);
      foam.cubicTo(p1.dx, p1.dy, c2.dx, c2.dy, end.dx, end.dy);
    }
    // a 2.5 2.5 0 0 1 0 5
    foam.relativeArcToPoint(Offset(0, 5 * s),
        radius: Radius.circular(2.5 * s), clockwise: true);
    // c -.78 0 -1.5 -.5 -2.5 -.5
    foam.relativeCubicTo(-0.78 * s, 0, -1.5 * s, -0.5 * s, -2.5 * s, -0.5 * s);
    foam.close();

    // ========== ANIMATED: foam bob/tilt (no bubbles) ==========
    final double t = animationValue.clamp(0.0, 1.0);
    if (t == 0.0) {
      canvas.drawPath(foam, paint);
    } else {
      final double wobbleY = 0.6 * s * math.sin(2 * math.pi * t);
      final double angle = 0.03 * math.sin(2 * math.pi * t);
      final Offset pivot = Offset(11 * s, 5.2 * s);
      canvas.save();
      canvas.translate(0, -wobbleY);
      canvas.translate(pivot.dx, pivot.dy);
      canvas.rotate(angle);
      canvas.translate(-pivot.dx, -pivot.dy);
      canvas.drawPath(foam, paint);
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(_BeerPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
