import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../core/animated_svg_icon_base.dart';

/// Animated Bug Icon - Legs wiggle
class BugIcon extends AnimatedSVGIcon {
  const BugIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 1000),
    super.strokeWidth = 2.0,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
  });

  @override
  String get animationDescription => "Bug legs wiggle";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return BugPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class BugPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  BugPainter({
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

    // Wiggle angle for legs
    // sin wave: 0 -> 1 -> 0 -> -1 -> 0
    final wiggle = math.sin(animationValue * math.pi * 4) * 0.2; // 2 cycles

    // Helper for rotating legs
    void drawRotatedPath(Path path, Offset pivot, double angle) {
      canvas.save();
      canvas.translate(pivot.dx, pivot.dy);
      canvas.rotate(angle);
      canvas.translate(-pivot.dx, -pivot.dy);
      canvas.drawPath(path, paint);
      canvas.restore();
    }

    // Body
    // M12 20v-9
    canvas.drawLine(Offset(12 * scale, 20 * scale), Offset(12 * scale, 11 * scale), paint);
    
    // M14 7a4 4 0 0 1 4 4v3a6 6 0 0 1-12 0v-3a4 4 0 0 1 4-4z
    final bodyPath = Path();
    bodyPath.moveTo(14 * scale, 7 * scale);
    bodyPath.arcToPoint(
      Offset(18 * scale, 11 * scale),
      radius: Radius.circular(4 * scale),
      clockwise: true,
    );
    bodyPath.lineTo(18 * scale, 14 * scale);
    bodyPath.arcToPoint(
      Offset(6 * scale, 14 * scale),
      radius: Radius.circular(6 * scale),
      clockwise: true,
    );
    bodyPath.lineTo(6 * scale, 11 * scale);
    bodyPath.arcToPoint(
      Offset(10 * scale, 7 * scale),
      radius: Radius.circular(4 * scale),
      clockwise: true,
    );
    bodyPath.close();
    canvas.drawPath(bodyPath, paint);

    // Head
    // M9 7.13V6a3 3 0 1 1 6 0v1.13
    final headPath = Path();
    headPath.moveTo(9 * scale, 7.13 * scale);
    headPath.lineTo(9 * scale, 6 * scale);
    headPath.arcToPoint(
      Offset(15 * scale, 6 * scale),
      radius: Radius.circular(3 * scale),
      largeArc: true,
      clockwise: true,
    );
    headPath.lineTo(15 * scale, 7.13 * scale);
    canvas.drawPath(headPath, paint);

    // Antennae
    // M14.12 3.88 16 2
    canvas.drawLine(Offset(14.12 * scale, 3.88 * scale), Offset(16 * scale, 2 * scale), paint);
    // m8 2 1.88 1.88 -> M8 2 L9.88 3.88
    canvas.drawLine(Offset(8 * scale, 2 * scale), Offset(9.88 * scale, 3.88 * scale), paint);

    // Legs (Animated)
    
    // Top Right: M21 5a4 4 0 0 1-3.55 3.97
    // Pivot roughly at (17.45, 9) - where it connects to body? Body is width 12 at y=11..14.
    // Body at y=9 is narrower.
    // Let's pivot around the connection point to the body or just wiggle.
    // Connection point is roughly (17.45, 8.97) based on path end?
    // Path ends at 21-3.55 = 17.45, 5+3.97 = 8.97.
    // Let's pivot around (17, 9).
    final trLeg = Path();
    trLeg.moveTo(21 * scale, 5 * scale);
    trLeg.arcToPoint(
      Offset(17.45 * scale, 8.97 * scale),
      radius: Radius.circular(4 * scale),
      clockwise: true,
    );
    drawRotatedPath(trLeg, Offset(17.45 * scale, 8.97 * scale), wiggle);

    // Top Left: M3 5a4 4 0 0 0 3.55 3.97
    // Pivot around (6.55, 8.97)
    final tlLeg = Path();
    tlLeg.moveTo(3 * scale, 5 * scale);
    tlLeg.arcToPoint(
      Offset(6.55 * scale, 8.97 * scale),
      radius: Radius.circular(4 * scale),
      clockwise: false,
    );
    drawRotatedPath(tlLeg, Offset(6.55 * scale, 8.97 * scale), -wiggle);

    // Middle Right: M22 13h-4
    // Pivot around (18, 13)
    final mrLeg = Path();
    mrLeg.moveTo(22 * scale, 13 * scale);
    mrLeg.lineTo(18 * scale, 13 * scale);
    drawRotatedPath(mrLeg, Offset(18 * scale, 13 * scale), -wiggle);

    // Middle Left: M6 13H2 -> M6 13 L2 13
    // Pivot around (6, 13)
    final mlLeg = Path();
    mlLeg.moveTo(6 * scale, 13 * scale);
    mlLeg.lineTo(2 * scale, 13 * scale);
    drawRotatedPath(mlLeg, Offset(6 * scale, 13 * scale), wiggle);

    // Bottom Right: M21 21a4 4 0 0 0-3.81-4
    // Pivot around (17.19, 17)
    final brLeg = Path();
    brLeg.moveTo(21 * scale, 21 * scale);
    brLeg.arcToPoint(
      Offset(17.19 * scale, 17 * scale),
      radius: Radius.circular(4 * scale),
      clockwise: false,
    );
    drawRotatedPath(brLeg, Offset(17.19 * scale, 17 * scale), wiggle);

    // Bottom Left: M3 21a4 4 0 0 1 3.81-4
    // Pivot around (6.81, 17)
    final blLeg = Path();
    blLeg.moveTo(3 * scale, 21 * scale);
    blLeg.arcToPoint(
      Offset(6.81 * scale, 17 * scale),
      radius: Radius.circular(4 * scale),
      clockwise: true,
    );
    drawRotatedPath(blLeg, Offset(6.81 * scale, 17 * scale), -wiggle);
  }

  @override
  bool shouldRepaint(BugPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
