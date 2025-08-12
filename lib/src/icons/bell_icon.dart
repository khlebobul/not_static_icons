import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Bell Icon - classic bell swings slightly
class BellIcon extends AnimatedSVGIcon {
  const BellIcon({
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
  String get animationDescription => 'Bell swings gently';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return _BellPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class _BellPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _BellPainter({
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

    final double scale = size.width / 24.0;
    final Offset pivot = Offset(12 * scale, 8 * scale);
    final double angle = 0.18 * math.sin(math.pi * animationValue);

    // Clapper arc is attached to body, rotate together
    canvas.save();
    canvas.translate(pivot.dx, pivot.dy);
    canvas.rotate(angle);
    canvas.translate(-pivot.dx, -pivot.dy);

    // Initial state must equal original; body and clapper are always fully drawn
    _drawClapperArc(canvas, scale, paint);
    _drawBody(canvas, scale, paint);

    canvas.restore();
  }

  void _drawClapperArc(Canvas canvas, double scale, Paint paint) {
    // M10.268 21 a2 2 0 0 0 3.464 0
    final Path clapper = Path()
      ..moveTo(10.268 * scale, 21 * scale)
      ..arcToPoint(
        Offset(13.732 * scale, 21 * scale),
        radius: Radius.circular(2 * scale),
        clockwise: false,
      );
    canvas.drawPath(clapper, paint);
  }

  void _drawBody(Canvas canvas, double scale, Paint paint) {
    // M3.262 15.326 A1 1 0 0 0 4 17 h16 a1 1 0 0 0 .74-1.673
    // C19.41 13.956 18 12.499 18 8 A6 6 0 0 0 6 8
    // c0 4.499 -1.411 5.956 -2.738 7.326
    final Path body = Path()
      ..moveTo(3.262 * scale, 15.326 * scale)
      ..arcToPoint(
        Offset(4 * scale, 17 * scale),
        radius: Radius.circular(1 * scale),
        clockwise: false,
      )
      ..lineTo(20 * scale, 17 * scale)
      ..arcToPoint(
        Offset(20.74 * scale, 15.327 * scale),
        radius: Radius.circular(1 * scale),
        clockwise: false,
      )
      ..cubicTo(
        19.41 * scale,
        13.956 * scale,
        18 * scale,
        12.499 * scale,
        18 * scale,
        8 * scale,
      )
      ..arcToPoint(
        Offset(6 * scale, 8 * scale),
        radius: Radius.circular(6 * scale),
        clockwise: false,
      )
      ..relativeCubicTo(
        0.0,
        4.499 * scale,
        -1.411 * scale,
        5.956 * scale,
        -2.738 * scale,
        7.326 * scale,
      );
    canvas.drawPath(body, paint);
  }

  @override
  bool shouldRepaint(_BellPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
