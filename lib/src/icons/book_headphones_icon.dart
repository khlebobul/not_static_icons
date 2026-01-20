import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';
import 'dart:math' as math;

/// Animated Book Headphones Icon - sound waves animation
class BookHeadphonesIcon extends AnimatedSVGIcon {
  const BookHeadphonesIcon({
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
    super.onTap,
    super.interactive,
    super.controller,
  });

  @override
  String get animationDescription => 'BookHeadphones: sound waves animation';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) =>
      _BookHeadphonesPainter(
        color: color,
        animationValue: animationValue,
        strokeWidth: strokeWidth,
      );
}

class _BookHeadphonesPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _BookHeadphonesPainter({
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
      // Draw complete book outline
      _drawBookOutline(canvas, paint, scale);

      // Draw headphone arc (static)
      _drawHeadphoneArc(canvas, paint, scale);

      // Draw animated circles (pulsing)
      _drawAnimatedCircles(canvas, paint, scale);
    }
  }

  void _drawCompleteIcon(Canvas canvas, Paint paint, double scale) {
    _drawBookOutline(canvas, paint, scale);
    _drawHeadphoneArc(canvas, paint, scale);

    // Draw static circles
    canvas.drawCircle(Offset(9 * scale, 12 * scale), 1 * scale, paint);
    canvas.drawCircle(Offset(15 * scale, 12 * scale), 1 * scale, paint);
  }

  void _drawBookOutline(Canvas canvas, Paint paint, double scale) {
    final bookPath = Path();

    bookPath.moveTo(4 * scale, 19.5 * scale);
    bookPath.lineTo(4 * scale, 4.5 * scale);
    bookPath.arcToPoint(
      Offset(6.5 * scale, 2 * scale),
      radius: Radius.circular(2.5 * scale),
      clockwise: true,
    );
    bookPath.lineTo(19 * scale, 2 * scale);
    bookPath.arcToPoint(
      Offset(20 * scale, 3 * scale),
      radius: Radius.circular(1 * scale),
      clockwise: true,
    );
    bookPath.lineTo(20 * scale, 21 * scale);
    bookPath.arcToPoint(
      Offset(19 * scale, 22 * scale),
      radius: Radius.circular(1 * scale),
      clockwise: true,
    );
    bookPath.lineTo(6.5 * scale, 22 * scale);
    bookPath.arcToPoint(
      Offset(6.5 * scale, 17 * scale),
      radius: Radius.circular(1 * scale),
      clockwise: true,
    );
    bookPath.lineTo(20 * scale, 17 * scale);

    canvas.drawPath(bookPath, paint);
  }

  void _drawHeadphoneArc(Canvas canvas, Paint paint, double scale) {
    // Path: M8 12v-2a4 4 0 0 1 8 0v2
    final arcPath = Path();
    arcPath.moveTo(8 * scale, 12 * scale);
    arcPath.lineTo(8 * scale, 10 * scale);

    // Arc from 8,10 to 16,10 with radius 4
    arcPath.arcToPoint(
      Offset(16 * scale, 10 * scale),
      radius: Radius.circular(4 * scale),
      clockwise: true,
      largeArc: false,
    );

    arcPath.lineTo(16 * scale, 12 * scale);

    canvas.drawPath(arcPath, paint);
  }

  void _drawAnimatedCircles(Canvas canvas, Paint paint, double scale) {
    final progress = animationValue;

    // Pulsing effect for both circles
    final pulse = math.sin(progress * math.pi * 4) * 0.3 + 0.7;

    // Left circle: cx="9" cy="12" r="1"
    final leftRadius = 1 * scale * pulse;
    canvas.drawCircle(
      Offset(9 * scale, 12 * scale),
      leftRadius,
      paint,
    );

    // Right circle: cx="15" cy="12" r="1"
    final rightRadius = 1 * scale * pulse;
    canvas.drawCircle(
      Offset(15 * scale, 12 * scale),
      rightRadius,
      paint,
    );

    // Add sound wave effect
    if (progress > 0.2) {
      final waveProgress = ((progress - 0.2) / 0.8).clamp(0.0, 1.0);
      final waveAlpha = (1 - waveProgress) * 0.5;

      final wavePaint = Paint()
        ..color = color.withValues(alpha: waveAlpha)
        ..strokeWidth = strokeWidth * 0.5
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.stroke;

      // Left wave
      canvas.drawCircle(
        Offset(9 * scale, 12 * scale),
        (1 + waveProgress * 2) * scale,
        wavePaint,
      );

      // Right wave
      canvas.drawCircle(
        Offset(15 * scale, 12 * scale),
        (1 + waveProgress * 2) * scale,
        wavePaint,
      );
    }
  }

  @override
  bool shouldRepaint(_BookHeadphonesPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
