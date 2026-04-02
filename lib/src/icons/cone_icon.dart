import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Cone Icon - Cone wobbles
class ConeIcon extends AnimatedSVGIcon {
  const ConeIcon({
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
  String get animationDescription => "Cone wobbles";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return ConePainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class ConePainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  ConePainter({
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

    // Animation - wobble
    final oscillation = 4 * animationValue * (1 - animationValue);
    final wobble = oscillation * 0.1;

    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(wobble);
    canvas.translate(-center.dx, -center.dy);

    // Cone sides: m20.9 18.55-8-15.98a1 1 0 0 0-1.8 0l-8 15.98
    final conePath = Path();
    conePath.moveTo(20.9 * scale, 18.55 * scale);
    conePath.lineTo(12.9 * scale, 2.57 * scale);
    conePath.arcToPoint(
      Offset(11.1 * scale, 2.57 * scale),
      radius: Radius.circular(1 * scale),
      clockwise: false,
    );
    conePath.lineTo(3.1 * scale, 18.55 * scale);
    canvas.drawPath(conePath, paint);

    // Base ellipse: cx="12" cy="19" rx="9" ry="3"
    final baseRect = Rect.fromCenter(
      center: Offset(12 * scale, 19 * scale),
      width: 18 * scale,
      height: 6 * scale,
    );
    canvas.drawOval(baseRect, paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(ConePainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
