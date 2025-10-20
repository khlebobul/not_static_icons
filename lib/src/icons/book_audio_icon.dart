import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';
import 'dart:math' as math;

/// Animated Book Audio Icon - audio bars pulsing animation
class BookAudioIcon extends AnimatedSVGIcon {
  const BookAudioIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 1600),
    super.strokeWidth = 2.0,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
    super.resetToStartOnComplete = true,
  });

  @override
  String get animationDescription => 'BookAudio: audio bars pulsing animation';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) =>
      _BookAudioPainter(
        color: color,
        animationValue: animationValue,
        strokeWidth: strokeWidth,
      );
}

class _BookAudioPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _BookAudioPainter({
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

      // Draw animated audio bars
      _drawAnimatedAudioBars(canvas, paint, scale);
    }
  }

  void _drawCompleteIcon(Canvas canvas, Paint paint, double scale) {
    _drawBookOutline(canvas, paint, scale);

    // Left bar: M8 8v3
    canvas.drawLine(
      Offset(8 * scale, 8 * scale),
      Offset(8 * scale, 11 * scale),
      paint,
    );

    // Center bar: M12 6v7
    canvas.drawLine(
      Offset(12 * scale, 6 * scale),
      Offset(12 * scale, 13 * scale),
      paint,
    );

    // Right bar: M16 8v3
    canvas.drawLine(
      Offset(16 * scale, 8 * scale),
      Offset(16 * scale, 11 * scale),
      paint,
    );
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

  void _drawAnimatedAudioBars(Canvas canvas, Paint paint, double scale) {
    final progress = animationValue;

    // Three bars with different phases and heights
    // Left bar: M8 8v3
    final leftPhase = math.sin(progress * math.pi * 4) * 0.5 + 0.5;
    final leftHeight = 3 * scale * leftPhase;
    canvas.drawLine(
      Offset(8 * scale, 8 * scale),
      Offset(8 * scale, 8 * scale + leftHeight),
      paint,
    );

    // Center bar: M12 6v7 (tallest)
    final centerPhase =
        math.sin(progress * math.pi * 4 + math.pi / 3) * 0.5 + 0.5;
    final centerHeight = 7 * scale * centerPhase;
    canvas.drawLine(
      Offset(12 * scale, 6 * scale),
      Offset(12 * scale, 6 * scale + centerHeight),
      paint,
    );

    // Right bar: M16 8v3
    final rightPhase =
        math.sin(progress * math.pi * 4 + 2 * math.pi / 3) * 0.5 + 0.5;
    final rightHeight = 3 * scale * rightPhase;
    canvas.drawLine(
      Offset(16 * scale, 8 * scale),
      Offset(16 * scale, 8 * scale + rightHeight),
      paint,
    );
  }

  @override
  bool shouldRepaint(_BookAudioPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
