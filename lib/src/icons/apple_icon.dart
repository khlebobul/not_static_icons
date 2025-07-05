import 'dart:math';
import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Apple Icon - Swinging side to side
class AppleIcon extends AnimatedSVGIcon {
  const AppleIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 2000),
    super.strokeWidth = 2.0,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
  });

  @override
  String get animationDescription => "Swinging side to side with bottom pivot";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return ApplePainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

/// Painter for Apple icon
class ApplePainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  ApplePainter({
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

    // Calculate swing angle - swing back and forth like a pendulum
    final swingAngle =
        sin(animationValue * 2 * pi) * 0.15; // ±8.6 degrees swing

    // Apply swinging animation with pivot at bottom center
    canvas.save();
    final pivotPoint = Offset(
      size.width / 2,
      size.height * 0.9,
    ); // Bottom center as pivot
    canvas.translate(pivotPoint.dx, pivotPoint.dy);
    canvas.rotate(swingAngle);
    canvas.translate(-pivotPoint.dx, -pivotPoint.dy);

    // Draw the apple body: M12 20.94c1.5 0 2.75 1.06 4 1.06 3 0 6-8 6-12.22A4.91 4.91 0 0 0 17 5c-2.22 0-4 1.44-5 2-1-.56-2.78-2-5-2a4.9 4.9 0 0 0-5 4.78C2 14 5 22 8 22c1.25 0 2.5-1.06 4-1.06Z
    final applePath = Path();
    applePath.moveTo(12 * scale, 20.94 * scale);
    applePath.cubicTo(
      13.5 * scale,
      20.94 * scale,
      14.75 * scale,
      22 * scale,
      16 * scale,
      22 * scale,
    );
    applePath.cubicTo(
      19 * scale,
      22 * scale,
      22 * scale,
      14 * scale,
      22 * scale,
      9.78 * scale,
    );
    applePath.cubicTo(
      22 * scale,
      7.2 * scale,
      19.91 * scale,
      5 * scale,
      17 * scale,
      5 * scale,
    );
    applePath.cubicTo(
      14.78 * scale,
      5 * scale,
      13 * scale,
      6.44 * scale,
      12 * scale,
      7 * scale,
    );
    applePath.cubicTo(
      11 * scale,
      6.44 * scale,
      9.22 * scale,
      5 * scale,
      7 * scale,
      5 * scale,
    );
    applePath.cubicTo(
      4.1 * scale,
      5 * scale,
      2 * scale,
      7.78 * scale,
      2 * scale,
      9.78 * scale,
    );
    applePath.cubicTo(
      2 * scale,
      14 * scale,
      5 * scale,
      22 * scale,
      8 * scale,
      22 * scale,
    );
    applePath.cubicTo(
      9.25 * scale,
      22 * scale,
      10.5 * scale,
      20.94 * scale,
      12 * scale,
      20.94 * scale,
    );

    canvas.drawPath(applePath, paint);

    // Draw the leaf/stem: M10 2c1 .5 2 2 2 5
    final leafPath = Path();
    leafPath.moveTo(10 * scale, 2 * scale);
    leafPath.cubicTo(
      11 * scale,
      2.5 * scale,
      12 * scale,
      4 * scale,
      12 * scale,
      7 * scale,
    );

    canvas.drawPath(leafPath, paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(ApplePainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
