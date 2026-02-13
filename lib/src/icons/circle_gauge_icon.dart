import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Circle Gauge Icon - Needle swings
class CircleGaugeIcon extends AnimatedSVGIcon {
  const CircleGaugeIcon({
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
  String get animationDescription => "Gauge needle swings";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return CircleGaugePainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

/// Painter for Circle Gauge icon
class CircleGaugePainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  CircleGaugePainter({
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

    // Almost complete circle with small gap at top-right
    // path d="M15.6 2.7a10 10 0 1 0 5.7 5.7"
    final circlePath = Path();
    circlePath.moveTo(15.6 * scale, 2.7 * scale);
    circlePath.arcToPoint(
      Offset(21.3 * scale, 8.4 * scale),
      radius: Radius.circular(10 * scale),
      clockwise: false,
      largeArc: true,
    );
    canvas.drawPath(circlePath, paint);

    // Center circle: cx="12" cy="12" r="2"
    canvas.drawCircle(center, 2 * scale, paint);

    // Animated needle: M13.4 10.6 L19 5
    // Needle swings around its base
    final oscillation = 4 * animationValue * (1 - animationValue);
    final swingAngle = oscillation * math.pi / 6;

    // Calculate needle endpoints with rotation
    final baseX = 13.4;
    final baseY = 10.6;
    final tipX = 19.0;
    final tipY = 5.0;

    // Vector from base to tip
    final dx = tipX - baseX;
    final dy = tipY - baseY;

    // Rotate the vector
    final cosA = math.cos(swingAngle);
    final sinA = math.sin(swingAngle);
    final newDx = dx * cosA - dy * sinA;
    final newDy = dx * sinA + dy * cosA;

    canvas.drawLine(
      Offset(baseX * scale, baseY * scale),
      Offset((baseX + newDx) * scale, (baseY + newDy) * scale),
      paint,
    );
  }

  @override
  bool shouldRepaint(CircleGaugePainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
