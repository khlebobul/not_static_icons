import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Cooking Pot Icon - Pot wobbles
class CookingPotIcon extends AnimatedSVGIcon {
  const CookingPotIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 700),
    super.strokeWidth = 2.0,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
    super.onTap,
    super.interactive,
    super.controller,
  });

  @override
  String get animationDescription => "Pot wobbles";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return CookingPotPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class CookingPotPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  CookingPotPainter({
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

    final oscillation = 4 * animationValue * (1 - animationValue);
    final wobble = oscillation * 1.0;

    // Lid line (animated): M2 12h20
    canvas.drawLine(
      Offset((2 - wobble) * scale, 12 * scale),
      Offset((22 + wobble) * scale, 12 * scale),
      paint,
    );

    // Pot body (static): M20 12v8a2 2 0 0 1-2 2H6a2 2 0 0 1-2-2v-8
    final potPath = Path();
    potPath.moveTo(20 * scale, 12 * scale);
    potPath.lineTo(20 * scale, 20 * scale);
    potPath.arcToPoint(
      Offset(18 * scale, 22 * scale),
      radius: Radius.circular(2 * scale),
      clockwise: true,
    );
    potPath.lineTo(6 * scale, 22 * scale);
    potPath.arcToPoint(
      Offset(4 * scale, 20 * scale),
      radius: Radius.circular(2 * scale),
      clockwise: true,
    );
    potPath.lineTo(4 * scale, 12 * scale);
    canvas.drawPath(potPath, paint);

    // Handle (animated): m4 8 16-4
    canvas.drawLine(
      Offset(4 * scale, (8 - wobble * 0.5) * scale),
      Offset(20 * scale, (4 + wobble * 0.5) * scale),
      paint,
    );

    // Handle grip:
    // m8.86 6.78-.45-1.81a2 2 0 0 1 1.45-2.43l1.94-.48a2 2 0 0 1 2.43 1.46l.45 1.8
    final gripPath = Path();
    gripPath.moveTo(8.86 * scale, 6.78 * scale);
    gripPath.lineTo(8.41 * scale, 4.97 * scale);
    gripPath.arcToPoint(
      Offset(9.86 * scale, 2.54 * scale),
      radius: Radius.circular(2 * scale),
      clockwise: true,
    );
    gripPath.lineTo(11.8 * scale, 2.06 * scale);
    gripPath.arcToPoint(
      Offset(14.23 * scale, 3.52 * scale),
      radius: Radius.circular(2 * scale),
      clockwise: true,
    );
    gripPath.lineTo(14.68 * scale, 5.32 * scale);
    canvas.drawPath(gripPath, paint);
  }

  @override
  bool shouldRepaint(CookingPotPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
