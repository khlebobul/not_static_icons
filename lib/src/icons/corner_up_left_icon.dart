import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Corner Up Left Icon - Arrow moves
class CornerUpLeftIcon extends AnimatedSVGIcon {
  const CornerUpLeftIcon({
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
    return CornerUpLeftPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class CornerUpLeftPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  CornerUpLeftPainter({
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

    // Path: M20 20v-7a4 4 0 0 0-4-4H4
    final path = Path();
    path.moveTo(20 * scale, 20 * scale);
    path.lineTo(20 * scale, 13 * scale);
    path.arcToPoint(
      Offset(16 * scale, 9 * scale),
      radius: Radius.circular(4 * scale),
      clockwise: false,
    );
    path.lineTo(4 * scale, 9 * scale);
    canvas.drawPath(path, paint);

    // Arrow with movement: M9 14 4 9l5-5
    final oscillation = 4 * animationValue * (1 - animationValue);
    final arrowOffset = oscillation * 2.0;

    canvas.save();
    canvas.translate(-arrowOffset * scale, 0);

    final arrow = Path();
    arrow.moveTo(9 * scale, 14 * scale);
    arrow.lineTo(4 * scale, 9 * scale);
    arrow.lineTo(9 * scale, 4 * scale);
    canvas.drawPath(arrow, paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(CornerUpLeftPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
