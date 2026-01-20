import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Bean Off Icon - bean geometry with growing slash from left-top to right-bottom
class BeanOffIcon extends AnimatedSVGIcon {
  const BeanOffIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 900),
    super.strokeWidth = 2.0,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
    super.resetToStartOnComplete = true,
    super.onTap,
    super.interactive,
    super.controller,
  });

  @override
  String get animationDescription => 'Bean off: slash draws across the bean';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return _BeanOffPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class _BeanOffPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _BeanOffPainter({
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

    // Bean shapes from bean-off.svg
    // Path 1: M9 9 c-.64 .64 -1.521 .954 -2.402 1.165 A6 6 0 0 0 8 22 a13.96 13.96 0 0 0 9.9 -4.1
    final p1 = Path()
      ..moveTo(9 * scale, 9 * scale)
      ..relativeCubicTo(
        -0.64 * scale,
        0.64 * scale,
        -1.521 * scale,
        0.954 * scale,
        -2.402 * scale,
        1.165 * scale,
      )
      ..arcToPoint(
        Offset(8 * scale, 22 * scale),
        radius: Radius.circular(6 * scale),
        clockwise: false,
      )
      ..relativeArcToPoint(
        Offset(9.9 * scale, -4.1 * scale),
        radius: Radius.circular(13.96 * scale),
        rotation: 0,
        largeArc: false,
        clockwise: false,
      );

    // Path 2: M10.75 5.093 A6 6 0 0 1 22 8 c0 2.411 -.61 4.68 -1.683 6.66
    final p2 = Path()
      ..moveTo(10.75 * scale, 5.093 * scale)
      ..arcToPoint(
        Offset(22 * scale, 8 * scale),
        radius: Radius.circular(6 * scale),
        clockwise: true,
      )
      ..relativeCubicTo(
        0,
        2.411 * scale,
        -0.61 * scale,
        4.68 * scale,
        -1.683 * scale,
        6.66 * scale,
      );

    // Path 3: M5.341 10.62 a4 4 0 0 0 6.487 1.208
    final p3 = Path()
      ..moveTo(5.341 * scale, 10.62 * scale)
      ..relativeArcToPoint(
        Offset(6.487 * scale, 1.208 * scale),
        radius: Radius.circular(4 * scale),
        rotation: 0,
        largeArc: false,
        clockwise: false,
      );

    // Path 4: M10.62 5.341 a4.015 4.015 0 0 1 2.039 2.04
    final p4 = Path()
      ..moveTo(10.62 * scale, 5.341 * scale)
      ..relativeArcToPoint(
        Offset(2.039 * scale, 2.04 * scale),
        radius: Radius.circular(4.015 * scale),
        rotation: 0,
        largeArc: false,
        clockwise: true,
      );

    // Draw bean strokes fully
    canvas.drawPath(p1, paint);
    canvas.drawPath(p2, paint);
    canvas.drawPath(p3, paint);
    canvas.drawPath(p4, paint);

    // Slash line: from (2,2) to (22,22), animated length
    final start = Offset(2 * scale, 2 * scale);
    final end = Offset(22 * scale, 22 * scale);
    if (animationValue == 0.0) {
      canvas.drawLine(start, end, paint);
      return;
    }
    final x = start.dx + (end.dx - start.dx) * animationValue;
    final y = start.dy + (end.dy - start.dy) * animationValue;
    canvas.drawLine(start, Offset(x, y), paint);
  }

  @override
  bool shouldRepaint(_BeanOffPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
