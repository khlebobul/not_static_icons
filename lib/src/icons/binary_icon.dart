import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Binary Icon - two capsules and connecting lines; side lines draw progressively
class BinaryIcon extends AnimatedSVGIcon {
  const BinaryIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 800),
    super.strokeWidth = 2.0,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
    super.resetToStartOnComplete = true,
  });

  @override
  String get animationDescription =>
      'Binary: side stems draw outward to emphasize 0/1';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) =>
      _BinaryPainter(
        color: color,
        animationValue: animationValue,
        strokeWidth: strokeWidth,
      );
}

class _BinaryPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _BinaryPainter({
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

    // Capsules: <rect x="14" y="14" width="4" height="6" rx="2"/> and <rect x="6" y="4" width="4" height="6" rx="2"/>
    final rRight = RRect.fromRectAndRadius(
      Rect.fromLTWH(14 * scale, 14 * scale, 4 * scale, 6 * scale),
      Radius.circular(2 * scale),
    );
    final rLeft = RRect.fromRectAndRadius(
      Rect.fromLTWH(6 * scale, 4 * scale, 4 * scale, 6 * scale),
      Radius.circular(2 * scale),
    );
    canvas.drawRRect(rRight, paint);
    canvas.drawRRect(rLeft, paint);

    // Static horizontals: M6 20 h4 and M14 10 h4
    canvas.drawLine(
        Offset(6 * scale, 20 * scale), Offset(10 * scale, 20 * scale), paint);
    canvas.drawLine(
        Offset(14 * scale, 10 * scale), Offset(18 * scale, 10 * scale), paint);

    // Animated stems: M6 14 h2 v6 and M14 4 h2 v6
    _drawStem(canvas, scale, paint,
        start: Offset(6 * scale, 14 * scale),
        hLen: 2 * scale,
        vLen: 6 * scale,
        progress: animationValue);
    _drawStem(canvas, scale, paint,
        start: Offset(14 * scale, 4 * scale),
        hLen: 2 * scale,
        vLen: 6 * scale,
        progress: (animationValue * 0.9).clamp(0.0, 1.0));
  }

  void _drawStem(
    Canvas canvas,
    double scale,
    Paint paint, {
    required Offset start,
    required double hLen,
    required double vLen,
    required double progress,
  }) {
    if (progress == 0.0) {
      // full stem in static state
      canvas.drawLine(start, Offset(start.dx + hLen, start.dy), paint);
      canvas.drawLine(Offset(start.dx + hLen, start.dy),
          Offset(start.dx + hLen, start.dy + vLen), paint);
      return;
    }

    final t = progress.clamp(0.0, 1.0);
    if (t < 0.5) {
      final p = t / 0.5; // 0..1
      canvas.drawLine(start, Offset(start.dx + hLen * p, start.dy), paint);
    } else {
      // horizontal done
      canvas.drawLine(start, Offset(start.dx + hLen, start.dy), paint);
      final p = (t - 0.5) / 0.5; // 0..1
      canvas.drawLine(Offset(start.dx + hLen, start.dy),
          Offset(start.dx + hLen, start.dy + vLen * p), paint);
    }
  }

  @override
  bool shouldRepaint(_BinaryPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
