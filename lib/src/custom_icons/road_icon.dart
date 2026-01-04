import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Road Icon - Road path animates
class RoadIcon extends AnimatedSVGIcon {
  const RoadIcon({
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
  String get animationDescription => "Road path animates";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return RoadPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

/// Painter for Road icon
class RoadPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  RoadPainter({
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

    final dashedPaint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;

    final scale = size.width / 24.0;

    // Animation - slight wave/pulse effect
    final oscillation = 4 * animationValue * (1 - animationValue);
    final waveOffset = oscillation * 0.5;

    // Outer road path: M22 8C20 13 17 10 15 15C13 20 10 17 8 22L2 16C4 11 7 14 9 9C11 4 14 7 16 2L22 8Z
    final roadPath = Path();
    roadPath.moveTo(22 * scale, (8 + waveOffset) * scale);
    roadPath.cubicTo(
      20 * scale, (13 + waveOffset) * scale,
      17 * scale, (10 - waveOffset) * scale,
      15 * scale, (15 + waveOffset) * scale,
    );
    roadPath.cubicTo(
      13 * scale, (20 + waveOffset) * scale,
      10 * scale, (17 - waveOffset) * scale,
      8 * scale, 22 * scale,
    );
    roadPath.lineTo(2 * scale, 16 * scale);
    roadPath.cubicTo(
      4 * scale, (11 - waveOffset) * scale,
      7 * scale, (14 + waveOffset) * scale,
      9 * scale, (9 - waveOffset) * scale,
    );
    roadPath.cubicTo(
      11 * scale, (4 - waveOffset) * scale,
      14 * scale, (7 + waveOffset) * scale,
      16 * scale, 2 * scale,
    );
    roadPath.close();
    canvas.drawPath(roadPath, paint);

    // Center dashed line: M5 19C7 14 10 17 12 12C14 7 17 10 19 5
    // Draw as dashed path
    final centerPath = Path();
    centerPath.moveTo(5 * scale, (19 - waveOffset) * scale);
    centerPath.cubicTo(
      7 * scale, (14 - waveOffset) * scale,
      10 * scale, (17 + waveOffset) * scale,
      12 * scale, 12 * scale,
    );
    centerPath.cubicTo(
      14 * scale, (7 - waveOffset) * scale,
      17 * scale, (10 + waveOffset) * scale,
      19 * scale, (5 + waveOffset) * scale,
    );

    // Draw dashed line manually
    _drawDashedPath(canvas, centerPath, dashedPaint, 2 * scale, 2 * scale);
  }

  void _drawDashedPath(Canvas canvas, Path path, Paint paint, double dashLength, double gapLength) {
    final pathMetrics = path.computeMetrics();
    for (final metric in pathMetrics) {
      double distance = 0;
      while (distance < metric.length) {
        final start = distance;
        final end = (distance + dashLength).clamp(0, metric.length);
        final extractPath = metric.extractPath(start, end.toDouble());
        canvas.drawPath(extractPath, paint);
        distance += dashLength + gapLength;
      }
    }
  }

  @override
  bool shouldRepaint(RoadPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
