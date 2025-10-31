import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';
import 'dart:math' as math;

/// Animated Boom Box Icon - pulsing speakers and blinking buttons
class BoomBoxIcon extends AnimatedSVGIcon {
  const BoomBoxIcon({
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
  });

  @override
  String get animationDescription => 'BoomBox: pulsing speakers and blinking buttons';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) => _BoomBoxPainter(
        color: color,
        animationValue: animationValue,
        strokeWidth: strokeWidth,
      );
}

class _BoomBoxPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _BoomBoxPainter({
    required this.color,
    required this.animationValue,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final basePaint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;

    final scale = size.width / 24.0;

    if (animationValue == 0) {
      _drawCompleteIcon(canvas, basePaint, scale);
    } else {
      _drawAnimated(canvas, basePaint, scale);
    }
  }

  void _drawCompleteIcon(Canvas canvas, Paint paint, double scale) {
    _drawTopHandle(canvas, paint, scale);
    _drawTopButtons(canvas, paint, scale, 1.0);
    _drawBody(canvas, paint, scale);
    _drawSpeaker(canvas, paint, scale, const Offset(8, 15), 1.0);
    _drawSpeaker(canvas, paint, scale, const Offset(16, 15), 1.0);
  }

  void _drawAnimated(Canvas canvas, Paint paint, double scale) {
    final t = animationValue;
    _drawTopHandle(canvas, paint, scale);

    // Blink buttons with alpha
    final buttonsAlpha = 0.5 + 0.5 * (0.5 + 0.5 * math.sin(2 * math.pi * t));
    _drawTopButtons(canvas, paint, scale, buttonsAlpha);

    _drawBody(canvas, paint, scale);

    // Speakers pulse (scale radius around centers)
    final pulse = 1.0 + 0.15 * math.sin(2 * math.pi * t);
    _drawSpeaker(canvas, paint, scale, const Offset(8, 15), pulse);
    _drawSpeaker(canvas, paint, scale, const Offset(16, 15), pulse);
  }

  void _drawTopHandle(Canvas canvas, Paint paint, double scale) {
    // Path: M4 9V5 a2 2 0 0 1 2-2h12a2 2 0 0 1 2 2v4
    final p = Path()
      ..moveTo(4 * scale, 9 * scale)
      ..lineTo(4 * scale, 5 * scale)
      ..arcToPoint(
        Offset(6 * scale, 3 * scale),
        radius: Radius.circular(2 * scale),
        clockwise: true,
      )
      ..lineTo(18 * scale, 3 * scale)
      ..arcToPoint(
        Offset(20 * scale, 5 * scale),
        radius: Radius.circular(2 * scale),
        clockwise: true,
      )
      ..lineTo(20 * scale, 9 * scale);
    canvas.drawPath(p, paint);
  }

  void _drawTopButtons(Canvas canvas, Paint paint, double scale, double alpha) {
    final buttonPaint = Paint()
      ..color = color.withOpacity(alpha)
      ..strokeWidth = paint.strokeWidth
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;

    // M8 8v1, M12 8v1, M16 8v1
    canvas.drawLine(
      Offset(8 * scale, 8 * scale),
      Offset(8 * scale, 9 * scale),
      buttonPaint,
    );
    canvas.drawLine(
      Offset(12 * scale, 8 * scale),
      Offset(12 * scale, 9 * scale),
      buttonPaint,
    );
    canvas.drawLine(
      Offset(16 * scale, 8 * scale),
      Offset(16 * scale, 9 * scale),
      buttonPaint,
    );
  }

  void _drawBody(Canvas canvas, Paint paint, double scale) {
    // rect width="20" height="12" x="2" y="9" rx="2"
    final rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(2 * scale, 9 * scale, 20 * scale, 12 * scale),
      Radius.circular(2 * scale),
    );
    canvas.drawRRect(rrect, paint);
  }

  void _drawSpeaker(Canvas canvas, Paint paint, double scale, Offset center, double pulseScale) {
    canvas.save();
    canvas.translate(center.dx * scale, center.dy * scale);
    canvas.scale(pulseScale, pulseScale);
    canvas.translate(-center.dx * scale, -center.dy * scale);
    canvas.drawCircle(Offset(center.dx * scale, center.dy * scale), 2 * scale, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(_BoomBoxPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
