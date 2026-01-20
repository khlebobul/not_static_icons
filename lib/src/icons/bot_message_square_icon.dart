import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';
import 'dart:math' as math;

/// Animated Bot Message Square Icon - bubble pop with blinking eyes
class BotMessageSquareIcon extends AnimatedSVGIcon {
  const BotMessageSquareIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 1600),
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
      'BotMessageSquare: bubble pop with blinking eyes';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) =>
      _BotMessageSquarePainter(
        color: color,
        animationValue: animationValue,
        strokeWidth: strokeWidth,
      );
}

class _BotMessageSquarePainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _BotMessageSquarePainter({
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
    _drawTopAntenna(canvas, paint, scale);
    _drawBubble(canvas, paint, scale, 1.0);
    _drawSideConnectors(canvas, paint, scale);
    _drawEye(canvas, paint, scale, 9);
    _drawEye(canvas, paint, scale, 15);
  }

  void _drawAnimated(Canvas canvas, Paint paint, double scale) {
    final t = animationValue;
    _drawTopAntenna(canvas, paint, scale);

    // Bubble pop: slight scale pulse
    final pop = 1.0 + 0.03 * math.sin(2 * math.pi * t);
    _drawBubble(canvas, paint, scale, pop);

    _drawSideConnectors(canvas, paint, scale);

    // Eyes blink
    final eyeAlpha = 0.35 + 0.65 * (0.5 + 0.5 * math.sin(2 * math.pi * t));
    final eyePaint = Paint()
      ..color = color.withValues(alpha: eyeAlpha)
      ..strokeWidth = paint.strokeWidth
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;

    _drawEye(canvas, eyePaint, scale, 9);
    _drawEye(canvas, eyePaint, scale, 15);
  }

  void _drawTopAntenna(Canvas canvas, Paint paint, double scale) {
    // M12 6V2H8
    final p = Path()
      ..moveTo(12 * scale, 6 * scale)
      ..lineTo(12 * scale, 2 * scale)
      ..lineTo(8 * scale, 2 * scale);
    canvas.drawPath(p, paint);
  }

  void _drawBubble(
      Canvas canvas, Paint paint, double scale, double bubbleScale) {
    // Draw exact bubble path from SVG:
    // M20 16 a2 2 0 0 1 -2 2 H8.828 a2 2 0 0 0 -1.414 .586 l -2.202 2.202 A .71 .71 0 0 1 4 20.286 V8 a2 2 0 0 1 2 -2 h12 a2 2 0 0 1 2 2 z
    canvas.save();
    // Scale around approximate bubble center (12,14)
    canvas.translate(12 * scale, 14 * scale);
    canvas.scale(bubbleScale, bubbleScale);
    canvas.translate(-12 * scale, -14 * scale);

    final p = Path();
    p.moveTo(20 * scale, 16 * scale);
    // a2 2 0 0 1 -2 2  => to (18,18)
    p.arcToPoint(
      Offset(18 * scale, 18 * scale),
      radius: Radius.circular(2 * scale),
      clockwise: true,
    );
    // H8.828
    p.lineTo(8.828 * scale, 18 * scale);
    // a2 2 0 0 0 -1.414 .586 => to (7.414,18.586)
    p.arcToPoint(
      Offset(7.414 * scale, 18.586 * scale),
      radius: Radius.circular(2 * scale),
      clockwise: false,
    );
    // l -2.202 2.202 => to (5.212,20.788)
    p.relativeLineTo(-2.202 * scale, 2.202 * scale);
    // A .71 .71 0 0 1 4 20.286
    p.arcToPoint(
      Offset(4 * scale, 20.286 * scale),
      radius: Radius.circular(0.71 * scale),
      clockwise: true,
    );
    // V8
    p.lineTo(4 * scale, 8 * scale);
    // a2 2 0 0 1 2 -2 => to (6,6)
    p.arcToPoint(
      Offset(6 * scale, 6 * scale),
      radius: Radius.circular(2 * scale),
      clockwise: true,
    );
    // h12 => to (18,6)
    p.lineTo(18 * scale, 6 * scale);
    // a2 2 0 0 1 2 2 => to (20,8)
    p.arcToPoint(
      Offset(20 * scale, 8 * scale),
      radius: Radius.circular(2 * scale),
      clockwise: true,
    );
    p.close();

    canvas.drawPath(p, paint);
    canvas.restore();
  }

  void _drawSideConnectors(Canvas canvas, Paint paint, double scale) {
    // M2 12h2, M20 12h2
    canvas.drawLine(
        Offset(2 * scale, 12 * scale), Offset(4 * scale, 12 * scale), paint);
    canvas.drawLine(
        Offset(20 * scale, 12 * scale), Offset(22 * scale, 12 * scale), paint);
  }

  void _drawEye(Canvas canvas, Paint paint, double scale, double x) {
    // Mx 11v2
    canvas.drawLine(
      Offset(x * scale, 11 * scale),
      Offset(x * scale, 13 * scale),
      paint,
    );
  }

  @override
  bool shouldRepaint(_BotMessageSquarePainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
