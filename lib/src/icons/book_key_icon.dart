import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';
import 'dart:math' as math;

/// Animated Book Key Icon - key turning animation
class BookKeyIcon extends AnimatedSVGIcon {
  const BookKeyIcon({
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
  String get animationDescription =>
      'BookKey: key progressive drawing animation';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) =>
      _BookKeyPainter(
        color: color,
        animationValue: animationValue,
        strokeWidth: strokeWidth,
      );
}

class _BookKeyPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _BookKeyPainter({
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
      _drawBookOutline(canvas, paint, scale);
      _drawAnimatedKey(canvas, paint, scale);
    }
  }

  void _drawCompleteIcon(Canvas canvas, Paint paint, double scale) {
    _drawBookOutline(canvas, paint, scale);
    _drawKey(canvas, paint, scale);
  }

  void _drawBookOutline(Canvas canvas, Paint paint, double scale) {
    // M20 7.898V21a1 1 0 0 1-1 1H6.5a1 1 0 0 1 0-5H20
    final bookPath = Path();
    bookPath.moveTo(20 * scale, 7.898 * scale);
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

    // M4 19.5v-15A2.5 2.5 0 0 1 6.5 2h7.844
    bookPath.moveTo(4 * scale, 19.5 * scale);
    bookPath.lineTo(4 * scale, 4.5 * scale);
    bookPath.arcToPoint(
      Offset(6.5 * scale, 2 * scale),
      radius: Radius.circular(2.5 * scale),
      clockwise: true,
    );
    bookPath.lineTo(14.344 * scale, 2 * scale);

    canvas.drawPath(bookPath, paint);
  }

  void _drawAnimatedKey(Canvas canvas, Paint paint, double scale) {
    final progress = animationValue;

    // Phase 1: Draw circle (0.0 - 0.3)
    if (progress > 0.0) {
      final circleProgress = (progress / 0.3).clamp(0.0, 1.0);
      final sweepAngle = circleProgress * 2 * math.pi;

      canvas.drawArc(
        Rect.fromCircle(
          center: Offset(14 * scale, 8 * scale),
          radius: 2 * scale,
        ),
        -math.pi / 2,
        sweepAngle,
        false,
        paint,
      );
    }

    // Phase 2: Draw diagonal line (0.3 - 0.65)
    if (progress > 0.3) {
      final diagonalProgress = ((progress - 0.3) / 0.35).clamp(0.0, 1.0);
      final diagonalEnd = Offset.lerp(
        Offset(15.5 * scale, 6.5 * scale),
        Offset(20 * scale, 2 * scale),
        diagonalProgress,
      )!;

      canvas.drawLine(
        Offset(15.5 * scale, 6.5 * scale),
        diagonalEnd,
        paint,
      );
    }

    // Phase 3: Draw key tooth (0.65 - 1.0)
    if (progress > 0.65) {
      final toothProgress = ((progress - 0.65) / 0.35).clamp(0.0, 1.0);
      final toothEnd = Offset.lerp(
        Offset(19 * scale, 3 * scale),
        Offset(20 * scale, 4 * scale),
        toothProgress,
      )!;

      canvas.drawLine(
        Offset(19 * scale, 3 * scale),
        toothEnd,
        paint,
      );
    }
  }

  void _drawKey(Canvas canvas, Paint paint, double scale) {
    // Circle: cx="14" cy="8" r="2"
    canvas.drawCircle(
      Offset(14 * scale, 8 * scale),
      2 * scale,
      paint,
    );

    // Key lines
    // m19 3 1 1
    final keyPath = Path();
    keyPath.moveTo(19 * scale, 3 * scale);
    keyPath.relativeLineTo(1 * scale, 1 * scale);

    // m20 2-4.5 4.5
    keyPath.moveTo(20 * scale, 2 * scale);
    keyPath.relativeLineTo(-4.5 * scale, 4.5 * scale);

    canvas.drawPath(keyPath, paint);
  }

  @override
  bool shouldRepaint(_BookKeyPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
