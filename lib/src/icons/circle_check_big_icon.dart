import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Circle Check Big Icon - Checkmark pulses
class CircleCheckBigIcon extends AnimatedSVGIcon {
  const CircleCheckBigIcon({
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
  String get animationDescription => "Big checkmark pulses";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return CircleCheckBigPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

/// Painter for Circle Check Big icon
class CircleCheckBigPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  CircleCheckBigPainter({
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

    // Partial circle: M21.801 10A10 10 0 1 1 17 3.335
    // Arc from (21.801, 10) to (17, 3.335) with r=10
    // large-arc-flag=1, sweep-flag=1 (clockwise, large arc)
    final path = Path();
    path.moveTo(21.801 * scale, 10 * scale);
    path.arcToPoint(
      Offset(17 * scale, 3.335 * scale),
      radius: Radius.circular(10 * scale),
      clockwise: true,
      largeArc: true,
    );
    canvas.drawPath(path, paint);

    // Big checkmark: m9 11 3 3L22 4
    final checkPath = Path();
    checkPath.moveTo(9 * scale, 11 * scale);
    checkPath.lineTo(12 * scale, 14 * scale);
    checkPath.lineTo(22 * scale, 4 * scale);
    canvas.drawPath(checkPath, paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(CircleCheckBigPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
