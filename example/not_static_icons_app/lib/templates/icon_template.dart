import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/*
 * TEMPLATE FOR CREATING NEW ANIMATED ICONS
 *
 * Instructions:
 * 1. Copy this template
 * 2. Replace "Template" with your icon name
 * 3. Implement the paint() method in TemplatePainter
 * 4. Customize animation parameters as needed
 * 5. Add your icon to the demo page
 */

/// Animated Template Icon - [Describe your animation]
class AnimatedTemplateIcon extends AnimatedSVGIcon {
  const AnimatedTemplateIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 600),
    super.strokeWidth = 3.0,
    super.reverseOnExit =
        false, // Set to true if you want animation to reverse when hover/touch ends
    super.enableTouchInteraction =
        true, // Set to false to disable touch interaction
  });

  @override
  String get animationDescription => "Describe your animation here";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return TemplatePainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

/// Painter for Template icon
class TemplatePainter extends CustomPainter {
  final Color color;
  final double animationValue; // 0.0 to 1.0
  final double strokeWidth;

  TemplatePainter({
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

    final scaleFactor = size.width / 24.0; // SVG is usually 24x24

    // Use animationValue (0.0 - 1.0) for animation

    // Examples of different animation types:

    // 1. Moving elements:
    // Offset animatedPoint(double x, double y) {
    //   return Offset(x * scaleFactor, (y + animationValue * offset) * scaleFactor);
    // }

    // 2. Scaling:
    // canvas.save();
    // canvas.translate(center.dx, center.dy);
    // canvas.scale(1.0 + animationValue * 0.2);
    // canvas.translate(-center.dx, -center.dy);
    // // Draw your icon here
    // canvas.restore();

    // 3. Rotation:
    // canvas.save();
    // canvas.translate(center.dx, center.dy);
    // canvas.rotate(animationValue * 2 * pi);
    // canvas.translate(-center.dx, -center.dy);
    // // Draw your icon here
    // canvas.restore();

    // 4. Opacity/Color changes:
    // final animatedPaint = Paint()
    //   ..color = color.withOpacity(0.5 + animationValue * 0.5)
    //   ..strokeWidth = strokeWidth;

    // Example static drawing:
    canvas.drawLine(
      Offset(6 * scaleFactor, 12 * scaleFactor),
      Offset(18 * scaleFactor, 12 * scaleFactor),
      paint,
    );
  }

  @override
  bool shouldRepaint(TemplatePainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}

/*
 * COMMON SVG PATH COMMANDS TO FLUTTER CONVERSIONS:
 * 
 * M x y        -> Move to point
 * L x y        -> Line to point
 * H x          -> Horizontal line to x
 * V y          -> Vertical line to y
 * C x1 y1 x2 y2 x y -> Cubic bezier curve
 * Q x1 y1 x y  -> Quadratic bezier curve
 * A rx ry... x y -> Arc
 * Z            -> Close path
 * 
 * Flutter equivalents:
 * path.moveTo(x, y)
 * path.lineTo(x, y)
 * path.lineTo(x, currentY) // for H
 * path.lineTo(currentX, y) // for V
 * path.cubicTo(x1, y1, x2, y2, x, y)
 * path.quadraticBezierTo(x1, y1, x, y)
 * path.arcTo(rect, startAngle, sweepAngle, forceMoveTo)
 * path.close()
 * 
 * Or use canvas.drawLine(), canvas.drawCircle(), etc. for simple shapes
 */
