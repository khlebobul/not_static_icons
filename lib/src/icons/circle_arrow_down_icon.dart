import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Circle Arrow Down Icon - Arrow moves down
class CircleArrowDownIcon extends AnimatedSVGIcon {
  const CircleArrowDownIcon({
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
  String get animationDescription => "Arrow moves down";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    final oscillation = 4 * animationValue * (1 - animationValue);
    return CircleArrowDownPainter(
      color: color,
      arrowOffset: oscillation * 2,
      strokeWidth: strokeWidth,
    );
  }
}

/// Painter for Circle Arrow Down icon
class CircleArrowDownPainter extends CustomPainter {
  final Color color;
  final double arrowOffset;
  final double strokeWidth;

  CircleArrowDownPainter({
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
    // Vertical line: M12 8v8
    canvas.drawLine(
      Offset(12 * scale, (8 + arrowOffset) * scale),
      Offset(12 * scale, (16 + arrowOffset) * scale),
      paint,
    );

    // Arrow head: m8 12 4 4 4-4
    final path = Path();
    path.moveTo(8 * scale, (12 + arrowOffset) * scale);
    path.lineTo(12 * scale, (16 + arrowOffset) * scale);
    path.lineTo(16 * scale, (12 + arrowOffset) * scale);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CircleArrowDownPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.arrowOffset != arrowOffset ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
