import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../core/animated_svg_icon_base.dart';

/// Animated Anvil Icon - Squashing effect when being hammered
class AnvilIcon extends AnimatedSVGIcon {
  const AnvilIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 400),
    super.strokeWidth = 2.0,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
  });

  @override
  String get animationDescription => "Hammering squash effect";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return AnvilPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

/// Painter for Anvil icon
class AnvilPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  AnvilPainter({
    required this.color,
    required this.animationValue,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final scale = size.width / 24.0;

    // Create a sharp impact animation curve - quick squash then fast recovery
    double effectiveAnimation;
    if (animationValue < 0.3) {
      // Quick impact phase (0 to 0.3) - fast squash
      effectiveAnimation = (animationValue / 0.3) * 1.0;
    } else {
      // Fast recovery phase (0.3 to 1.0) - rapid return to normal
      effectiveAnimation = 1.0 - ((animationValue - 0.3) / 0.7);
    }

    // Calculate squash effect with the new timing
    final squashIntensity =
        effectiveAnimation * 0.2; // Slightly more compression
    final verticalScale = 1.0 - squashIntensity;
    final horizontalScale =
        1.0 + squashIntensity * 0.4; // More horizontal expansion

    // Calculate impact shake - more intense during the impact
    final shakeIntensity =
        effectiveAnimation * math.sin(animationValue * math.pi * 20);
    final shakeX = shakeIntensity * 0.5 * scale;

    canvas.save();

    // Apply the squashing transformation from the bottom center of the anvil
    final centerX = size.width / 2;
    final bottomY = size.height * 0.9; // Bottom of the anvil area

    canvas.translate(centerX + shakeX, bottomY);
    canvas.scale(horizontalScale, verticalScale);
    canvas.translate(-centerX, -bottomY);

    // Horn/handle of the anvil: M7 10H6a4 4 0 0 1-4-4 1 1 0 0 1 1-1h4
    final hornPath = Path();
    hornPath.moveTo(7 * scale, 10 * scale);
    hornPath.lineTo(6 * scale, 10 * scale);
    hornPath.cubicTo(
      2 * scale,
      10 * scale, // Start control point for curve to (2, 6)
      2 * scale,
      8 * scale, // End control point
      2 * scale,
      6 * scale, // End point
    );
    hornPath.cubicTo(
      2 * scale,
      5.4477 * scale, // Start control point for curve to (3, 5)
      2.4477 * scale,
      5 * scale, // End control point
      3 * scale,
      5 * scale, // End point
    );
    hornPath.lineTo(7 * scale, 5 * scale);
    canvas.drawPath(hornPath, paint);

    // Main body of anvil: M7 5a1 1 0 0 1 1-1h13a1 1 0 0 1 1 1 7 7 0 0 1-7 7H8a1 1 0 0 1-1-1z
    final bodyPath = Path();
    bodyPath.moveTo(7 * scale, 5 * scale);
    bodyPath.cubicTo(
      7 * scale,
      4.4477 * scale, // Start control point
      7.4477 * scale,
      4 * scale, // End control point
      8 * scale,
      4 * scale, // End point
    );
    bodyPath.lineTo(21 * scale, 4 * scale);
    bodyPath.cubicTo(
      21.5523 * scale,
      4 * scale, // Start control point
      22 * scale,
      4.4477 * scale, // End control point
      22 * scale,
      5 * scale, // End point
    );
    bodyPath.cubicTo(
      22 * scale,
      8.866 * scale, // Start control point for 7 7 arc
      19.134 * scale,
      12 * scale, // End control point
      15 * scale,
      12 * scale, // End point
    );
    bodyPath.lineTo(8 * scale, 12 * scale);
    bodyPath.cubicTo(
      7.4477 * scale,
      12 * scale, // Start control point
      7 * scale,
      11.5523 * scale, // End control point
      7 * scale,
      11 * scale, // End point
    );
    bodyPath.close();
    canvas.drawPath(bodyPath, paint);

    // Left support: M9 12v5
    final leftSupportPath = Path();
    leftSupportPath.moveTo(9 * scale, 12 * scale);
    leftSupportPath.lineTo(9 * scale, 17 * scale);
    canvas.drawPath(leftSupportPath, paint);

    // Right support: M15 12v5
    final rightSupportPath = Path();
    rightSupportPath.moveTo(15 * scale, 12 * scale);
    rightSupportPath.lineTo(15 * scale, 17 * scale);
    canvas.drawPath(rightSupportPath, paint);

    // Base: M5 20a3 3 0 0 1 3-3h8a3 3 0 0 1 3 3 1 1 0 0 1-1 1H6a1 1 0 0 1-1-1
    final basePath = Path();
    basePath.moveTo(5 * scale, 20 * scale);
    basePath.cubicTo(
      5 * scale,
      18.343 * scale, // Start control point
      6.343 * scale,
      17 * scale, // End control point
      8 * scale,
      17 * scale, // End point
    );
    basePath.lineTo(16 * scale, 17 * scale);
    basePath.cubicTo(
      17.657 * scale,
      17 * scale, // Start control point
      19 * scale,
      18.343 * scale, // End control point
      19 * scale,
      20 * scale, // End point
    );
    basePath.cubicTo(
      19 * scale,
      20.5523 * scale, // Start control point
      18.5523 * scale,
      21 * scale, // End control point
      18 * scale,
      21 * scale, // End point
    );
    basePath.lineTo(6 * scale, 21 * scale);
    basePath.cubicTo(
      5.4477 * scale,
      21 * scale, // Start control point
      5 * scale,
      20.5523 * scale, // End control point
      5 * scale,
      20 * scale, // End point
    );
    canvas.drawPath(basePath, paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(AnvilPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
