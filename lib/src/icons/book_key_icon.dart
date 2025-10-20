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
  String get animationDescription => 'BookKey: key turning animation';

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
    _drawKey(canvas, paint, scale, 0.0);
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
    
    // Rotation angle: 0 to 45 degrees
    final rotation = progress * math.pi / 4;
    
    _drawKey(canvas, paint, scale, rotation);
  }

  void _drawKey(Canvas canvas, Paint paint, double scale, double rotation) {
    canvas.save();
    
    // Rotate around the key circle center (14, 8)
    canvas.translate(14 * scale, 8 * scale);
    canvas.rotate(rotation);
    canvas.translate(-14 * scale, -8 * scale);

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
    canvas.restore();
  }

  @override
  bool shouldRepaint(_BookKeyPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
