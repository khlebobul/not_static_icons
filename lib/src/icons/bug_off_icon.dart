import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../core/animated_svg_icon_base.dart';

/// Animated Bug Off Icon - Bug shakes "no"
class BugOffIcon extends AnimatedSVGIcon {
  const BugOffIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 600),
    super.strokeWidth = 2.0,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
    super.onTap,
    super.interactive,
    super.controller,
  });

  @override
  String get animationDescription => "Bug shakes and slash appears";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return BugOffPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class BugOffPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  BugOffPainter({
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

    // Shake animation for bug parts AND slash
    final shake =
        math.sin(animationValue * math.pi * 3) * 1.0 * scale; // 3 shakes

    canvas.save();
    // Apply shake to everything
    canvas.translate(shake, 0);

    // Bug Parts (Static relative to shake)

    // M12 20v-8
    canvas.drawLine(
        Offset(12 * scale, 20 * scale), Offset(12 * scale, 12 * scale), paint);

    // M14.12 3.88 16 2 (Right Antenna)
    canvas.drawLine(Offset(14.12 * scale, 3.88 * scale),
        Offset(16 * scale, 2 * scale), paint);

    // M15 7.13V6a3 3 0 0 0-5.14-2.1L8 2 (Head + Left Antenna part?)
    // SVG: M15 7.13V6a3 3 0 0 0-5.14-2.1L8 2
    final headPath = Path();
    headPath.moveTo(15 * scale, 7.13 * scale);
    headPath.lineTo(15 * scale, 6 * scale);
    headPath.arcToPoint(
      Offset(9.86 * scale, 3.9 * scale), // 15 + dx, 6 + dy? No, absolute.
      // Start 15,6. Arc to 9.86, 3.9.
      radius: Radius.circular(3 * scale),
      clockwise: false,
    );
    headPath.lineTo(8 * scale, 2 * scale);
    canvas.drawPath(headPath, paint);

    // M18 12.34V11a4 4 0 0 0-4-4h-1.3 (Right Body Top)
    final bodyTR = Path();
    bodyTR.moveTo(18 * scale, 12.34 * scale);
    bodyTR.lineTo(18 * scale, 11 * scale);
    bodyTR.arcToPoint(
      Offset(14 * scale, 7 * scale),
      radius: Radius.circular(4 * scale),
      clockwise: false,
    );
    bodyTR.lineTo(12.7 * scale, 7 * scale);
    canvas.drawPath(bodyTR, paint);

    // M21 5a4 4 0 0 1-3.55 3.97 (Top Right Leg)
    final trLeg = Path();
    trLeg.moveTo(21 * scale, 5 * scale);
    trLeg.arcToPoint(
      Offset(17.45 * scale, 8.97 * scale),
      radius: Radius.circular(4 * scale),
      clockwise: true,
    );
    canvas.drawPath(trLeg, paint);

    // M22 13h-3.34 (Middle Right Leg)
    canvas.drawLine(Offset(22 * scale, 13 * scale),
        Offset(18.66 * scale, 13 * scale), paint);

    // M3 21a4 4 0 0 1 3.81-4 (Bottom Left Leg)
    final blLeg = Path();
    blLeg.moveTo(3 * scale, 21 * scale);
    blLeg.arcToPoint(
      Offset(6.81 * scale, 17 * scale),
      radius: Radius.circular(4 * scale),
      clockwise: true,
    );
    canvas.drawPath(blLeg, paint);

    // M6 13H2 (Middle Left Leg)
    canvas.drawLine(
        Offset(6 * scale, 13 * scale), Offset(2 * scale, 13 * scale), paint);

    // M7.7 7.7A4 4 0 0 0 6 11v3a6 6 0 0 0 11.13 3.13 (Left Body + Bottom Body)
    final bodyLeft = Path();
    bodyLeft.moveTo(7.7 * scale, 7.7 * scale);
    bodyLeft.arcToPoint(
      Offset(6 * scale, 11 * scale),
      radius: Radius.circular(4 * scale),
      clockwise: false,
    );
    bodyLeft.lineTo(6 * scale, 14 * scale);
    bodyLeft.arcToPoint(
      Offset(17.13 * scale, 17.13 * scale),
      radius: Radius.circular(6 * scale),
      clockwise: false,
    );
    canvas.drawPath(bodyLeft, paint);

    // Slash (Static, but shakes with bug)
    // m2 2 20 20
    canvas.drawLine(
        Offset(2 * scale, 2 * scale), Offset(22 * scale, 22 * scale), paint);

    canvas.restore(); // End shake
  }

  @override
  bool shouldRepaint(BugOffPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
