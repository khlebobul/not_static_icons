import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';
import 'dart:math' as math;

/// Animated Bot Icon - blinking eyes and antenna bob
class BotIcon extends AnimatedSVGIcon {
  const BotIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 1500),
    super.strokeWidth = 2.0,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
    super.resetToStartOnComplete = true,
  });

  @override
  String get animationDescription => 'Bot: blinking eyes and antenna bob';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) => _BotPainter(
        color: color,
        animationValue: animationValue,
        strokeWidth: strokeWidth,
      );
}

class _BotPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _BotPainter({
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
    _drawAntenna(canvas, paint, scale, 0);
    _drawBody(canvas, paint, scale);
    _drawSideConnectors(canvas, paint, scale);
    _drawEye(canvas, paint, scale, 9);
    _drawEye(canvas, paint, scale, 15);
  }

  void _drawAnimated(Canvas canvas, Paint paint, double scale) {
    final t = animationValue;

    // Antenna bob (vertical shift ~1px)
    final bob = math.sin(t * 2 * math.pi) * 1.0 * scale;
    _drawAntenna(canvas, paint, scale, bob);

    _drawBody(canvas, paint, scale);
    _drawSideConnectors(canvas, paint, scale);

    // Eyes blink by alpha
    final eyeAlpha = 0.35 + 0.65 * (0.5 + 0.5 * math.sin(2 * math.pi * t));
    final eyePaint = Paint()
      ..color = color.withOpacity(eyeAlpha)
      ..strokeWidth = paint.strokeWidth
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;

    _drawEye(canvas, eyePaint, scale, 9);
    _drawEye(canvas, eyePaint, scale, 15);
  }

  void _drawAntenna(Canvas canvas, Paint paint, double scale, double bob) {
    canvas.save();
    canvas.translate(0, -bob);
    // Path: M12 8V4H8
    final p = Path()
      ..moveTo(12 * scale, 8 * scale)
      ..lineTo(12 * scale, 4 * scale)
      ..lineTo(8 * scale, 4 * scale);
    canvas.drawPath(p, paint);
    canvas.restore();
  }

  void _drawBody(Canvas canvas, Paint paint, double scale) {
    // rect width="16" height="12" x="4" y="8" rx="2"
    final rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(4 * scale, 8 * scale, 16 * scale, 12 * scale),
      Radius.circular(2 * scale),
    );
    canvas.drawRRect(rrect, paint);
  }

  void _drawSideConnectors(Canvas canvas, Paint paint, double scale) {
    // M2 14h2, M20 14h2
    canvas.drawLine(Offset(2 * scale, 14 * scale), Offset(4 * scale, 14 * scale), paint);
    canvas.drawLine(Offset(20 * scale, 14 * scale), Offset(22 * scale, 14 * scale), paint);
  }

  void _drawEye(Canvas canvas, Paint paint, double scale, double x) {
    // Mx 13v2
    canvas.drawLine(
      Offset(x * scale, 13 * scale),
      Offset(x * scale, 15 * scale),
      paint,
    );
  }

  @override
  bool shouldRepaint(_BotPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
