import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';
import 'dart:math';

/// Animated Axe Icon - Performs a striking motion
class AxeIcon extends AnimatedSVGIcon {
  const AxeIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 1000),
    super.strokeWidth = 2.0,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
    super.onTap,
    super.interactive,
    super.controller,
  });

  @override
  String get animationDescription =>
      "Axe rotates back and performs a striking motion downward, then returns to original position.";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return AxePainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

/// Painter for Axe icon
class AxePainter extends CustomPainter {
  final Color color;
  final double animationValue; // 0.0 to 1.0
  final double strokeWidth;

  AxePainter({
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
    final center = Offset(size.width / 2, size.height / 2);

    // Calculate strike rotation
    final strikeRotation = _calculateStrikeRotation(animationValue);

    canvas.save();

    // Apply rotation from center point
    canvas.translate(center.dx, center.dy);
    canvas.rotate(strikeRotation);
    canvas.translate(-center.dx, -center.dy);

    // Draw the axe icon
    _drawAxe(canvas, paint, scale);

    canvas.restore();
  }

  // Calculate strike rotation: back swing -> strike -> return
  double _calculateStrikeRotation(double t) {
    if (t <= 0.3) {
      // Back swing phase (0 to 0.3) - rotate counter-clockwise
      final backSwingProgress = t / 0.3;
      // Smooth ease out for back swing
      final easedProgress = 1 - pow(1 - backSwingProgress, 3);
      return -easedProgress * 0.6; // -34.4 degrees max
    } else if (t <= 0.6) {
      // Strike phase (0.3 to 0.6) - fast rotation clockwise
      final strikeProgress = (t - 0.3) / 0.3;
      // Fast ease in for strike
      final easedProgress = pow(strikeProgress, 2);
      return -0.6 + easedProgress * 1.2; // From -34.4° to +34.4°
    } else {
      // Return phase (0.6 to 1.0) - slow return to center
      final returnProgress = (t - 0.6) / 0.4;
      // Smooth ease out for return
      final easedProgress = 1 - pow(1 - returnProgress, 2);
      return 0.6 - easedProgress * 0.6; // From +34.4° to 0°
    }
  }

  void _drawAxe(Canvas canvas, Paint paint, double scale) {
    // Draw the first path (handle/shaft part)
    // Original: m14 12-8.381 8.38a1 1 0 0 1-3.001-3L11 9
    final handlePath = Path();

    // Start point: m14 12
    handlePath.moveTo(14 * scale, 12 * scale);

    // Line to: l-8.381 8.38 (to point 5.619, 20.38)
    handlePath.relativeLineTo(-8.381 * scale, 8.38 * scale);

    // Arc: a1 1 0 0 1-3.001-3 (to point 2.618, 17.38)
    handlePath.relativeArcToPoint(
      Offset(-3.001 * scale, -3 * scale),
      radius: Radius.circular(1 * scale),
      rotation: 0,
      largeArc: false,
      clockwise: true,
    );

    // Line: L11 9 (to point 11, 9)
    handlePath.lineTo(11 * scale, 9 * scale);

    canvas.drawPath(handlePath, paint);

    // Draw the second path (axe head)
    // Original: M15 15.5a.5.5 0 0 0 .5.5A6.5 6.5 0 0 0 22 9.5a.5.5 0 0 0-.5-.5h-1.672a2 2 0 0 1-1.414-.586l-5.062-5.062a1.205 1.205 0 0 0-1.704 0L9.352 5.648a1.205 1.205 0 0 0 0 1.704l5.062 5.062A2 2 0 0 1 15 13.828z
    final axeHeadPath = Path();

    // Start point: M15 15.5
    axeHeadPath.moveTo(15 * scale, 15.5 * scale);

    // Arc: a.5.5 0 0 0 .5.5 (to point 15.5, 16)
    axeHeadPath.relativeArcToPoint(
      Offset(0.5 * scale, 0.5 * scale),
      radius: Radius.circular(0.5 * scale),
      rotation: 0,
      largeArc: false,
      clockwise: false,
    );

    // Arc: A6.5 6.5 0 0 0 22 9.5 (to point 22, 9.5)
    axeHeadPath.arcToPoint(
      Offset(22 * scale, 9.5 * scale),
      radius: Radius.circular(6.5 * scale),
      rotation: 0,
      largeArc: false,
      clockwise: false,
    );

    // Arc: a.5.5 0 0 0-.5-.5 (to point 21.5, 9)
    axeHeadPath.relativeArcToPoint(
      Offset(-0.5 * scale, -0.5 * scale),
      radius: Radius.circular(0.5 * scale),
      rotation: 0,
      largeArc: false,
      clockwise: false,
    );

    // Line: h-1.672 (to point 19.828, 9)
    axeHeadPath.relativeLineTo(-1.672 * scale, 0);

    // Arc: a2 2 0 0 1-1.414-.586 (to point 18.414, 8.414)
    axeHeadPath.relativeArcToPoint(
      Offset(-1.414 * scale, -0.586 * scale),
      radius: Radius.circular(2 * scale),
      rotation: 0,
      largeArc: false,
      clockwise: true,
    );

    // Line: l-5.062-5.062 (to point 13.352, 3.352)
    axeHeadPath.relativeLineTo(-5.062 * scale, -5.062 * scale);

    // Arc: a1.205 1.205 0 0 0-1.704 0 (to point 11.648, 3.352)
    axeHeadPath.relativeArcToPoint(
      Offset(-1.704 * scale, 0),
      radius: Radius.circular(1.205 * scale),
      rotation: 0,
      largeArc: false,
      clockwise: false,
    );

    // Line: L9.352 5.648 (to point 9.352, 5.648)
    axeHeadPath.lineTo(9.352 * scale, 5.648 * scale);

    // Arc: a1.205 1.205 0 0 0 0 1.704 (to point 9.352, 7.352)
    axeHeadPath.relativeArcToPoint(
      Offset(0, 1.704 * scale),
      radius: Radius.circular(1.205 * scale),
      rotation: 0,
      largeArc: false,
      clockwise: false,
    );

    // Line: l5.062 5.062 (to point 14.414, 12.414)
    axeHeadPath.relativeLineTo(5.062 * scale, 5.062 * scale);

    // Arc: A2 2 0 0 1 15 13.828 (to point 15, 13.828)
    axeHeadPath.arcToPoint(
      Offset(15 * scale, 13.828 * scale),
      radius: Radius.circular(2 * scale),
      rotation: 0,
      largeArc: false,
      clockwise: true,
    );

    // Close path: z
    axeHeadPath.close();

    canvas.drawPath(axeHeadPath, paint);
  }

  @override
  bool shouldRepaint(AxePainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
