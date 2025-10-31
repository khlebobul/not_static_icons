import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';
import 'dart:math' as math;

/// Animated Boxes Icon - boxes pulsing animation
class BoxesIcon extends AnimatedSVGIcon {
  const BoxesIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 1800),
    super.strokeWidth = 2.0,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
    super.resetToStartOnComplete = true,
  });

  @override
  String get animationDescription => 'Boxes: boxes pulsing animation';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) => _BoxesPainter(
        color: color,
        animationValue: animationValue,
        strokeWidth: strokeWidth,
      );
}

class _BoxesPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _BoxesPainter({
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

    if (animationValue == 0) {
      _drawCompleteIcon(canvas, paint, scale);
    } else {
      _drawAnimated(canvas, paint, scale);
    }
  }

  void _drawCompleteIcon(Canvas canvas, Paint paint, double scale) {
    _drawLeftBox(canvas, paint, scale, 1.0);
    _drawRightBox(canvas, paint, scale, 1.0);
    _drawTopBox(canvas, paint, scale, 1.0);
  }

  void _drawAnimated(Canvas canvas, Paint paint, double scale) {
    final t = animationValue;
    
    // Each box pulses with phase offset
    final leftAlpha = 0.5 + 0.5 * math.sin(2 * math.pi * t);
    final rightAlpha = 0.5 + 0.5 * math.sin(2 * math.pi * t + 2 * math.pi / 3);
    final topAlpha = 0.5 + 0.5 * math.sin(2 * math.pi * t + 4 * math.pi / 3);
    
    _drawLeftBox(canvas, paint, scale, leftAlpha);
    _drawRightBox(canvas, paint, scale, rightAlpha);
    _drawTopBox(canvas, paint, scale, topAlpha);
  }

  void _drawLeftBox(Canvas canvas, Paint paint, double scale, double alpha) {
    final boxPaint = Paint()
      ..color = color.withValues(alpha: alpha)
      ..strokeWidth = paint.strokeWidth
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;

    // Left box paths from SVG
    final p1 = Path()
      ..moveTo(2.97 * scale, 12.92 * scale)
      ..arcToPoint(
        Offset(2 * scale, 14.63 * scale),
        radius: Radius.circular(2 * scale),
        clockwise: false,
      )
      ..lineTo(2 * scale, 17.87 * scale)
      ..arcToPoint(
        Offset(2.97 * scale, 19.58 * scale),
        radius: Radius.circular(2 * scale),
        clockwise: false,
      )
      ..relativeLineTo(3 * scale, 1.8 * scale)
      ..arcToPoint(
        Offset(8.03 * scale, 21.38 * scale),
        radius: Radius.circular(2 * scale),
        clockwise: false,
      )
      ..lineTo(12 * scale, 19 * scale)
      ..lineTo(12 * scale, 13.5 * scale)
      ..relativeLineTo(-5 * scale, -3 * scale)
      ..lineTo(2.97 * scale, 12.92 * scale)
      ..close();
    canvas.drawPath(p1, boxPaint);

    canvas.drawLine(Offset(7 * scale, 16.5 * scale), Offset(2.26 * scale, 13.65 * scale), boxPaint);
    canvas.drawLine(Offset(7 * scale, 16.5 * scale), Offset(12 * scale, 13.5 * scale), boxPaint);
    canvas.drawLine(Offset(7 * scale, 16.5 * scale), Offset(7 * scale, 21.67 * scale), boxPaint);
  }

  void _drawRightBox(Canvas canvas, Paint paint, double scale, double alpha) {
    final boxPaint = Paint()
      ..color = color.withValues(alpha: alpha)
      ..strokeWidth = paint.strokeWidth
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;

    // Right box
    final p2 = Path()
      ..moveTo(12 * scale, 13.5 * scale)
      ..lineTo(12 * scale, 19 * scale)
      ..relativeLineTo(3.97 * scale, 2.38 * scale)
      ..arcToPoint(
        Offset(18.03 * scale, 21.38 * scale),
        radius: Radius.circular(2 * scale),
        clockwise: false,
      )
      ..relativeLineTo(3 * scale, -1.8 * scale)
      ..arcToPoint(
        Offset(22 * scale, 17.87 * scale),
        radius: Radius.circular(2 * scale),
        clockwise: false,
      )
      ..lineTo(22 * scale, 14.63 * scale)
      ..arcToPoint(
        Offset(21.03 * scale, 12.92 * scale),
        radius: Radius.circular(2 * scale),
        clockwise: false,
      )
      ..lineTo(17 * scale, 10.5 * scale)
      ..relativeLineTo(-5 * scale, 3 * scale)
      ..close();
    canvas.drawPath(p2, boxPaint);

    canvas.drawLine(Offset(17 * scale, 16.5 * scale), Offset(12 * scale, 13.5 * scale), boxPaint);
    canvas.drawLine(Offset(17 * scale, 16.5 * scale), Offset(21.74 * scale, 13.65 * scale), boxPaint);
    canvas.drawLine(Offset(17 * scale, 16.5 * scale), Offset(17 * scale, 21.67 * scale), boxPaint);
  }

  void _drawTopBox(Canvas canvas, Paint paint, double scale, double alpha) {
    final boxPaint = Paint()
      ..color = color.withValues(alpha: alpha)
      ..strokeWidth = paint.strokeWidth
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;

    // Top box
    final p3 = Path()
      ..moveTo(7.97 * scale, 4.42 * scale)
      ..arcToPoint(
        Offset(7 * scale, 6.13 * scale),
        radius: Radius.circular(2 * scale),
        clockwise: false,
      )
      ..lineTo(7 * scale, 10.5 * scale)
      ..relativeLineTo(5 * scale, 3 * scale)
      ..relativeLineTo(5 * scale, -3 * scale)
      ..lineTo(17 * scale, 6.13 * scale)
      ..arcToPoint(
        Offset(16.03 * scale, 4.42 * scale),
        radius: Radius.circular(2 * scale),
        clockwise: false,
      )
      ..relativeLineTo(-3 * scale, -1.8 * scale)
      ..arcToPoint(
        Offset(10.97 * scale, 2.62 * scale),
        radius: Radius.circular(2 * scale),
        clockwise: false,
      )
      ..relativeLineTo(-3 * scale, 1.8 * scale)
      ..close();
    canvas.drawPath(p3, boxPaint);

    canvas.drawLine(Offset(12 * scale, 8 * scale), Offset(7.26 * scale, 5.15 * scale), boxPaint);
    canvas.drawLine(Offset(12 * scale, 8 * scale), Offset(16.74 * scale, 5.15 * scale), boxPaint);
    canvas.drawLine(Offset(12 * scale, 13.5 * scale), Offset(12 * scale, 8 * scale), boxPaint);
  }

  @override
  bool shouldRepaint(_BoxesPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
