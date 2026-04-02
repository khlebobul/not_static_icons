import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Compass Icon - Needle rotates
class CompassIcon extends AnimatedSVGIcon {
  const CompassIcon({
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
  String get animationDescription => "Needle rotates";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return CompassPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class CompassPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  CompassPainter({
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

    // Outer circle (static): cx="12" cy="12" r="10"
    canvas.drawCircle(center, 10 * scale, paint);

    // Needle (animated - rotates)
    final oscillation = 4 * animationValue * (1 - animationValue);
    final rotation = oscillation * math.pi / 3;

    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(rotation);
    canvas.translate(-center.dx, -center.dy);

    // Needle diamond shape:
    // m16.24 7.76-1.804 5.411a2 2 0 0 1-1.265 1.265L7.76 16.24l1.804-5.411a2 2 0 0 1 1.265-1.265z
    final needlePath = Path();
    needlePath.moveTo(16.24 * scale, 7.76 * scale);
    needlePath.lineTo(14.436 * scale, 13.171 * scale);
    needlePath.arcToPoint(
      Offset(13.171 * scale, 14.436 * scale),
      radius: Radius.circular(2 * scale),
      clockwise: true,
    );
    needlePath.lineTo(7.76 * scale, 16.24 * scale);
    needlePath.lineTo(9.564 * scale, 10.829 * scale);
    needlePath.arcToPoint(
      Offset(10.829 * scale, 9.564 * scale),
      radius: Radius.circular(2 * scale),
      clockwise: true,
    );
    needlePath.close();
    canvas.drawPath(needlePath, paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(CompassPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
