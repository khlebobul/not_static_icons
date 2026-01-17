import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';
import 'dart:math';

/// Animated Backpack Icon - Swings by the handle from side to side
class BackpackIcon extends AnimatedSVGIcon {
  const BackpackIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 1500),
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
      "Backpack icon that gently swings by its handle from side to side.";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return BackpackPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

/// Painter for Backpack icon
class BackpackPainter extends CustomPainter {
  final Color color;
  final double animationValue; // 0.0 to 1.0
  final double strokeWidth;

  BackpackPainter({
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

    // Calculate rotation angle for swinging
    final swingAngle = _calculateSwingAngle(animationValue);

    // Set pivot point at the top center of the backpack (between the handles)
    final pivotX = 12.0 * scale;
    final pivotY = 3.0 * scale;

    // Save the current canvas state
    canvas.save();

    // Translate to pivot point, rotate, then translate back
    canvas.translate(pivotX, pivotY);
    canvas.rotate(swingAngle);
    canvas.translate(-pivotX, -pivotY);

    // Draw the backpack
    _drawBackpack(canvas, paint, scale);

    // Restore canvas to original state
    canvas.restore();
  }

  // Calculate the swing angle based on animation value
  double _calculateSwingAngle(double t) {
    // Use sine wave for smooth back and forth motion
    // Scale to smaller angle range for subtle swinging effect
    const maxAngle = 0.15; // in radians (about 8.6 degrees)
    return sin(t * 2 * pi) * maxAngle;
  }

  void _drawBackpack(Canvas canvas, Paint paint, double scale) {
    // Draw main backpack body
    // "M4 10a4 4 0 0 1 4-4h8a4 4 0 0 1 4 4v10a2 2 0 0 1-2 2H6a2 2 0 0 1-2-2z"
    final bodyPath = Path();
    bodyPath.moveTo(4 * scale, 10 * scale);

    // a4 4 0 0 1 4-4
    bodyPath.arcToPoint(
      Offset(8 * scale, 6 * scale),
      radius: Radius.circular(4 * scale),
      rotation: 0,
      largeArc: false,
      clockwise: true,
    );

    // h8
    bodyPath.lineTo(16 * scale, 6 * scale);

    // a4 4 0 0 1 4 4
    bodyPath.arcToPoint(
      Offset(20 * scale, 10 * scale),
      radius: Radius.circular(4 * scale),
      rotation: 0,
      largeArc: false,
      clockwise: true,
    );

    // v10
    bodyPath.lineTo(20 * scale, 20 * scale);

    // a2 2 0 0 1-2 2
    bodyPath.arcToPoint(
      Offset(18 * scale, 22 * scale),
      radius: Radius.circular(2 * scale),
      rotation: 0,
      largeArc: false,
      clockwise: true,
    );

    // H6
    bodyPath.lineTo(6 * scale, 22 * scale);

    // a2 2 0 0 1-2-2
    bodyPath.arcToPoint(
      Offset(4 * scale, 20 * scale),
      radius: Radius.circular(2 * scale),
      rotation: 0,
      largeArc: false,
      clockwise: true,
    );

    // z
    bodyPath.close();

    canvas.drawPath(bodyPath, paint);

    // Draw top horizontal line: "M8 10h8"
    canvas.drawLine(
      Offset(8 * scale, 10 * scale),
      Offset(16 * scale, 10 * scale),
      paint,
    );

    // Draw bottom horizontal line: "M8 18h8"
    canvas.drawLine(
      Offset(8 * scale, 18 * scale),
      Offset(16 * scale, 18 * scale),
      paint,
    );

    // Draw front pocket: "M8 22v-6a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v6"
    final pocketPath = Path();
    pocketPath.moveTo(8 * scale, 22 * scale);
    pocketPath.lineTo(8 * scale, 16 * scale);

    // a2 2 0 0 1 2-2
    pocketPath.arcToPoint(
      Offset(10 * scale, 14 * scale),
      radius: Radius.circular(2 * scale),
      rotation: 0,
      largeArc: false,
      clockwise: true,
    );

    // h4
    pocketPath.lineTo(14 * scale, 14 * scale);

    // a2 2 0 0 1 2 2
    pocketPath.arcToPoint(
      Offset(16 * scale, 16 * scale),
      radius: Radius.circular(2 * scale),
      rotation: 0,
      largeArc: false,
      clockwise: true,
    );

    // v6
    pocketPath.lineTo(16 * scale, 22 * scale);

    canvas.drawPath(pocketPath, paint);

    // Draw handle: "M9 6V4a2 2 0 0 1 2-2h2a2 2 0 0 1 2 2v2"
    final handlePath = Path();
    handlePath.moveTo(9 * scale, 6 * scale);
    handlePath.lineTo(9 * scale, 4 * scale);

    // a2 2 0 0 1 2-2
    handlePath.arcToPoint(
      Offset(11 * scale, 2 * scale),
      radius: Radius.circular(2 * scale),
      rotation: 0,
      largeArc: false,
      clockwise: true,
    );

    // h2
    handlePath.lineTo(13 * scale, 2 * scale);

    // a2 2 0 0 1 2 2
    handlePath.arcToPoint(
      Offset(15 * scale, 4 * scale),
      radius: Radius.circular(2 * scale),
      rotation: 0,
      largeArc: false,
      clockwise: true,
    );

    // v2
    handlePath.lineTo(15 * scale, 6 * scale);

    canvas.drawPath(handlePath, paint);
  }

  @override
  bool shouldRepaint(BackpackPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
