import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Circle Fading Arrow Up Icon - Arrow moves up with fading circle
class CircleFadingArrowUpIcon extends AnimatedSVGIcon {
  const CircleFadingArrowUpIcon({
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
    return CircleFadingArrowUpPainter(
      color: color,
      arrowOffset: oscillation * 2,
      strokeWidth: strokeWidth,
    );
  }
}

/// Painter for Circle Fading Arrow Up icon
class CircleFadingArrowUpPainter extends CustomPainter {
  final Color color;
  final double arrowOffset;
  final double strokeWidth;

  CircleFadingArrowUpPainter({
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
    final rect = Rect.fromCircle(center: center, radius: 10 * scale);

    // Main arc: M12 2a10 10 0 0 1 7.38 16.75
    // This is a large arc from (12,2) to (19.38, 18.75)
    // Start at top, sweep clockwise to bottom right
    canvas.drawArc(rect, -math.pi / 2, math.pi * 0.85, false, paint);

    // Small arc segments around the circle (fading effect)
    // M2.5 8.875a10 10 0 0 0-.5 3
    final path1 = Path();
    path1.moveTo(2.5 * scale, 8.875 * scale);
    path1.arcToPoint(
      Offset(2 * scale, 11.875 * scale),
      radius: Radius.circular(10 * scale),
      clockwise: false,
    );
    canvas.drawPath(path1, paint);

    // M2.83 16a10 10 0 0 0 2.43 3.4
    final path2 = Path();
    path2.moveTo(2.83 * scale, 16 * scale);
    path2.arcToPoint(
      Offset(5.26 * scale, 19.4 * scale),
      radius: Radius.circular(10 * scale),
      clockwise: false,
    );
    canvas.drawPath(path2, paint);

    // M4.636 5.235a10 10 0 0 1 .891-.857
    final path3 = Path();
    path3.moveTo(4.636 * scale, 5.235 * scale);
    path3.arcToPoint(
      Offset(5.527 * scale, 4.378 * scale),
      radius: Radius.circular(10 * scale),
      clockwise: true,
    );
    canvas.drawPath(path3, paint);

    // M8.644 21.42a10 10 0 0 0 7.631-.38
    final path4 = Path();
    path4.moveTo(8.644 * scale, 21.42 * scale);
    path4.arcToPoint(
      Offset(16.275 * scale, 21.04 * scale),
      radius: Radius.circular(10 * scale),
      clockwise: false,
    );
    canvas.drawPath(path4, paint);

    // Animated arrow
    // Arrow head: m16 12-4-4-4 4
    final arrowPath = Path();
    arrowPath.moveTo(16 * scale, (12 - arrowOffset) * scale);
    arrowPath.lineTo(12 * scale, (8 - arrowOffset) * scale);
    arrowPath.lineTo(8 * scale, (12 - arrowOffset) * scale);
    canvas.drawPath(arrowPath, paint);

    // Arrow line: M12 16V8
    canvas.drawLine(
      Offset(12 * scale, (16 - arrowOffset) * scale),
      Offset(12 * scale, (8 - arrowOffset) * scale),
      paint,
    );
  }

  @override
  bool shouldRepaint(CircleFadingArrowUpPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.arrowOffset != arrowOffset ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
