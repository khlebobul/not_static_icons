import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Corner Right Down Icon - Arrow moves
class CornerRightDownIcon extends AnimatedSVGIcon {
  const CornerRightDownIcon({
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
    return CornerRightDownPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class CornerRightDownPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  CornerRightDownPainter({
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

    // Path: M4 4h7a4 4 0 0 1 4 4v12
    final path = Path();
    path.moveTo(4 * scale, 4 * scale);
    path.lineTo(11 * scale, 4 * scale);
    path.arcToPoint(
      Offset(15 * scale, 8 * scale),
      radius: Radius.circular(4 * scale),
      clockwise: true,
    );
    path.lineTo(15 * scale, 20 * scale);
    canvas.drawPath(path, paint);

    // Arrow with movement: m10 15 5 5 5-5
    final oscillation = 4 * animationValue * (1 - animationValue);
    final arrowOffset = oscillation * 2.0;

    canvas.save();
    canvas.translate(0, arrowOffset * scale);

    final arrow = Path();
    arrow.moveTo(10 * scale, 15 * scale);
    arrow.lineTo(15 * scale, 20 * scale);
    arrow.lineTo(20 * scale, 15 * scale);
    canvas.drawPath(arrow, paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(CornerRightDownPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
