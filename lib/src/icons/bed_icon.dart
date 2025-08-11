import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Bed Icon - exact geometry; subtle vertical bounce then back to original
class BedIcon extends AnimatedSVGIcon {
  const BedIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 700),
    super.strokeWidth = 2.0,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
    super.resetToStartOnComplete = true,
  });

  @override
  String get animationDescription =>
      'Bed: subtle vertical bounce, returns to original';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return _BedPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class _BedPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _BedPainter({
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

    // Subtle vertical bounce transform around center
    if (animationValue > 0.0) {
      final center = Offset(12 * scale, 12 * scale);
      final s = 1.0 - 0.06 * math.sin(math.pi * animationValue);
      final dy = -1.2 * scale * math.sin(math.pi * animationValue);
      canvas.save();
      canvas.translate(center.dx, center.dy + dy);
      canvas.scale(1.0, s);
      canvas.translate(-center.dx, -center.dy);
      _drawBed(canvas, scale, paint);
      canvas.restore();
    } else {
      _drawBed(canvas, scale, paint);
    }
  }

  void _drawBed(Canvas canvas, double scale, Paint paint) {
    // Path 1: M2 4 v16
    canvas.drawLine(
      Offset(2 * scale, 4 * scale),
      Offset(2 * scale, 20 * scale),
      paint,
    );

    // Path 2: M2 8 h18 a2 2 0 0 1 2 2 v10
    final p2 = Path()
      ..moveTo(2 * scale, 8 * scale)
      ..lineTo(20 * scale, 8 * scale)
      ..arcToPoint(
        Offset(22 * scale, 10 * scale),
        radius: Radius.circular(2 * scale),
        clockwise: true,
      )
      ..lineTo(22 * scale, 20 * scale);
    canvas.drawPath(p2, paint);

    // Path 3: M2 17 h20
    canvas.drawLine(
      Offset(2 * scale, 17 * scale),
      Offset(22 * scale, 17 * scale),
      paint,
    );

    // Path 4: M6 8 v9
    canvas.drawLine(
      Offset(6 * scale, 8 * scale),
      Offset(6 * scale, 17 * scale),
      paint,
    );
  }

  @override
  bool shouldRepaint(_BedPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
