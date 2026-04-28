import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Corner Left Down Icon - Arrow moves
class CornerLeftDownIcon extends AnimatedSVGIcon {
  const CornerLeftDownIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 800),
    super.strokeWidth = 2.0,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
    super.onTap,
    super.interactive,
    super.controller,
  });

  @override
  String get animationDescription => "Arrow moves";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return CornerLeftDownPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class CornerLeftDownPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  CornerLeftDownPainter({
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

    // Path: M20 4h-7a4 4 0 0 0-4 4v12
    final path = Path();
    path.moveTo(20 * scale, 4 * scale);
    path.lineTo(13 * scale, 4 * scale);
    path.arcToPoint(
      Offset(9 * scale, 8 * scale),
      radius: Radius.circular(4 * scale),
      clockwise: false,
    );
    path.lineTo(9 * scale, 20 * scale);
    canvas.drawPath(path, paint);

    // Arrow with movement: m14 15-5 5-5-5
    final oscillation = 4 * animationValue * (1 - animationValue);
    final arrowOffset = oscillation * 2.0;

    canvas.save();
    canvas.translate(0, arrowOffset * scale);

    final arrow = Path();
    arrow.moveTo(14 * scale, 15 * scale);
    arrow.lineTo(9 * scale, 20 * scale);
    arrow.lineTo(4 * scale, 15 * scale);
    canvas.drawPath(arrow, paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(CornerLeftDownPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
