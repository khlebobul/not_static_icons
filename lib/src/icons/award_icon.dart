import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';
import 'dart:math';

/// Animated Award Icon - Zooms in, sways left-right, and returns to original
class AwardIcon extends AnimatedSVGIcon {
  const AwardIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 1400),
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
      "Award zooms in, sways left and right like a medal, then returns to original position.";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return AwardPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

/// Painter for Award icon
class AwardPainter extends CustomPainter {
  final Color color;
  final double animationValue; // 0.0 to 1.0
  final double strokeWidth;

  AwardPainter({
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

    // Calculate animation phases
    final zoomScale = _calculateZoomScale(animationValue);
    final swayRotation = _calculateSwayRotation(animationValue);

    canvas.save();

    // Apply transformations from center
    canvas.translate(center.dx, center.dy);
    canvas.scale(zoomScale);
    canvas.rotate(swayRotation);
    canvas.translate(-center.dx, -center.dy);

    // Draw the award icon
    _drawAward(canvas, paint, scale);

    canvas.restore();
  }

  // Calculate zoom scale: starts at 1.0, zooms to 1.3, then back to 1.0
  double _calculateZoomScale(double t) {
    if (t <= 0.3) {
      // Zoom in phase (0 to 0.3)
      final zoomProgress = t / 0.3;
      return 1.0 + zoomProgress * 0.3; // 1.0 to 1.3
    } else if (t <= 0.7) {
      // Sway phase - maintain zoom
      return 1.3;
    } else {
      // Zoom out phase (0.7 to 1.0)
      final zoomOutProgress = (t - 0.7) / 0.3;
      return 1.3 - zoomOutProgress * 0.3; // 1.3 to 1.0
    }
  }

  // Calculate sway rotation: no rotation, then one left-right sway, then back to center
  double _calculateSwayRotation(double t) {
    if (t <= 0.3) {
      // No sway during zoom in
      return 0.0;
    } else if (t <= 0.7) {
      // Sway phase (0.3 to 0.7) - two left-right motions
      final swayProgress = (t - 0.3) / 0.4;
      // Two pendulum swings: left -> right -> left -> right
      return sin(swayProgress * 2 * pi) *
          0.15; // ±8.6 degrees, two oscillations
    } else {
      // Return to center (0.7 to 1.0)
      final returnProgress = (t - 0.7) / 0.3;
      final currentSway =
          sin(1.0 * 2 * pi) * 0.15; // Last sway position (should be ~0)
      return currentSway * (1.0 - returnProgress); // Smooth return to 0
    }
  }

  void _drawAward(Canvas canvas, Paint paint, double scale) {
    // Draw the circle (medal part): circle cx="12" cy="8" r="6"
    canvas.drawCircle(
      Offset(12 * scale, 8 * scale),
      6 * scale,
      paint,
    );

    // Draw the ribbon path
    // Original path: m15.477 12.89 1.515 8.526a.5.5 0 0 1-.81.47l-3.58-2.687a1 1 0 0 0-1.197 0l-3.586 2.686a.5.5 0 0 1-.81-.469l1.514-8.526

    final ribbonPath = Path();

    // Start point: m15.477 12.89
    ribbonPath.moveTo(15.477 * scale, 12.89 * scale);

    // Line to: l1.515 8.526 (to point 16.992, 21.416)
    ribbonPath.relativeLineTo(1.515 * scale, 8.526 * scale);

    // Arc: a.5.5 0 0 1-.81.47 (to point 16.182, 21.886)
    ribbonPath.relativeArcToPoint(
      Offset(-0.81 * scale, 0.47 * scale),
      radius: Radius.circular(0.5 * scale),
      rotation: 0,
      largeArc: false,
      clockwise: true,
    );

    // Line: l-3.58-2.687 (to point 12.602, 19.199)
    ribbonPath.relativeLineTo(-3.58 * scale, -2.687 * scale);

    // Arc: a1 1 0 0 0-1.197 0 (to point 11.405, 19.199)
    ribbonPath.relativeArcToPoint(
      Offset(-1.197 * scale, 0),
      radius: Radius.circular(1 * scale),
      rotation: 0,
      largeArc: false,
      clockwise: false,
    );

    // Line: l-3.586 2.686 (to point 7.819, 21.885)
    ribbonPath.relativeLineTo(-3.586 * scale, 2.686 * scale);

    // Arc: a.5.5 0 0 1-.81-.469 (to point 7.009, 21.416)
    ribbonPath.relativeArcToPoint(
      Offset(-0.81 * scale, -0.469 * scale),
      radius: Radius.circular(0.5 * scale),
      rotation: 0,
      largeArc: false,
      clockwise: true,
    );

    // Line: l1.514-8.526 (back to start area)
    ribbonPath.relativeLineTo(1.514 * scale, -8.526 * scale);

    canvas.drawPath(ribbonPath, paint);
  }

  @override
  bool shouldRepaint(AwardPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
