import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Cylinder Icon - gentle vertical bob on hover/tap
class CylinderIcon extends AnimatedSVGIcon {
  const CylinderIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 800),
    super.strokeWidth = 2.0,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
    super.resetToStartOnComplete = true,
    super.onTap,
    super.interactive,
    super.controller,
  });

  @override
  String get animationDescription => 'Cylinder gently bobs up and down';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return _CylinderPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class _CylinderPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _CylinderPainter({
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

    final double s = size.width / 24.0;
    final double t = animationValue.clamp(0.0, 1.0);

    // Vertical bob: rises then falls
    final double dy = -math.sin(math.pi * t) * 1.5 * s;

    canvas.save();
    canvas.translate(0, dy);

    // Top ellipse: cx=12 cy=5 rx=9 ry=3
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(12 * s, 5 * s),
        width: 18 * s,
        height: 6 * s,
      ),
      paint,
    );

    // Body: M3 5v14a9 3 0 0 0 18 0V5
    final Path body = Path()
      ..moveTo(3 * s, 5 * s)
      ..lineTo(3 * s, 19 * s)
      ..arcToPoint(
        Offset(21 * s, 19 * s),
        radius: Radius.elliptical(9 * s, 3 * s),
        clockwise: false,
      )
      ..lineTo(21 * s, 5 * s);
    canvas.drawPath(body, paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(_CylinderPainter old) =>
      old.color != color ||
      old.animationValue != animationValue ||
      old.strokeWidth != strokeWidth;
}
