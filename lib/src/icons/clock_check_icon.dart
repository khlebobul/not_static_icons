import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Clock Check Icon - Clock hands rotate with checkmark
class ClockCheckIcon extends AnimatedSVGIcon {
  const ClockCheckIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 1200),
    super.strokeWidth = 2.0,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
    super.onTap,
    super.interactive,
    super.controller,
  });

  @override
  String get animationDescription => "Clock hands rotate with checkmark";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return ClockCheckPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class ClockCheckPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  ClockCheckPainter({
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

    // Partial circle: M22 12a10 10 0 1 0-11 9.95
    final circlePath = Path();
    circlePath.moveTo(22 * scale, 12 * scale);
    circlePath.arcToPoint(
      Offset(11 * scale, 21.95 * scale),
      radius: Radius.circular(10 * scale),
      clockwise: false,
      largeArc: true,
    );
    canvas.drawPath(circlePath, paint);

    // Clock hands: M12 6v6l4 2
    final oscillation = 4 * animationValue * (1 - animationValue);
    final rotation = oscillation * math.pi / 6;

    canvas.save();
    canvas.translate(12 * scale, 12 * scale);
    canvas.rotate(rotation);
    canvas.translate(-12 * scale, -12 * scale);

    canvas.drawLine(
        Offset(12 * scale, 6 * scale), Offset(12 * scale, 12 * scale), paint);
    canvas.drawLine(
        Offset(12 * scale, 12 * scale), Offset(16 * scale, 14 * scale), paint);

    canvas.restore();

    // Checkmark with scale animation: m22 16-5.5 5.5L14 19
    final checkScale = 1.0 + oscillation * 0.2;

    canvas.save();
    canvas.translate(18.25 * scale, 18.75 * scale);
    canvas.scale(checkScale);
    canvas.translate(-18.25 * scale, -18.75 * scale);

    final checkPath = Path();
    checkPath.moveTo(22 * scale, 16 * scale);
    checkPath.lineTo(16.5 * scale, 21.5 * scale);
    checkPath.lineTo(14 * scale, 19 * scale);
    canvas.drawPath(checkPath, paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(ClockCheckPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
