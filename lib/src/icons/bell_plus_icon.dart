import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Bell Plus Icon - bell swings; plus sign draws in
class BellPlusIcon extends AnimatedSVGIcon {
  const BellPlusIcon({
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
  String get animationDescription => 'Bell swings; plus sign draws in';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return _BellPlusPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class _BellPlusPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _BellPlusPainter({
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

    // Plus sign (M15 8h6, M18 5v6); initial state matches original
    final double t = animationValue.clamp(0.0, 1.0);
    final Offset hStart = Offset(15 * scale, 8 * scale);
    final Offset hEnd = Offset(21 * scale, 8 * scale);
    final Offset vStart = Offset(18 * scale, 5 * scale);
    final Offset vEnd = Offset(18 * scale, 11 * scale);
    if (t == 0.0) {
      canvas.drawLine(hStart, hEnd, paint);
      canvas.drawLine(vStart, vEnd, paint);
    } else {
      final Offset hCurr =
          Offset(hStart.dx + (hEnd.dx - hStart.dx) * t, hStart.dy);
      canvas.drawLine(hStart, hCurr, paint);
      final Offset vCurr =
          Offset(vStart.dx, vStart.dy + (vEnd.dy - vStart.dy) * t);
      canvas.drawLine(vStart, vCurr, paint);
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
    // Derived from bell-plus.svg path
    final Path body = Path()
      ..moveTo(20.002 * scale, 14.464 * scale)
      ..arcToPoint(
        Offset(20.74 * scale, 15.327 * scale),
        radius: Radius.circular(9 * scale),
        clockwise: true,
      )
      ..arcToPoint(
        Offset(20 * scale, 17 * scale),
        radius: Radius.circular(1 * scale),
        clockwise: true,
      )
      ..lineTo(4 * scale, 17 * scale)
      ..arcToPoint(
        Offset(3.26 * scale, 15.327 * scale),
        radius: Radius.circular(1 * scale),
        clockwise: true,
      )
      ..cubicTo(
        4.59 * scale,
        13.956 * scale,
        6 * scale,
        12.499 * scale,
        6 * scale,
        8 * scale,
      )
      ..arcToPoint(
        Offset(14.75 * scale, 2.668 * scale),
        radius: Radius.circular(6 * scale),
        clockwise: true,
      );
    canvas.drawPath(body, paint);
  }

  @override
  bool shouldRepaint(_BellPlusPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
