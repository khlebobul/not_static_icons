import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Circle Chevron Left Icon - Chevron bounces left
class CircleChevronLeftIcon extends AnimatedSVGIcon {
  const CircleChevronLeftIcon({
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
  String get animationDescription => "Chevron bounces left";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    final oscillation = 4 * animationValue * (1 - animationValue);
    return CircleChevronLeftPainter(
      color: color,
      offset: oscillation * 2,
      strokeWidth: strokeWidth,
    );
  }
}

/// Painter for Circle Chevron Left icon
class CircleChevronLeftPainter extends CustomPainter {
  final Color color;
  final double offset;
  final double strokeWidth;

  CircleChevronLeftPainter({
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

    // Animated chevron: m14 16-4-4 4-4
    final path = Path();
    path.moveTo((14 - offset) * scale, 16 * scale);
    path.lineTo((10 - offset) * scale, 12 * scale);
    path.lineTo((14 - offset) * scale, 8 * scale);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CircleChevronLeftPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.offset != offset ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
