import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Book Open Text Icon - text lines appearing animation
class BookOpenTextIcon extends AnimatedSVGIcon {
  const BookOpenTextIcon({
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
  String get animationDescription => 'BookOpenText: text lines appearing animation';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) =>
      _BookOpenTextPainter(
        color: color,
        animationValue: animationValue,
        strokeWidth: strokeWidth,
      );
}

class _BookOpenTextPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _BookOpenTextPainter({
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
      _drawAnimatedTextLines(canvas, paint, scale);
    }
  }

  void _drawCompleteIcon(Canvas canvas, Paint paint, double scale) {
    _drawBookOutline(canvas, paint, scale);
    
    // Draw all text lines
    // Left page lines
    canvas.drawLine(Offset(6 * scale, 8 * scale), Offset(8 * scale, 8 * scale), paint);
    canvas.drawLine(Offset(6 * scale, 12 * scale), Offset(8 * scale, 12 * scale), paint);
    
    // Right page lines
    canvas.drawLine(Offset(16 * scale, 8 * scale), Offset(18 * scale, 8 * scale), paint);
    canvas.drawLine(Offset(16 * scale, 12 * scale), Offset(18 * scale, 12 * scale), paint);
  }

  void _drawBookOutline(Canvas canvas, Paint paint, double scale) {
    // Center spine: M12 7v14
    canvas.drawLine(
      Offset(12 * scale, 7 * scale),
      Offset(12 * scale, 21 * scale),
      paint,
    );

    // Path: M3 18a1 1 0 0 1-1-1V4a1 1 0 0 1 1-1h5a4 4 0 0 1 4 4 4 4 0 0 1 4-4h5a1 1 0 0 1 1 1v13a1 1 0 0 1-1 1h-6a3 3 0 0 0-3 3 3 3 0 0 0-3-3z
    final bookPath = Path();
    
    bookPath.moveTo(3 * scale, 18 * scale);
    bookPath.arcToPoint(
      Offset(2 * scale, 17 * scale),
      radius: Radius.circular(1 * scale),
      clockwise: true,
    );
    bookPath.lineTo(2 * scale, 4 * scale);
    bookPath.arcToPoint(
      Offset(3 * scale, 3 * scale),
      radius: Radius.circular(1 * scale),
      clockwise: true,
    );
    bookPath.lineTo(8 * scale, 3 * scale);
    bookPath.arcToPoint(
      Offset(12 * scale, 7 * scale),
      radius: Radius.circular(4 * scale),
      clockwise: true,
    );
    
    bookPath.arcToPoint(
      Offset(16 * scale, 3 * scale),
      radius: Radius.circular(4 * scale),
      clockwise: true,
    );
    bookPath.lineTo(21 * scale, 3 * scale);
    bookPath.arcToPoint(
      Offset(22 * scale, 4 * scale),
      radius: Radius.circular(1 * scale),
      clockwise: true,
    );
    bookPath.lineTo(22 * scale, 17 * scale);
    bookPath.arcToPoint(
      Offset(21 * scale, 18 * scale),
      radius: Radius.circular(1 * scale),
      clockwise: true,
    );
    bookPath.lineTo(15 * scale, 18 * scale);
    bookPath.arcToPoint(
      Offset(12 * scale, 21 * scale),
      radius: Radius.circular(3 * scale),
      clockwise: false,
    );
    
    bookPath.arcToPoint(
      Offset(9 * scale, 18 * scale),
      radius: Radius.circular(3 * scale),
      clockwise: false,
    );
    bookPath.lineTo(3 * scale, 18 * scale);

    canvas.drawPath(bookPath, paint);
  }

  void _drawAnimatedTextLines(Canvas canvas, Paint paint, double scale) {
    final progress = animationValue;

    // Define text lines with their appearance times
    final lines = [
      {'start': const Offset(6, 8), 'end': const Offset(8, 8), 'time': 0.0},
      {'start': const Offset(16, 8), 'end': const Offset(18, 8), 'time': 0.25},
      {'start': const Offset(6, 12), 'end': const Offset(8, 12), 'time': 0.5},
      {'start': const Offset(16, 12), 'end': const Offset(18, 12), 'time': 0.75},
    ];

    for (var line in lines) {
      final lineTime = line['time'] as double;
      final fadeStart = lineTime;
      final fadeEnd = lineTime + 0.2;

      if (progress >= fadeStart) {
        final lineProgress = progress >= fadeEnd
            ? 1.0
            : (progress - fadeStart) / (fadeEnd - fadeStart);

        final start = line['start'] as Offset;
        final end = line['end'] as Offset;
        final currentEnd = Offset.lerp(
          Offset(start.dx * scale, start.dy * scale),
          Offset(end.dx * scale, end.dy * scale),
          lineProgress,
        )!;

        canvas.drawLine(
          Offset(start.dx * scale, start.dy * scale),
          currentEnd,
          paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(_BookOpenTextPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
