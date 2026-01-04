import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Sun Icon - Rays extend outward
class SunIcon extends AnimatedSVGIcon {
  const SunIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 600),
    super.strokeWidth = 2.0,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
  });

  @override
  String get animationDescription => "Sun rays extend outward";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return SunPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

/// Painter for Sun icon
class SunPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  SunPainter({
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
    final center = Offset(12 * scale, 12 * scale);

    // Animation - rays extend outward
    final oscillation = 4 * animationValue * (1 - animationValue);
    final rayExtend = oscillation * 1.5;

    // Center circle: cx="12" cy="12" r="4"
    canvas.drawCircle(center, 4 * scale, paint);

    // Top ray: M12 2v2 (extends up)
    canvas.drawLine(
      Offset(12 * scale, (2 - rayExtend) * scale),
      Offset(12 * scale, 4 * scale),
      paint,
    );

    // Bottom ray: M12 20v2 (extends down)
    canvas.drawLine(
      Offset(12 * scale, 20 * scale),
      Offset(12 * scale, (22 + rayExtend) * scale),
      paint,
    );

    // Left ray: M2 12h2 (extends left)
    canvas.drawLine(
      Offset((2 - rayExtend) * scale, 12 * scale),
      Offset(4 * scale, 12 * scale),
      paint,
    );

    // Right ray: M20 12h2 (extends right)
    canvas.drawLine(
      Offset(20 * scale, 12 * scale),
      Offset((22 + rayExtend) * scale, 12 * scale),
      paint,
    );

    // Diagonal rays with extension
    final diagExtend = rayExtend * 0.707; // cos(45°)

    // Top-left ray: m4.93 4.93 1.41 1.41
    canvas.drawLine(
      Offset((4.93 - diagExtend) * scale, (4.93 - diagExtend) * scale),
      Offset(6.34 * scale, 6.34 * scale),
      paint,
    );

    // Bottom-right ray: m17.66 17.66 1.41 1.41
    canvas.drawLine(
      Offset(17.66 * scale, 17.66 * scale),
      Offset((19.07 + diagExtend) * scale, (19.07 + diagExtend) * scale),
      paint,
    );

    // Bottom-left ray: m6.34 17.66-1.41 1.41
    canvas.drawLine(
      Offset(6.34 * scale, 17.66 * scale),
      Offset((4.93 - diagExtend) * scale, (19.07 + diagExtend) * scale),
      paint,
    );

    // Top-right ray: m19.07 4.93-1.41 1.41
    canvas.drawLine(
      Offset((19.07 + diagExtend) * scale, (4.93 - diagExtend) * scale),
      Offset(17.66 * scale, 6.34 * scale),
      paint,
    );
  }

  @override
  bool shouldRepaint(SunPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
