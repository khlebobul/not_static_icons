import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';
import 'dart:math' as math;

/// Animated Book Open Icon - page opening animation
class BookOpenIcon extends AnimatedSVGIcon {
  const BookOpenIcon({
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
  String get animationDescription => 'BookOpen: page opening animation';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) =>
      _BookOpenPainter(
        color: color,
        animationValue: animationValue,
        strokeWidth: strokeWidth,
      );
}

class _BookOpenPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _BookOpenPainter({
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
      _drawAnimatedBook(canvas, paint, scale);
    }
  }

  void _drawCompleteIcon(Canvas canvas, Paint paint, double scale) {
    // Center spine: M12 7v14
    canvas.drawLine(
      Offset(12 * scale, 7 * scale),
      Offset(12 * scale, 21 * scale),
      paint,
    );

    // Left page: M3 18a1 1 0 0 1-1-1V4a1 1 0 0 1 1-1h5a4 4 0 0 1 4 4
    final leftPath = Path();
    leftPath.moveTo(3 * scale, 18 * scale);
    leftPath.arcToPoint(
      Offset(2 * scale, 17 * scale),
      radius: Radius.circular(1 * scale),
      clockwise: true,
    );
    leftPath.lineTo(2 * scale, 4 * scale);
    leftPath.arcToPoint(
      Offset(3 * scale, 3 * scale),
      radius: Radius.circular(1 * scale),
      clockwise: true,
    );
    leftPath.lineTo(8 * scale, 3 * scale);
    leftPath.arcToPoint(
      Offset(12 * scale, 7 * scale),
      radius: Radius.circular(4 * scale),
      clockwise: true,
    );
    canvas.drawPath(leftPath, paint);

    // Right page: a4 4 0 0 1 4-4h5a1 1 0 0 1 1 1v13a1 1 0 0 1-1 1h-6a3 3 0 0 0-3 3
    final rightPath = Path();
    rightPath.moveTo(12 * scale, 7 * scale);
    rightPath.arcToPoint(
      Offset(16 * scale, 3 * scale),
      radius: Radius.circular(4 * scale),
      clockwise: true,
    );
    rightPath.lineTo(21 * scale, 3 * scale);
    rightPath.arcToPoint(
      Offset(22 * scale, 4 * scale),
      radius: Radius.circular(1 * scale),
      clockwise: true,
    );
    rightPath.lineTo(22 * scale, 17 * scale);
    rightPath.arcToPoint(
      Offset(21 * scale, 18 * scale),
      radius: Radius.circular(1 * scale),
      clockwise: true,
    );
    rightPath.lineTo(15 * scale, 18 * scale);
    rightPath.arcToPoint(
      Offset(12 * scale, 21 * scale),
      radius: Radius.circular(3 * scale),
      clockwise: false,
    );
    canvas.drawPath(rightPath, paint);

    // Bottom left curve: a3 3 0 0 0-3-3
    final bottomLeftPath = Path();
    bottomLeftPath.moveTo(12 * scale, 21 * scale);
    bottomLeftPath.arcToPoint(
      Offset(9 * scale, 18 * scale),
      radius: Radius.circular(3 * scale),
      clockwise: false,
    );
    bottomLeftPath.lineTo(3 * scale, 18 * scale);
    canvas.drawPath(bottomLeftPath, paint);
  }

  void _drawAnimatedBook(Canvas canvas, Paint paint, double scale) {
    final progress = animationValue;

    // Center spine always visible
    canvas.drawLine(
      Offset(12 * scale, 7 * scale),
      Offset(12 * scale, 21 * scale),
      paint,
    );

    // Animate pages opening with slight horizontal spread
    final spreadOffset = math.sin(progress * math.pi) * 0.5 * scale;

    canvas.save();
    canvas.translate(-spreadOffset, 0);
    _drawLeftPage(canvas, paint, scale);
    canvas.restore();

    canvas.save();
    canvas.translate(spreadOffset, 0);
    _drawRightPage(canvas, paint, scale);
    canvas.restore();
  }

  void _drawLeftPage(Canvas canvas, Paint paint, double scale) {
    final leftPath = Path();
    leftPath.moveTo(3 * scale, 18 * scale);
    leftPath.arcToPoint(
      Offset(2 * scale, 17 * scale),
      radius: Radius.circular(1 * scale),
      clockwise: true,
    );
    leftPath.lineTo(2 * scale, 4 * scale);
    leftPath.arcToPoint(
      Offset(3 * scale, 3 * scale),
      radius: Radius.circular(1 * scale),
      clockwise: true,
    );
    leftPath.lineTo(8 * scale, 3 * scale);
    leftPath.arcToPoint(
      Offset(12 * scale, 7 * scale),
      radius: Radius.circular(4 * scale),
      clockwise: true,
    );
    canvas.drawPath(leftPath, paint);

    final bottomLeftPath = Path();
    bottomLeftPath.moveTo(12 * scale, 21 * scale);
    bottomLeftPath.arcToPoint(
      Offset(9 * scale, 18 * scale),
      radius: Radius.circular(3 * scale),
      clockwise: false,
    );
    bottomLeftPath.lineTo(3 * scale, 18 * scale);
    canvas.drawPath(bottomLeftPath, paint);
  }

  void _drawRightPage(Canvas canvas, Paint paint, double scale) {
    final rightPath = Path();
    rightPath.moveTo(12 * scale, 7 * scale);
    rightPath.arcToPoint(
      Offset(16 * scale, 3 * scale),
      radius: Radius.circular(4 * scale),
      clockwise: true,
    );
    rightPath.lineTo(21 * scale, 3 * scale);
    rightPath.arcToPoint(
      Offset(22 * scale, 4 * scale),
      radius: Radius.circular(1 * scale),
      clockwise: true,
    );
    rightPath.lineTo(22 * scale, 17 * scale);
    rightPath.arcToPoint(
      Offset(21 * scale, 18 * scale),
      radius: Radius.circular(1 * scale),
      clockwise: true,
    );
    rightPath.lineTo(15 * scale, 18 * scale);
    rightPath.arcToPoint(
      Offset(12 * scale, 21 * scale),
      radius: Radius.circular(3 * scale),
      clockwise: false,
    );
    canvas.drawPath(rightPath, paint);
  }

  @override
  bool shouldRepaint(_BookOpenPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
