import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Circle User Icon - User profile pulses
class CircleUserIcon extends AnimatedSVGIcon {
  const CircleUserIcon({
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
  String get animationDescription => "User profile pulses";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return CircleUserPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

/// Painter for Circle User icon
class CircleUserPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  CircleUserPainter({
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

    // Outer circle: cx="12" cy="12" r="10"
    canvas.drawCircle(center, 10 * scale, paint);

    // Head circle: cx="12" cy="10" r="3"
    canvas.drawCircle(Offset(12 * scale, 10 * scale), 3 * scale, paint);

    // Body path: M7 20.662V19a2 2 0 0 1 2-2h6a2 2 0 0 1 2 2v1.662
    final bodyPath = Path();
    bodyPath.moveTo(7 * scale, 20.662 * scale);
    bodyPath.lineTo(7 * scale, 19 * scale);
    bodyPath.quadraticBezierTo(
      7 * scale,
      17 * scale,
      9 * scale,
      17 * scale,
    );
    bodyPath.lineTo(15 * scale, 17 * scale);
    bodyPath.quadraticBezierTo(
      17 * scale,
      17 * scale,
      17 * scale,
      19 * scale,
    );
    bodyPath.lineTo(17 * scale, 20.662 * scale);
    canvas.drawPath(bodyPath, paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(CircleUserPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
