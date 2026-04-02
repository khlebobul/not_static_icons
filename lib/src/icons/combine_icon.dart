import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Combine Icon - Shapes move toward each other
class CombineIcon extends AnimatedSVGIcon {
  const CombineIcon({
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
  String get animationDescription => "Shapes move toward each other";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return CombinePainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class CombinePainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  CombinePainter({
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

    final oscillation = 4 * animationValue * (1 - animationValue);
    final moveOffset = oscillation * 1.5;

    // Top-left rect (moves toward center): x="3" y="3" width="7" height="7" rx="1"
    canvas.save();
    canvas.translate(moveOffset * scale, moveOffset * scale);
    final topLeftRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(3 * scale, 3 * scale, 7 * scale, 7 * scale),
      Radius.circular(1 * scale),
    );
    canvas.drawRRect(topLeftRect, paint);
    canvas.restore();

    // Bottom-right rect (moves toward center): x="14" y="14" width="7" height="7" rx="1"
    canvas.save();
    canvas.translate(-moveOffset * scale, -moveOffset * scale);
    final bottomRightRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(14 * scale, 14 * scale, 7 * scale, 7 * scale),
      Radius.circular(1 * scale),
    );
    canvas.drawRRect(bottomRightRect, paint);
    canvas.restore();

    // Top-right bracket: M14 3a1 1 0 0 1 1 1v5a1 1 0 0 1-1 1
    final topRightPath = Path();
    topRightPath.moveTo(14 * scale, 3 * scale);
    topRightPath.arcToPoint(
      Offset(15 * scale, 4 * scale),
      radius: Radius.circular(1 * scale),
      clockwise: true,
    );
    topRightPath.lineTo(15 * scale, 9 * scale);
    topRightPath.arcToPoint(
      Offset(14 * scale, 10 * scale),
      radius: Radius.circular(1 * scale),
      clockwise: true,
    );
    canvas.drawPath(topRightPath, paint);

    // M19 3a1 1 0 0 1 1 1v5a1 1 0 0 1-1 1
    final topRight2Path = Path();
    topRight2Path.moveTo(19 * scale, 3 * scale);
    topRight2Path.arcToPoint(
      Offset(20 * scale, 4 * scale),
      radius: Radius.circular(1 * scale),
      clockwise: true,
    );
    topRight2Path.lineTo(20 * scale, 9 * scale);
    topRight2Path.arcToPoint(
      Offset(19 * scale, 10 * scale),
      radius: Radius.circular(1 * scale),
      clockwise: true,
    );
    canvas.drawPath(topRight2Path, paint);

    // Bottom-left connector lines
    // M7 15l3 3
    canvas.drawLine(
      Offset(7 * scale, 15 * scale),
      Offset(10 * scale, 18 * scale),
      paint,
    );

    // M7 21l3-3H5a2 2 0 0 1-2-2v-2
    final connectorPath = Path();
    connectorPath.moveTo(7 * scale, 21 * scale);
    connectorPath.lineTo(10 * scale, 18 * scale);
    connectorPath.lineTo(5 * scale, 18 * scale);
    connectorPath.arcToPoint(
      Offset(3 * scale, 16 * scale),
      radius: Radius.circular(2 * scale),
      clockwise: true,
    );
    connectorPath.lineTo(3 * scale, 14 * scale);
    canvas.drawPath(connectorPath, paint);
  }

  @override
  bool shouldRepaint(CombinePainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
