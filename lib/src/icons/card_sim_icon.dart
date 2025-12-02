import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Card Sim Icon - Chip lines draw
class CardSimIcon extends AnimatedSVGIcon {
  const CardSimIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 600),
    super.strokeWidth = 2.0,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
  });

  @override
  String get animationDescription => "Chip lines draw";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return CardSimPainter(
      color: color,
      progress: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class CardSimPainter extends CustomPainter {
  final Color color;
  final double progress;
  final double strokeWidth;

  CardSimPainter({
    required this.color,
    required this.progress,
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

    // Card Outline (Static)
    // M14.172 2a2 2 0 0 1 1.414.586l3.828 3.828A2 2 0 0 1 20 7.828V20a2 2 0 0 1-2 2H6a2 2 0 0 1-2-2V4a2 2 0 0 1 2-2z
    final cardPath = Path();
    cardPath.moveTo(14.172 * scale, 2 * scale);
    cardPath.arcToPoint(Offset(15.586 * scale, 2.586 * scale),
        radius: Radius.circular(2 * scale), clockwise: true);
    cardPath.lineTo(19.414 * scale, 6.414 * scale);
    cardPath.arcToPoint(Offset(20 * scale, 7.828 * scale),
        radius: Radius.circular(2 * scale), clockwise: true);
    cardPath.lineTo(20 * scale, 20 * scale);
    cardPath.arcToPoint(Offset(18 * scale, 22 * scale),
        radius: Radius.circular(2 * scale), clockwise: true);
    cardPath.lineTo(6 * scale, 22 * scale);
    cardPath.arcToPoint(Offset(4 * scale, 20 * scale),
        radius: Radius.circular(2 * scale), clockwise: true);
    cardPath.lineTo(4 * scale, 4 * scale);
    cardPath.arcToPoint(Offset(6 * scale, 2 * scale),
        radius: Radius.circular(2 * scale), clockwise: true);
    cardPath.close();
    canvas.drawPath(cardPath, paint);

    // Chip (Animated)
    // rect x="8" y="10" width="8" height="8" rx="1"
    // M12 14v4
    // M8 14h8

    // We can animate the chip appearing or the lines drawing.
    // Let's animate the lines drawing.

    // Draw chip rect (Static or animated?)
    // Let's keep rect static and animate lines inside.
    final chipRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(8 * scale, 10 * scale, 8 * scale, 8 * scale),
      Radius.circular(1 * scale),
    );
    canvas.drawRRect(chipRect, paint);

    // Lines
    final vLine = Path();
    vLine.moveTo(12 * scale, 14 * scale);
    vLine.lineTo(12 * scale, 18 * scale);

    final hLine = Path();
    hLine.moveTo(8 * scale, 14 * scale);
    hLine.lineTo(16 * scale, 14 * scale);

    double drawProgress = progress;
    if (progress == 0) {
      drawProgress = 1.0;
    }

    if (drawProgress > 0) {
      // Draw vertical line
      final vMetrics = vLine.computeMetrics();
      for (final metric in vMetrics) {
        final extractPath =
            metric.extractPath(0.0, metric.length * drawProgress);
        canvas.drawPath(extractPath, paint);
      }

      // Draw horizontal line
      final hMetrics = hLine.computeMetrics();
      for (final metric in hMetrics) {
        final extractPath =
            metric.extractPath(0.0, metric.length * drawProgress);
        canvas.drawPath(extractPath, paint);
      }
    }
  }

  @override
  bool shouldRepaint(CardSimPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.progress != progress ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
