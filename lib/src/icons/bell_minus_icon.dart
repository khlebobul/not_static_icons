import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Bell Minus Icon - bell swings; minus line draws in
class BellMinusIcon extends AnimatedSVGIcon {
  const BellMinusIcon({
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
  String get animationDescription => 'Bell swings; minus line draws in';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return _BellMinusPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class _BellMinusPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _BellMinusPainter({
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

    // Minus (M15 8h6); initial state matches original
    final double minusT = animationValue.clamp(0.0, 1.0);
    final Offset mStart = Offset(15 * scale, 8 * scale);
    final Offset mEnd = Offset(21 * scale, 8 * scale);
    if (minusT == 0.0) {
      canvas.drawLine(mStart, mEnd, paint);
    } else {
      final Offset mCurr = Offset(
        mStart.dx + (mEnd.dx - mStart.dx) * minusT,
        mStart.dy,
      );
      canvas.drawLine(mStart, mCurr, paint);
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
    // Path sequence per bell-minus.svg (uses variant with top bar)
    // "M16.243 3.757 A6 6 0 0 0 6 8 c0 4.499-1.411 5.956-2.738 7.326
    //  A1 1 0 0 0 4 17 h16 a1 1 0 0 0 .74-1.673
    //  A9.4 9.4 0 0 1 18.667 12"
    final Path body = Path()
      ..moveTo(16.243 * scale, 3.757 * scale)
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
      )
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
      ..arcToPoint(
        Offset(18.667 * scale, 12 * scale),
        radius: Radius.circular(9.4 * scale),
        clockwise: true,
      );
    canvas.drawPath(body, paint);
  }

  @override
  bool shouldRepaint(_BellMinusPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
