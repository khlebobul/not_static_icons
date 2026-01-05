import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Road Icon - Dashed line flows along the road
class RoadIcon extends AnimatedSVGIcon {
  const RoadIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 800),
    super.strokeWidth = 2.0,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
  });

  @override
  String get animationDescription => "Road dashes flow";

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

    final scale = size.width / 24.0;

    // Outer road path (static)
    final roadPath = Path();
    roadPath.moveTo(22 * scale, 8 * scale);
    roadPath.cubicTo(
      20 * scale,
      13 * scale,
      17 * scale,
      10 * scale,
      15 * scale,
      15 * scale,
    );
    roadPath.cubicTo(
      13 * scale,
      20 * scale,
      10 * scale,
      17 * scale,
      8 * scale,
      22 * scale,
    );
    roadPath.lineTo(2 * scale, 16 * scale);
    roadPath.cubicTo(
      4 * scale,
      11 * scale,
      7 * scale,
      14 * scale,
      9 * scale,
      9 * scale,
    );
    roadPath.cubicTo(
      11 * scale,
      4 * scale,
      14 * scale,
      7 * scale,
      16 * scale,
      2 * scale,
    );
    roadPath.close();
    canvas.drawPath(roadPath, paint);

    // Center dashed line with flowing animation
    final centerPath = Path();
    centerPath.moveTo(5 * scale, 19 * scale);
    centerPath.cubicTo(
      7 * scale,
      14 * scale,
      10 * scale,
      17 * scale,
      12 * scale,
      12 * scale,
    );
    centerPath.cubicTo(
      14 * scale,
      7 * scale,
      17 * scale,
      10 * scale,
      19 * scale,
      5 * scale,
    );

    // Animated dash offset - dashes "flow" along the path
    final dashLength = 2.5 * scale;
    final gapLength = 2.5 * scale;
    final totalDashCycle = dashLength + gapLength;
    final offset = animationValue * totalDashCycle;

    _drawAnimatedDashedPath(
        canvas, centerPath, paint, dashLength, gapLength, offset);
  }

  void _drawAnimatedDashedPath(
    Canvas canvas,
    Path path,
    Paint paint,
    double dashLength,
    double gapLength,
    double offset,
  ) {
    final pathMetrics = path.computeMetrics();
    for (final metric in pathMetrics) {
      final totalLength = metric.length;
      double distance = -offset;

      while (distance < totalLength) {
        final start = distance.clamp(0.0, totalLength);
        final end = (distance + dashLength).clamp(0.0, totalLength);

        if (end > start) {
          final extractPath = metric.extractPath(start, end);
          canvas.drawPath(extractPath, paint);
        }

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
