import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Bell Dot Icon - bell body rings, dot gently pulses
class BellDotIcon extends AnimatedSVGIcon {
  const BellDotIcon({
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
      'Bell body swings in a short ring, notification dot softly pulses';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return _BellDotPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class _BellDotPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _BellDotPainter({
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

    // Pivot for ringing (around the bell head near 12,8 in lucide grid)
    final Offset pivot = Offset(12 * scale, 8 * scale);

    // Ringing angle: single swing forward and back in one animation
    final double angle = 0.18 * math.sin(math.pi * animationValue);

    // Draw bell body + clapper with rotation around pivot
    canvas.save();
    canvas.translate(pivot.dx, pivot.dy);
    canvas.rotate(angle);
    canvas.translate(-pivot.dx, -pivot.dy);

    _drawBellBody(canvas, scale, paint);
    _drawClapperArc(canvas, scale, paint);

    canvas.restore();

    // Draw pulsing notification dot (not rotated)
    _drawPulsingDot(canvas, scale, paint);
  }

  void _drawBellBody(Canvas canvas, double scale, Paint paint) {
    // Faithful translation of bell body from bell-dot.svg second path
    // M13.916 2.314 A6 6 0 0 0 6 8 c0 4.499 -1.411 5.956 -2.74 7.327
    // A1 1 0 0 0 4 17 h16 a1 1 0 0 0 .74-1.673 a9 9 0 0 1 -.585 -.665
    final Path body = Path()
      ..moveTo(13.916 * scale, 2.314 * scale)
      // A6 6 0 0 0 6 8
      ..arcToPoint(
        Offset(6 * scale, 8 * scale),
        radius: Radius.circular(6 * scale),
        clockwise: false,
      )
      // c0 4.499 -1.411 5.956 -2.74 7.327
      ..relativeCubicTo(
        0.0,
        4.499 * scale,
        -1.411 * scale,
        5.956 * scale,
        -2.74 * scale,
        7.327 * scale,
      )
      // A1 1 0 0 0 4 17
      ..arcToPoint(
        Offset(4 * scale, 17 * scale),
        radius: Radius.circular(1 * scale),
        clockwise: false,
      )
      // h16
      ..lineTo(20 * scale, 17 * scale)
      // a1 1 0 0 0 .74 -1.673
      ..arcToPoint(
        Offset(20.74 * scale, 15.327 * scale),
        radius: Radius.circular(1 * scale),
        clockwise: false,
      )
      // a9 9 0 0 1 -.585 -.665
      ..arcToPoint(
        Offset(20.155 * scale, 14.662 * scale),
        radius: Radius.circular(9 * scale),
        clockwise: true,
      );

    canvas.drawPath(body, paint);
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

  void _drawPulsingDot(Canvas canvas, double scale, Paint paint) {
    final Offset dotCenter = Offset(18 * scale, 8 * scale);
    // Static dot to preserve original look
    canvas.drawCircle(dotCenter, 3 * scale, paint);
  }

  @override
  bool shouldRepaint(_BellDotPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
