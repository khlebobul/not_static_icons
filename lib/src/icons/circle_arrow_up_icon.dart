import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Circle Arrow Up Icon - Arrow moves up
class CircleArrowUpIcon extends AnimatedSVGIcon {
  const CircleArrowUpIcon({
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
  String get animationDescription => "Arrow moves up";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    final oscillation = 4 * animationValue * (1 - animationValue);
    return CircleArrowUpPainter(
      color: color,
      arrowOffset: oscillation * 2,
      strokeWidth: strokeWidth,
    );
  }
}

/// Painter for Circle Arrow Up icon
class CircleArrowUpPainter extends CustomPainter {
  final Color color;
  final double arrowOffset;
  final double strokeWidth;

  CircleArrowUpPainter({
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
    // Arrow head: m16 12-4-4-4 4
    final path = Path();
    path.moveTo(16 * scale, (12 - arrowOffset) * scale);
    path.lineTo(12 * scale, (8 - arrowOffset) * scale);
    path.lineTo(8 * scale, (12 - arrowOffset) * scale);
    canvas.drawPath(path, paint);

    // Vertical line: M12 16V8
    canvas.drawLine(
      Offset(12 * scale, (16 - arrowOffset) * scale),
      Offset(12 * scale, (8 - arrowOffset) * scale),
      paint,
    );
  }

  @override
  bool shouldRepaint(CircleArrowUpPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.arrowOffset != arrowOffset ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
