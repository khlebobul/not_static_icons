import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Cigarette Off Icon - Slash line appears
class CigaretteOffIcon extends AnimatedSVGIcon {
  const CigaretteOffIcon({
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
    super.interactive = true,
    super.controller,
  });

  @override
  String get animationDescription => "Slash appears";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return CigaretteOffPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class CigaretteOffPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  CigaretteOffPainter({
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

    // Main body: M12 12H3a1 1 0 0 0-1 1v2a1 1 0 0 0 1 1h13
    final bodyPath = Path();
    bodyPath.moveTo(12 * scale, 12 * scale);
    bodyPath.lineTo(3 * scale, 12 * scale);
    bodyPath.arcToPoint(
      Offset(2 * scale, 13 * scale),
      radius: Radius.circular(1 * scale),
      clockwise: false,
    );
    bodyPath.lineTo(2 * scale, 15 * scale);
    bodyPath.arcToPoint(
      Offset(3 * scale, 16 * scale),
      radius: Radius.circular(1 * scale),
      clockwise: false,
    );
    bodyPath.lineTo(16 * scale, 16 * scale);
    canvas.drawPath(bodyPath, paint);

    // End cap partial: M21 12a1 1 0 0 1 1 1v2a1 1 0 0 1-.5.866
    final capPath = Path();
    capPath.moveTo(21 * scale, 12 * scale);
    capPath.arcToPoint(
      Offset(22 * scale, 13 * scale),
      radius: Radius.circular(1 * scale),
      clockwise: true,
    );
    capPath.lineTo(22 * scale, 15 * scale);
    capPath.arcToPoint(
      Offset(21.5 * scale, 15.866 * scale),
      radius: Radius.circular(1 * scale),
      clockwise: true,
    );
    canvas.drawPath(capPath, paint);

    // Divider: M7 12v4
    canvas.drawLine(
      Offset(7 * scale, 12 * scale),
      Offset(7 * scale, 16 * scale),
      paint,
    );

    // Smoke line 1: M18 8c0-2.5-2-2.5-2-5
    final smoke1 = Path();
    smoke1.moveTo(18 * scale, 8 * scale);
    smoke1.cubicTo(
      18 * scale, 6.5 * scale,
      17 * scale, 6 * scale,
      16 * scale, 3 * scale,
    );
    canvas.drawPath(smoke1, paint);

    // Smoke line 2: M22 8c0-2.5-2-2.5-2-5
    final smoke2 = Path();
    smoke2.moveTo(22 * scale, 8 * scale);
    smoke2.cubicTo(
      22 * scale, 6.5 * scale,
      21 * scale, 6 * scale,
      20 * scale, 3 * scale,
    );
    canvas.drawPath(smoke2, paint);

    // Slash line with animation: m2 2 20 20
    if (animationValue == 0) {
      // Draw complete slash when not animating
      canvas.drawLine(
        Offset(2 * scale, 2 * scale),
        Offset(22 * scale, 22 * scale),
        paint,
      );
    } else {
      // Animate slash drawing
      final slashProgress = animationValue;
      final slashLength = 20 * slashProgress;
      canvas.drawLine(
        Offset(2 * scale, 2 * scale),
        Offset((2 + slashLength) * scale, (2 + slashLength) * scale),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(CigaretteOffPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
