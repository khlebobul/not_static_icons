import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Bell Ring Icon - bell swings, outer ring waves draw in
class BellRingIcon extends AnimatedSVGIcon {
  const BellRingIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 1000),
    super.strokeWidth = 2.0,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
    super.resetToStartOnComplete = true,
  });

  @override
  String get animationDescription => 'Bell swings, outer waves appear';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return _BellRingPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class _BellRingPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _BellRingPainter({
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

    // Outer waves (initial state matches original)
    final double t = animationValue.clamp(0.0, 1.0);
    // Right wave: M22 8 c0-2.3-.8-4.3-2-6
    final Path right = Path()
      ..moveTo(22 * scale, 8 * scale)
      ..relativeCubicTo(0.0, -2.3 * scale, -0.8 * scale, -4.3 * scale,
          -2.0 * scale, -6.0 * scale);
    // Left wave: M4 2 C2.8 3.7 2 5.7 2 8
    final Path left = Path()
      ..moveTo(4 * scale, 2 * scale)
      ..cubicTo(2.8 * scale, 3.7 * scale, 2 * scale, 5.7 * scale, 2 * scale,
          8 * scale);
    if (t == 0.0) {
      canvas.drawPath(right, paint);
      canvas.drawPath(left, paint);
    } else {
      // simple alpha-like reveal by shortening control deltas
      final Path rightAnim = Path()
        ..moveTo(22 * scale, 8 * scale)
        ..relativeCubicTo(0.0, -2.3 * scale * t, -0.8 * scale * t,
            -4.3 * scale * t, -2.0 * scale * t, -6.0 * scale * t);
      canvas.drawPath(rightAnim, paint);
      final Path leftAnim = Path()
        ..moveTo(4 * scale, 2 * scale)
        ..cubicTo(
            2.8 * scale,
            (3.7 * t + 2 * (1 - t)) * scale,
            2 * scale,
            (5.7 * t + 2 * (1 - t)) * scale,
            2 * scale,
            (8 * t + 2 * (1 - t)) * scale);
      canvas.drawPath(leftAnim, paint);
    }

    // Body + clapper swing
    final Offset pivot = Offset(12 * scale, 8 * scale);
    final double angle = 0.18 * math.sin(math.pi * animationValue);
    canvas.save();
    canvas.translate(pivot.dx, pivot.dy);
    canvas.rotate(angle);
    canvas.translate(-pivot.dx, -pivot.dy);

    _drawClapperArc(canvas, scale, paint);
    _drawBody(canvas, scale, paint);

    canvas.restore();
  }

  void _drawClapperArc(Canvas canvas, double scale, Paint paint) {
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
    // M3.262 15.326 A1 1 0 0 0 4 17 h16 a1 1 0 0 0 .74-1.673 C19.41 13.956 18 12.499 18 8
    // A6 6 0 0 0 6 8 c0 4.499-1.411 5.956-2.738 7.326
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
  bool shouldRepaint(_BellRingPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
