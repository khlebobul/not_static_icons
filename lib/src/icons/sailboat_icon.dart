import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Sailboat Icon - Boat rocks gently
class SailboatIcon extends AnimatedSVGIcon {
  const SailboatIcon({
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
  String get animationDescription => "Sailboat rocks gently";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return SailboatPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class SailboatPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  SailboatPainter({
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

    // Animation - sail tilts
    final oscillation = 4 * animationValue * (1 - animationValue);
    final tiltAngle = oscillation * 0.08;

    canvas.save();
    canvas.translate(10 * scale, 10 * scale);
    canvas.rotate(tiltAngle);
    canvas.translate(-10 * scale, -10 * scale);

    // Mast: M10 2v15
    canvas.drawLine(
      Offset(10 * scale, 2 * scale),
      Offset(10 * scale, 17 * scale),
      paint,
    );

    // Hull: M7 22a4 4 0 0 1-4-4 1 1 0 0 1 1-1h16a1 1 0 0 1 1 1 4 4 0 0 1-4 4z
    final hullPath = Path();
    hullPath.moveTo(7 * scale, 22 * scale);
    hullPath.arcToPoint(
      Offset(3 * scale, 18 * scale),
      radius: Radius.circular(4 * scale),
      clockwise: true,
    );
    hullPath.arcToPoint(
      Offset(4 * scale, 17 * scale),
      radius: Radius.circular(1 * scale),
      clockwise: true,
    );
    hullPath.lineTo(20 * scale, 17 * scale);
    hullPath.arcToPoint(
      Offset(21 * scale, 18 * scale),
      radius: Radius.circular(1 * scale),
      clockwise: true,
    );
    hullPath.arcToPoint(
      Offset(17 * scale, 22 * scale),
      radius: Radius.circular(4 * scale),
      clockwise: true,
    );
    hullPath.close();
    canvas.drawPath(hullPath, paint);

    // Sail: M9.159 2.46a1 1 0 0 1 1.521-.193l9.977 8.98A1 1 0 0 1 20 13H4a1 1 0 0 1-.824-1.567z
    final sailPath = Path();
    sailPath.moveTo(9.159 * scale, 2.46 * scale);
    sailPath.arcToPoint(
      Offset(10.68 * scale, 2.267 * scale),
      radius: Radius.circular(1 * scale),
      clockwise: true,
    );
    sailPath.lineTo(20.657 * scale, 11.247 * scale);
    sailPath.arcToPoint(
      Offset(20 * scale, 13 * scale),
      radius: Radius.circular(1 * scale),
      clockwise: true,
    );
    sailPath.lineTo(4 * scale, 13 * scale);
    sailPath.arcToPoint(
      Offset(3.176 * scale, 11.433 * scale),
      radius: Radius.circular(1 * scale),
      clockwise: true,
    );
    sailPath.close();
    canvas.drawPath(sailPath, paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(SailboatPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
