import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Bot Off Icon - progressive strike drawing
class BotOffIcon extends AnimatedSVGIcon {
  const BotOffIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 1400),
    super.strokeWidth = 2.0,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
    super.resetToStartOnComplete = true,
  });

  @override
  String get animationDescription => 'BotOff: progressive strike drawing';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) => _BotOffPainter(
        color: color,
        animationValue: animationValue,
        strokeWidth: strokeWidth,
      );
}

class _BotOffPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _BotOffPainter({
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
    _drawBotBase(canvas, paint, scale);
    _drawStrike(canvas, paint, scale, 1.0);
  }

  void _drawAnimated(Canvas canvas, Paint paint, double scale) {
    _drawBotBase(canvas, paint, scale);

    // Progressive strike from (22,22) to (2,2)
    final t = animationValue.clamp(0.0, 1.0);
    _drawStrike(canvas, paint, scale, t);
  }

  void _drawBotBase(Canvas canvas, Paint paint, double scale) {
    // Exact fragments from SVG geometry

    // Right-top path: M13.67 8 H18 a2 2 0 0 1 2 2 v4.33
    final rightTop = Path()
      ..moveTo(13.67 * scale, 8 * scale)
      ..lineTo(18 * scale, 8 * scale)
      ..arcToPoint(
        Offset(20 * scale, 10 * scale),
        radius: Radius.circular(2 * scale),
        clockwise: true,
      )
      ..lineTo(20 * scale, 14.33 * scale);
    canvas.drawPath(rightTop, paint);

    // Side connectors: M2 14h2 and M20 14h2
    canvas.drawLine(Offset(2 * scale, 14 * scale), Offset(4 * scale, 14 * scale), paint);
    canvas.drawLine(Offset(20 * scale, 14 * scale), Offset(22 * scale, 14 * scale), paint);

    // Main body: M8 8 H6 a2 2 0 0 0 -2 2 v8 a2 2 0 0 0 2 2 h12 a2 2 0 0 0 1.414 -.586
    final bodyPath = Path()
      ..moveTo(8 * scale, 8 * scale)
      ..lineTo(6 * scale, 8 * scale)
      ..arcToPoint(
        Offset(4 * scale, 10 * scale),
        radius: Radius.circular(2 * scale),
        clockwise: false,
      )
      ..lineTo(4 * scale, 18 * scale)
      ..arcToPoint(
        Offset(6 * scale, 20 * scale),
        radius: Radius.circular(2 * scale),
        clockwise: false,
      )
      ..lineTo(18 * scale, 20 * scale)
      ..arcToPoint(
        Offset(19.414 * scale, 19.414 * scale),
        radius: Radius.circular(2 * scale),
        clockwise: false,
      );
    canvas.drawPath(bodyPath, paint);

    // Eye: M9 13v2  (only left eye in the SVG)
    canvas.drawLine(Offset(9 * scale, 13 * scale), Offset(9 * scale, 15 * scale), paint);

    // Small top: M9.67 4 H12 v2.33
    final top = Path()
      ..moveTo(9.67 * scale, 4 * scale)
      ..lineTo(12 * scale, 4 * scale)
      ..lineTo(12 * scale, 6.33 * scale);
    canvas.drawPath(top, paint);
  }

  void _drawStrike(Canvas canvas, Paint paint, double scale, double progress) {
    final start = Offset(22 * scale, 22 * scale);
    final end = Offset(2 * scale, 2 * scale);
    final current = Offset.lerp(start, end, progress)!;
    canvas.drawLine(start, current, paint);
  }

  @override
  bool shouldRepaint(_BotOffPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
