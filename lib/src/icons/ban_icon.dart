import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Ban Icon - Sequentially erases and redraws elements
class BanIcon extends AnimatedSVGIcon {
  const BanIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 1200),
    super.strokeWidth = 2.0,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
  });

  @override
  String get animationDescription => "Icon erases and redraws circle then line";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return BanPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

/// Painter for Ban icon
class BanPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  BanPainter({
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

    // Define the paths
    final circlePath = Path()
      ..addOval(Rect.fromCircle(
        center: Offset(12 * scale, 12 * scale),
        radius: 10 * scale,
      ));

    final linePath = Path()
      ..moveTo(4.9 * scale, 4.9 * scale)
      ..lineTo(19.1 * scale, 19.1 * scale);

    // Animation phases:
    // 0.0-0.3: Erase everything (show nothing)
    // 0.3-0.7: Draw circle
    // 0.7-1.0: Draw line

    // If not animating or at the start, draw the complete icon
    if (animationValue == 0.0) {
      canvas.drawPath(circlePath, paint);
      canvas.drawPath(linePath, paint);
      return;
    }

    // Phase 1: Erase everything (0.0-0.3)
    if (animationValue <= 0.3) {
      // Draw nothing
      return;
    }

    // Phase 2: Draw circle (0.3-0.7)
    if (animationValue <= 0.7) {
      final circleProgress = ((animationValue - 0.3) / 0.4).clamp(0.0, 1.0);
      for (final metric in circlePath.computeMetrics()) {
        final extract = metric.extractPath(0, metric.length * circleProgress);
        canvas.drawPath(extract, paint);
      }
      return;
    }

    // Phase 3: Draw circle and line (0.7-1.0)
    // Circle is fully drawn
    canvas.drawPath(circlePath, paint);

    // Draw line with progress
    final lineProgress = ((animationValue - 0.7) / 0.3).clamp(0.0, 1.0);
    for (final metric in linePath.computeMetrics()) {
      final extract = metric.extractPath(0, metric.length * lineProgress);
      canvas.drawPath(extract, paint);
    }
  }

  @override
  bool shouldRepaint(BanPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
