import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Book A Icon - letter drawing animation
class BookAIcon extends AnimatedSVGIcon {
  const BookAIcon({
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
  String get animationDescription => 'BookA: letter A drawing animation';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) =>
      _BookAPainter(
        color: color,
        animationValue: animationValue,
        strokeWidth: strokeWidth,
      );
}

class _BookAPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _BookAPainter({
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

      // Draw animated letter A
      _drawAnimatedLetterA(canvas, paint, scale);
    }
  }

  void _drawCompleteIcon(Canvas canvas, Paint paint, double scale) {
    _drawBookOutline(canvas, paint, scale);
    // Draw letter A
    final pathA = Path();
    pathA.moveTo(8 * scale, 13 * scale);
    pathA.lineTo(12 * scale, 6 * scale);
    pathA.lineTo(16 * scale, 13 * scale);
    pathA.moveTo(9.1 * scale, 11 * scale);
    pathA.lineTo(14.8 * scale, 11 * scale);
    canvas.drawPath(pathA, paint);
  }

  void _drawBookOutline(Canvas canvas, Paint paint, double scale) {
    // Path: M4 19.5v-15A2.5 2.5 0 0 1 6.5 2H19a1 1 0 0 1 1 1v18a1 1 0 0 1-1 1H6.5a1 1 0 0 1 0-5H20
    final bookPath = Path();

    // Start at M4 19.5
    bookPath.moveTo(4 * scale, 19.5 * scale);

    // v-15 (vertical line up)
    bookPath.lineTo(4 * scale, 4.5 * scale);

    // A2.5 2.5 0 0 1 6.5 2 (arc to top of spine)
    bookPath.arcToPoint(
      Offset(6.5 * scale, 2 * scale),
      radius: Radius.circular(2.5 * scale),
      clockwise: true,
    );

    // H19 (horizontal to right edge)
    bookPath.lineTo(19 * scale, 2 * scale);

    // a1 1 0 0 1 1 1 (top right corner)
    bookPath.arcToPoint(
      Offset(20 * scale, 3 * scale),
      radius: Radius.circular(1 * scale),
      clockwise: true,
    );

    // v18 (vertical line down)
    bookPath.lineTo(20 * scale, 21 * scale);

    // a1 1 0 0 1-1 1 (bottom right corner)
    bookPath.arcToPoint(
      Offset(19 * scale, 22 * scale),
      radius: Radius.circular(1 * scale),
      clockwise: true,
    );

    // H6.5 (horizontal to spine)
    bookPath.lineTo(6.5 * scale, 22 * scale);

    // a1 1 0 0 1 0-5 (bottom spine curve)
    bookPath.arcToPoint(
      Offset(6.5 * scale, 17 * scale),
      radius: Radius.circular(1 * scale),
      clockwise: true,
    );

    // H20 (horizontal line to right)
    bookPath.lineTo(20 * scale, 17 * scale);

    canvas.drawPath(bookPath, paint);
  }

  void _drawAnimatedLetterA(Canvas canvas, Paint paint, double scale) {
    final progress = animationValue;

    // Phase 1: Draw left diagonal of A (0.0 - 0.4)
    if (progress > 0.0) {
      final leftProgress = (progress / 0.4).clamp(0.0, 1.0);
      _drawLeftDiagonal(canvas, paint, scale, leftProgress);
    }

    // Phase 2: Draw right diagonal of A (0.3 - 0.7)
    if (progress > 0.3) {
      final rightProgress = ((progress - 0.3) / 0.4).clamp(0.0, 1.0);
      _drawRightDiagonal(canvas, paint, scale, rightProgress);
    }

    // Phase 3: Draw horizontal bar (0.6 - 1.0)
    if (progress > 0.6) {
      final barProgress = ((progress - 0.6) / 0.4).clamp(0.0, 1.0);
      _drawHorizontalBar(canvas, paint, scale, barProgress);
    }
  }

  void _drawLeftDiagonal(
      Canvas canvas, Paint paint, double scale, double progress) {
    // Path: m8 13 4-7 (left side of A)
    final start = Offset(8 * scale, 13 * scale);
    final end = Offset(12 * scale, 6 * scale);
    final current = Offset.lerp(start, end, progress)!;

    canvas.drawLine(start, current, paint);
  }

  void _drawRightDiagonal(
      Canvas canvas, Paint paint, double scale, double progress) {
    // Path: from 12 6 to 16 13 (right side of A)
    final start = Offset(12 * scale, 6 * scale);
    final end = Offset(16 * scale, 13 * scale);
    final current = Offset.lerp(start, end, progress)!;

    canvas.drawLine(start, current, paint);
  }

  void _drawHorizontalBar(
      Canvas canvas, Paint paint, double scale, double progress) {
    // Path: M9.1 11h5.7 (horizontal bar)
    final start = Offset(9.1 * scale, 11 * scale);
    final end = Offset(14.8 * scale, 11 * scale);
    final current = Offset.lerp(start, end, progress)!;

    canvas.drawLine(start, current, paint);
  }

  @override
  bool shouldRepaint(_BookAPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
