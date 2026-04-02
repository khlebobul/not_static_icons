import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Command Icon - Command symbol rotates
class CommandIcon extends AnimatedSVGIcon {
  const CommandIcon({
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
  String get animationDescription => "Command symbol rotates";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return CommandPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class CommandPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  CommandPainter({
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

    // Animation - rotate
    final oscillation = 4 * animationValue * (1 - animationValue);
    final rotation = oscillation * math.pi / 2;

    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(rotation);
    canvas.translate(-center.dx, -center.dy);

    // Command path: M15 6v12a3 3 0 1 0 3-3H6a3 3 0 1 0 3 3V6a3 3 0 1 0-3 3h12a3 3 0 1 0-3-3
    final path = Path();
    path.moveTo(15 * scale, 6 * scale);
    path.lineTo(15 * scale, 18 * scale);
    path.arcToPoint(
      Offset(18 * scale, 15 * scale),
      radius: Radius.circular(3 * scale),
      largeArc: true,
      clockwise: false,
    );
    path.lineTo(6 * scale, 15 * scale);
    path.arcToPoint(
      Offset(9 * scale, 18 * scale),
      radius: Radius.circular(3 * scale),
      largeArc: true,
      clockwise: false,
    );
    path.lineTo(9 * scale, 6 * scale);
    path.arcToPoint(
      Offset(6 * scale, 9 * scale),
      radius: Radius.circular(3 * scale),
      largeArc: true,
      clockwise: false,
    );
    path.lineTo(18 * scale, 9 * scale);
    path.arcToPoint(
      Offset(15 * scale, 6 * scale),
      radius: Radius.circular(3 * scale),
      largeArc: true,
      clockwise: false,
    );
    canvas.drawPath(path, paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(CommandPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
