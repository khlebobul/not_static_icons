import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Crab Icon - Crab claws move
class CrabIcon extends AnimatedSVGIcon {
  const CrabIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 800),
    super.strokeWidth = 2.0,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
    super.onTap,
    super.interactive,
    super.controller,
  });

  @override
  String get animationDescription => "Crab claws move";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return CrabPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class CrabPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  CrabPainter({
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

    // Animation - claws pinch and body sways
    final oscillation = math.sin(animationValue * math.pi * 2);
    final clawAngle = oscillation * 0.15; // Claws pinch
    final bodySwayX = oscillation * 0.3 * scale; // Slight horizontal sway
    final legWiggle = math.sin(animationValue * math.pi * 4) * 0.08; // Legs wiggle faster

    canvas.save();
    canvas.translate(bodySwayX, 0);

    // Body ellipse: cx="12" cy="17.5" rx="7" ry="4.5"
    final bodyRect = Rect.fromCenter(
      center: Offset(12 * scale, 17.5 * scale),
      width: 14 * scale,
      height: 9 * scale,
    );
    canvas.drawOval(bodyRect, paint);

    // Left eye stalk: M10 13v-2
    canvas.drawLine(
      Offset(10 * scale, 13 * scale),
      Offset(10 * scale, 11 * scale),
      paint,
    );

    // Right eye stalk: M14 13v-2
    canvas.drawLine(
      Offset(14 * scale, 13 * scale),
      Offset(14 * scale, 11 * scale),
      paint,
    );

    // Left claw with animation
    canvas.save();
    canvas.translate(8.5 * scale, 8 * scale);
    canvas.rotate(-clawAngle);
    canvas.translate(-8.5 * scale, -8 * scale);

    // Left claw: M7.5 14A6 6 0 1 1 10 2.36L8 5l2 2S7 8 2 8
    final leftClawPath = Path();
    leftClawPath.moveTo(7.5 * scale, 14 * scale);
    leftClawPath.arcToPoint(
      Offset(10 * scale, 2.36 * scale),
      radius: Radius.circular(6 * scale),
      clockwise: true, // SVG sweep=1 means clockwise
      largeArc: true,
    );
    // L8 5 - line to (8,5)
    leftClawPath.lineTo(8 * scale, 5 * scale);
    // l2 2 - relative line to (10,7)
    leftClawPath.lineTo(10 * scale, 7 * scale);
    // S7 8 2 8 - smooth cubic to (2,8) with control point 2 at (7,8)
    // For smooth cubic after a line, cp1 = current point
    leftClawPath.cubicTo(
      10 * scale, 7 * scale, // cp1 (reflection, same as current after line)
      7 * scale, 8 * scale,  // cp2
      2 * scale, 8 * scale,  // end
    );
    canvas.drawPath(leftClawPath, paint);

    canvas.restore();

    // Right claw with animation
    canvas.save();
    canvas.translate(15.5 * scale, 8 * scale);
    canvas.rotate(clawAngle);
    canvas.translate(-15.5 * scale, -8 * scale);

    // Right claw: M16.5 14A6 6 0 1 0 14 2.36L16 5l-2 2s3 1 8 1
    final rightClawPath = Path();
    rightClawPath.moveTo(16.5 * scale, 14 * scale);
    rightClawPath.arcToPoint(
      Offset(14 * scale, 2.36 * scale),
      radius: Radius.circular(6 * scale),
      clockwise: false, // SVG sweep=0 means counter-clockwise
      largeArc: true,
    );
    // L16 5 - line to (16,5)
    rightClawPath.lineTo(16 * scale, 5 * scale);
    // l-2 2 - relative line to (14,7)
    rightClawPath.lineTo(14 * scale, 7 * scale);
    // s3 1 8 1 - relative smooth cubic: cp2=(14+3,7+1)=(17,8), end=(14+8,7+1)=(22,8)
    // For smooth cubic after a line, cp1 = current point
    rightClawPath.cubicTo(
      14 * scale, 7 * scale, // cp1 (reflection, same as current after line)
      17 * scale, 8 * scale, // cp2
      22 * scale, 8 * scale, // end
    );
    canvas.drawPath(rightClawPath, paint);

    canvas.restore();

    // Left front leg with animation: M2 16c2 0 3 1 3 1
    canvas.save();
    canvas.translate(3.5 * scale, 16.5 * scale);
    canvas.rotate(-legWiggle);
    canvas.translate(-3.5 * scale, -16.5 * scale);
    final leftFrontLeg = Path();
    leftFrontLeg.moveTo(2 * scale, 16 * scale);
    leftFrontLeg.cubicTo(
      4 * scale, 16 * scale,
      5 * scale, 17 * scale,
      5 * scale, 17 * scale,
    );
    canvas.drawPath(leftFrontLeg, paint);
    canvas.restore();

    // Left back leg with animation: M2 22c0-1.7 1.3-3 3-3
    canvas.save();
    canvas.translate(3.5 * scale, 20.5 * scale);
    canvas.rotate(legWiggle);
    canvas.translate(-3.5 * scale, -20.5 * scale);
    final leftBackLeg = Path();
    leftBackLeg.moveTo(2 * scale, 22 * scale);
    leftBackLeg.cubicTo(
      2 * scale, 20.3 * scale,
      3.3 * scale, 19 * scale,
      5 * scale, 19 * scale,
    );
    canvas.drawPath(leftBackLeg, paint);
    canvas.restore();

    // Right front leg with animation: M19 17s1-1 3-1
    canvas.save();
    canvas.translate(20.5 * scale, 16.5 * scale);
    canvas.rotate(legWiggle);
    canvas.translate(-20.5 * scale, -16.5 * scale);
    final rightFrontLeg = Path();
    rightFrontLeg.moveTo(19 * scale, 17 * scale);
    rightFrontLeg.cubicTo(
      19 * scale, 17 * scale,
      20 * scale, 16 * scale,
      22 * scale, 16 * scale,
    );
    canvas.drawPath(rightFrontLeg, paint);
    canvas.restore();

    // Right back leg with animation: M19 19c1.7 0 3 1.3 3 3
    canvas.save();
    canvas.translate(20.5 * scale, 20.5 * scale);
    canvas.rotate(-legWiggle);
    canvas.translate(-20.5 * scale, -20.5 * scale);
    final rightBackLeg = Path();
    rightBackLeg.moveTo(19 * scale, 19 * scale);
    rightBackLeg.cubicTo(
      20.7 * scale, 19 * scale,
      22 * scale, 20.3 * scale,
      22 * scale, 22 * scale,
    );
    canvas.drawPath(rightBackLeg, paint);
    canvas.restore();

    canvas.restore(); // Restore body sway transform
  }

  @override
  bool shouldRepaint(CrabPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
