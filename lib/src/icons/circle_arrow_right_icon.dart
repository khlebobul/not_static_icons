import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Circle Arrow Right Icon - Arrow moves right
class CircleArrowRightIcon extends AnimatedSVGIcon {
  const CircleArrowRightIcon({
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
  String get animationDescription => "Arrow moves right";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    final oscillation = 4 * animationValue * (1 - animationValue);
    return CircleArrowRightPainter(
      color: color,
      arrowOffset: oscillation * 2,
      strokeWidth: strokeWidth,
    );
  }
}

/// Painter for Circle Arrow Right icon
class CircleArrowRightPainter extends CustomPainter {
  final Color color;
  final double arrowOffset;
  final double strokeWidth;

  CircleArrowRightPainter({
    required this.color,
    required this.arrowOffset,
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
    final center = Offset(12 * scale, 12 * scale);

    // Circle: cx="12" cy="12" r="10"
    canvas.drawCircle(center, 10 * scale, paint);

    // Animated arrow
    // Arrow head: m12 16 4-4-4-4
    final path = Path();
    path.moveTo((12 + arrowOffset) * scale, 16 * scale);
    path.lineTo((16 + arrowOffset) * scale, 12 * scale);
    path.lineTo((12 + arrowOffset) * scale, 8 * scale);
    canvas.drawPath(path, paint);

    // Horizontal line: M8 12h8
    canvas.drawLine(
      Offset((8 + arrowOffset) * scale, 12 * scale),
      Offset((16 + arrowOffset) * scale, 12 * scale),
      paint,
    );
  }

  @override
  bool shouldRepaint(CircleArrowRightPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.arrowOffset != arrowOffset ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
