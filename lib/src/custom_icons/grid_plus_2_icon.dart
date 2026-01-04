import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Grid Plus 2 Icon - Grid with plus and number 2
class GridPlus2Icon extends AnimatedSVGIcon {
  const GridPlus2Icon({
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
  String get animationDescription => "Grid Plus 2 animates";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return GridPlus2Painter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

/// Painter for Grid Plus 2 icon
class GridPlus2Painter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  GridPlus2Painter({
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

    // Animation - pulse scale for symbols
    final oscillation = 4 * animationValue * (1 - animationValue);
    final symbolScale = 1.0 + oscillation * 0.15;

    // Grid path (normalized to 24x24)
    final gridPath = Path();
    gridPath.moveTo(12 * scale, 3 * scale);
    gridPath.lineTo(12 * scale, 20 * scale);
    gridPath.cubicTo(
      12 * scale,
      20.2652 * scale,
      11.8946 * scale,
      20.5196 * scale,
      11.7071 * scale,
      20.7071 * scale,
    );
    gridPath.cubicTo(
      11.5196 * scale,
      20.8946 * scale,
      11.2652 * scale,
      21 * scale,
      11 * scale,
      21 * scale,
    );
    gridPath.lineTo(5 * scale, 21 * scale);
    gridPath.cubicTo(
      4.46957 * scale,
      21 * scale,
      3.96086 * scale,
      20.7893 * scale,
      3.58579 * scale,
      20.4142 * scale,
    );
    gridPath.cubicTo(
      3.21071 * scale,
      20.0391 * scale,
      3 * scale,
      19.5304 * scale,
      3 * scale,
      19 * scale,
    );
    gridPath.lineTo(3 * scale, 5 * scale);
    gridPath.cubicTo(
      3 * scale,
      4.46957 * scale,
      3.21071 * scale,
      3.96086 * scale,
      3.58579 * scale,
      3.58579 * scale,
    );
    gridPath.cubicTo(
      3.96086 * scale,
      3.21071 * scale,
      4.46957 * scale,
      3 * scale,
      5 * scale,
      3 * scale,
    );
    gridPath.lineTo(19 * scale, 3 * scale);
    gridPath.cubicTo(
      19.5304 * scale,
      3 * scale,
      20.0391 * scale,
      3.21071 * scale,
      20.4142 * scale,
      3.58579 * scale,
    );
    gridPath.cubicTo(
      20.7893 * scale,
      3.96086 * scale,
      21 * scale,
      4.46957 * scale,
      21 * scale,
      5 * scale,
    );
    gridPath.lineTo(21 * scale, 11 * scale);
    gridPath.cubicTo(
      21 * scale,
      11.2652 * scale,
      20.8946 * scale,
      11.5196 * scale,
      20.7071 * scale,
      11.7071 * scale,
    );
    gridPath.cubicTo(
      20.5196 * scale,
      11.8946 * scale,
      20.2652 * scale,
      12 * scale,
      20 * scale,
      12 * scale,
    );
    gridPath.lineTo(3 * scale, 12 * scale);
    canvas.drawPath(gridPath, paint);

    // Plus and 2 symbols
    canvas.save();
    final symbolCenterX = 18 * scale;
    final symbolCenterY = 18 * scale;
    canvas.translate(symbolCenterX, symbolCenterY);
    canvas.scale(symbolScale);
    canvas.translate(-symbolCenterX, -symbolCenterY);

    final textPainter = TextPainter(
      text: TextSpan(
        text: '+2',
        style: TextStyle(
          color: color,
          fontSize: 6 * scale,
          fontWeight: FontWeight.w500,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(canvas, Offset(14 * scale, 15 * scale));

    canvas.restore();
  }

  @override
  bool shouldRepaint(GridPlus2Painter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
