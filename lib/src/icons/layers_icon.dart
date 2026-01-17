import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Layers Icon - Layers separate and come back
class LayersIcon extends AnimatedSVGIcon {
  const LayersIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 600),
    super.strokeWidth = 2.0,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
    super.onTap,
    super.interactive,
    super.controller,
  });

  @override
  String get animationDescription => "Layers separate";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return LayersPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

/// Painter for Layers icon
class LayersPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  LayersPainter({
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

    // Animation - layers separate vertically
    final oscillation = 4 * animationValue * (1 - animationValue);
    final separation = oscillation * 2.0;

    // Top layer (moves up)
    final topLayerPath = Path();
    topLayerPath.moveTo(12 * scale, (2 - separation) * scale);
    topLayerPath.lineTo(2.6 * scale, (6 - separation) * scale);
    topLayerPath.lineTo(2.6 * scale, (7 - separation) * scale);
    topLayerPath.lineTo(12 * scale, (11 - separation) * scale);
    topLayerPath.lineTo(21.4 * scale, (7 - separation) * scale);
    topLayerPath.lineTo(21.4 * scale, (6 - separation) * scale);
    topLayerPath.close();
    canvas.drawPath(topLayerPath, paint);

    // Middle layer (stays in place)
    final middleLayerPath = Path();
    middleLayerPath.moveTo(2 * scale, 12 * scale);
    middleLayerPath.lineTo(12 * scale, 16.5 * scale);
    middleLayerPath.lineTo(22 * scale, 12 * scale);
    canvas.drawPath(middleLayerPath, paint);

    // Bottom layer (moves down)
    final bottomLayerPath = Path();
    bottomLayerPath.moveTo(2 * scale, (17 + separation) * scale);
    bottomLayerPath.lineTo(12 * scale, (21.5 + separation) * scale);
    bottomLayerPath.lineTo(22 * scale, (17 + separation) * scale);
    canvas.drawPath(bottomLayerPath, paint);
  }

  @override
  bool shouldRepaint(LayersPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
