import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Cigarette Icon - Smoke draws sequentially
class CigaretteIcon extends AnimatedSVGIcon {
  const CigaretteIcon({
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
    super.interactive = true,
    super.controller,
  });

  @override
  String get animationDescription => "Smoke draws sequentially";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return CigarettePainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class CigarettePainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  CigarettePainter({
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

    // Main body: M17 12H3a1 1 0 0 0-1 1v2a1 1 0 0 0 1 1h14
    final bodyPath = Path();
    bodyPath.moveTo(17 * scale, 12 * scale);
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
    bodyPath.lineTo(17 * scale, 16 * scale);
    canvas.drawPath(bodyPath, paint);

    // End cap: M21 16a1 1 0 0 0 1-1v-2a1 1 0 0 0-1-1
    final capPath = Path();
    capPath.moveTo(21 * scale, 16 * scale);
    capPath.arcToPoint(
      Offset(22 * scale, 15 * scale),
      radius: Radius.circular(1 * scale),
      clockwise: false,
    );
    capPath.lineTo(22 * scale, 13 * scale);
    capPath.arcToPoint(
      Offset(21 * scale, 12 * scale),
      radius: Radius.circular(1 * scale),
      clockwise: false,
    );
    canvas.drawPath(capPath, paint);

    // Divider: M7 12v4
    canvas.drawLine(
      Offset(7 * scale, 12 * scale),
      Offset(7 * scale, 16 * scale),
      paint,
    );

    // If no animation, draw complete smoke
    if (animationValue == 0) {
      // Smoke line 1: M18 8c0-2.5-2-2.5-2-5
      final smoke1 = Path();
      smoke1.moveTo(18 * scale, 8 * scale);
      smoke1.cubicTo(
        18 * scale,
        6.5 * scale,
        17 * scale,
        6 * scale,
        16 * scale,
        3 * scale,
      );
      canvas.drawPath(smoke1, paint);

      // Smoke line 2: M22 8c0-2.5-2-2.5-2-5
      final smoke2 = Path();
      smoke2.moveTo(22 * scale, 8 * scale);
      smoke2.cubicTo(
        22 * scale,
        6.5 * scale,
        21 * scale,
        6 * scale,
        20 * scale,
        3 * scale,
      );
      canvas.drawPath(smoke2, paint);
    } else {
      // Animation - smoke draws from bottom to top, one line at a time
      // First smoke line: 0.0 - 0.5
      // Second smoke line: 0.5 - 1.0

      // Smoke line 1: M18 8c0-2.5-2-2.5-2-5
      final smoke1Progress = (animationValue / 0.5).clamp(0.0, 1.0);

      final smoke1 = Path();
      smoke1.moveTo(18 * scale, 8 * scale);

      // Interpolate the curve based on progress
      final t = smoke1Progress;
      final y1 = 8 - (8 - 6.5) * t;
      final y2 = 8 - (8 - 3) * t;
      final x2 = 18 - (18 - 16) * t;

      smoke1.cubicTo(
        18 * scale,
        y1 * scale,
        17 * scale,
        (6 + (8 - y2) * 0.5) * scale,
        x2 * scale,
        y2 * scale,
      );
      canvas.drawPath(smoke1, paint);

      if (animationValue > 0.5) {
        // Smoke line 2: M22 8c0-2.5-2-2.5-2-5
        final smoke2Progress = ((animationValue - 0.5) / 0.5).clamp(0.0, 1.0);

        final smoke2 = Path();
        smoke2.moveTo(22 * scale, 8 * scale);

        // Interpolate the curve based on progress
        final t = smoke2Progress;
        final y1 = 8 - (8 - 6.5) * t;
        final y2 = 8 - (8 - 3) * t;
        final x2 = 22 - (22 - 20) * t;

        smoke2.cubicTo(
          22 * scale,
          y1 * scale,
          21 * scale,
          (6 + (8 - y2) * 0.5) * scale,
          x2 * scale,
          y2 * scale,
        );
        canvas.drawPath(smoke2, paint);
      }
    }
  }

  @override
  bool shouldRepaint(CigarettePainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
