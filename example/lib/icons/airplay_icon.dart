import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Airplay Icon - Triangle is drawn line by line.
class AirplayIcon extends AnimatedSVGIcon {
  const AirplayIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 800),
    super.strokeWidth = 2.0,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
  });

  @override
  String get animationDescription => "Triangle is drawn line by line.";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return AirplayPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

/// Painter for Airplay icon
class AirplayPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  AirplayPainter({
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
    Offset p(double x, double y) => Offset(x * scale, y * scale);

    // ========== STATIC PART - SCREEN ==========
    // Path: M5 17H4a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h16a2 2 0 0 1 2 2v10a2 2 0 0 1-2 2h-1
    final screenPath = Path()
      ..moveTo(5 * scale, 17 * scale)
      ..lineTo(4 * scale, 17 * scale)
      ..arcToPoint(p(2, 15), radius: Radius.circular(2 * scale))
      ..lineTo(2 * scale, 5 * scale)
      ..arcToPoint(p(4, 3), radius: Radius.circular(2 * scale))
      ..lineTo(20 * scale, 3 * scale)
      ..arcToPoint(p(22, 5), radius: Radius.circular(2 * scale))
      ..lineTo(22 * scale, 15 * scale)
      ..arcToPoint(p(20, 17), radius: Radius.circular(2 * scale))
      ..lineTo(19 * scale, 17 * scale);
    canvas.drawPath(screenPath, paint);

    // ========== ANIMATED PART - TRIANGLE ==========
    // Path: m12 15 5 6H7Z
    final p1 = p(12, 15);
    final p2 = p(17, 21);
    final p3 = p(7, 21);

    // If not animating, draw the complete triangle. Otherwise, run animation.
    if (animationValue == 0.0) {
      final trianglePath = Path()
        ..moveTo(p1.dx, p1.dy)
        ..lineTo(p2.dx, p2.dy)
        ..lineTo(p3.dx, p3.dy)
        ..close();
      canvas.drawPath(trianglePath, paint);
    } else {
      // Stage 1: Draw from p1 to p2
      final stage1Progress = (animationValue / 0.33).clamp(0.0, 1.0);
      final line1End = Offset.lerp(p1, p2, stage1Progress)!;
      canvas.drawLine(p1, line1End, paint);

      // Stage 2: Draw from p2 to p3
      if (animationValue > 0.33) {
        final stage2Progress = ((animationValue - 0.33) / 0.33).clamp(0.0, 1.0);
        final line2End = Offset.lerp(p2, p3, stage2Progress)!;
        canvas.drawLine(p2, line2End, paint);
      }

      // Stage 3: Draw from p3 to p1
      if (animationValue > 0.66) {
        final stage3Progress = ((animationValue - 0.66) / 0.34).clamp(0.0, 1.0);
        final line3End = Offset.lerp(p3, p1, stage3Progress)!;
        canvas.drawLine(p3, line3End, paint);
      }
    }
  }

  @override
  bool shouldRepaint(AirplayPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
