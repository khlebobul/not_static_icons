import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Circle Dollar Sign Icon - Dollar sign pulses
class CircleDollarSignIcon extends AnimatedSVGIcon {
  const CircleDollarSignIcon({
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
  String get animationDescription => "Dollar sign pulses";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return CircleDollarSignPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

/// Painter for Circle Dollar Sign icon
class CircleDollarSignPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  CircleDollarSignPainter({
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

    // Animation - pulse scale
    final oscillation = 4 * animationValue * (1 - animationValue);
    final scaleAnim = 1.0 + oscillation * 0.1;

    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.scale(scaleAnim);
    canvas.translate(-center.dx, -center.dy);

    // Circle: cx="12" cy="12" r="10"
    canvas.drawCircle(center, 10 * scale, paint);

    // Vertical line: M12 18V6
    canvas.drawLine(
      Offset(12 * scale, 18 * scale),
      Offset(12 * scale, 6 * scale),
      paint,
    );

    // Top curve: M16 8h-6a2 2 0 1 0 0 4h4
    final topPath = Path();
    topPath.moveTo(16 * scale, 8 * scale);
    topPath.lineTo(10 * scale, 8 * scale);
    topPath.arcToPoint(
      Offset(10 * scale, 12 * scale),
      radius: Radius.circular(2 * scale),
      clockwise: false,
    );
    topPath.lineTo(14 * scale, 12 * scale);
    canvas.drawPath(topPath, paint);

    // Bottom curve: h4a2 2 0 1 1 0 4H8
    final bottomPath = Path();
    bottomPath.moveTo(14 * scale, 12 * scale);
    bottomPath.arcToPoint(
      Offset(14 * scale, 16 * scale),
      radius: Radius.circular(2 * scale),
      clockwise: true,
    );
    bottomPath.lineTo(8 * scale, 16 * scale);
    canvas.drawPath(bottomPath, paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(CircleDollarSignPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
