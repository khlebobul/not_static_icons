import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Cassette Tape Icon - rotating reels animation
class CassetteTapeIcon extends AnimatedSVGIcon {
  const CassetteTapeIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 2000),
    super.strokeWidth = 2.0,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
    super.resetToStartOnComplete = true,
  });

  @override
  String get animationDescription =>
      'Cassette Tape: progressive tape drawing animation';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) =>
      _CassetteTapePainter(
        color: color,
        animationValue: animationValue,
        strokeWidth: strokeWidth,
      );
}

class _CassetteTapePainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _CassetteTapePainter({
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
    // Rect: width="20" height="16" x="2" y="4" rx="2"
    final rect = RRect.fromRectAndRadius(
      Rect.fromLTWH(2 * scale, 4 * scale, 20 * scale, 16 * scale),
      Radius.circular(2 * scale),
    );
    canvas.drawRRect(rect, paint);

    // Left circle: cx="8" cy="10" r="2"
    canvas.drawCircle(Offset(8 * scale, 10 * scale), 2 * scale, paint);

    // Horizontal line: M8 12h8
    canvas.drawLine(
      Offset(8 * scale, 12 * scale),
      Offset(16 * scale, 12 * scale),
      paint,
    );

    // Right circle: cx="16" cy="10" r="2"
    canvas.drawCircle(Offset(16 * scale, 10 * scale), 2 * scale, paint);

    // Bottom path: m6 20 .7-2.9A1.4 1.4 0 0 1 8.1 16h7.8a1.4 1.4 0 0 1 1.4 1l.7 3
    final bottomPath = Path()
      ..moveTo(6 * scale, 20 * scale)
      ..relativeLineTo(0.7 * scale, -2.9 * scale)
      ..arcToPoint(
        Offset(8.1 * scale, 16 * scale),
        radius: Radius.circular(1.4 * scale),
        clockwise: true,
      )
      ..relativeLineTo(7.8 * scale, 0)
      ..arcToPoint(
        Offset(17.5 * scale, 17 * scale),
        radius: Radius.circular(1.4 * scale),
        clockwise: true,
      )
      ..relativeLineTo(0.7 * scale, 3 * scale);
    canvas.drawPath(bottomPath, paint);
  }

  void _drawAnimated(Canvas canvas, Paint paint, double scale) {
    // Draw static parts
    final rect = RRect.fromRectAndRadius(
      Rect.fromLTWH(2 * scale, 4 * scale, 20 * scale, 16 * scale),
      Radius.circular(2 * scale),
    );
    canvas.drawRRect(rect, paint);

    // Left circle: cx="8" cy="10" r="2"
    canvas.drawCircle(Offset(8 * scale, 10 * scale), 2 * scale, paint);

    // Right circle: cx="16" cy="10" r="2"
    canvas.drawCircle(Offset(16 * scale, 10 * scale), 2 * scale, paint);

    final bottomPath = Path()
      ..moveTo(6 * scale, 20 * scale)
      ..relativeLineTo(0.7 * scale, -2.9 * scale)
      ..arcToPoint(
        Offset(8.1 * scale, 16 * scale),
        radius: Radius.circular(1.4 * scale),
        clockwise: true,
      )
      ..relativeLineTo(7.8 * scale, 0)
      ..arcToPoint(
        Offset(17.5 * scale, 17 * scale),
        radius: Radius.circular(1.4 * scale),
        clockwise: true,
      )
      ..relativeLineTo(0.7 * scale, 3 * scale);
    canvas.drawPath(bottomPath, paint);

    // Progressive tape drawing
    final t = animationValue;
    final tapeStartX = 8 * scale;
    final tapeEndX = 16 * scale;
    final tapeY = 12 * scale;

    final tapeLength = tapeEndX - tapeStartX;
    final currentTapeLength = tapeLength * t;
    final tapeEnd = tapeStartX + currentTapeLength;

    // Draw tape progressively from left to right
    canvas.drawLine(
      Offset(tapeStartX, tapeY),
      Offset(tapeEnd, tapeY),
      paint,
    );
  }

  @override
  bool shouldRepaint(_CassetteTapePainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
