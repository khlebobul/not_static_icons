import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Circle Chevron Down Icon - Chevron bounces down
class CircleChevronDownIcon extends AnimatedSVGIcon {
  const CircleChevronDownIcon({
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
  String get animationDescription => "Chevron bounces down";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    final oscillation = 4 * animationValue * (1 - animationValue);
    return CircleChevronDownPainter(
      color: color,
      offset: oscillation * 2,
      strokeWidth: strokeWidth,
    );
  }
}

/// Painter for Circle Chevron Down icon
class CircleChevronDownPainter extends CustomPainter {
  final Color color;
  final double offset;
  final double strokeWidth;

  CircleChevronDownPainter({
    required this.color,
    required this.offset,
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

    // Animated chevron: m16 10-4 4-4-4
    final path = Path();
    path.moveTo(16 * scale, (10 + offset) * scale);
    path.lineTo(12 * scale, (14 + offset) * scale);
    path.lineTo(8 * scale, (10 + offset) * scale);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CircleChevronDownPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.offset != offset ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
