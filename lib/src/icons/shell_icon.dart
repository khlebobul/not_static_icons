import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Shell Icon - Shell rotates
class ShellIcon extends AnimatedSVGIcon {
  const ShellIcon({
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
  String get animationDescription => "Shell rotates";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return ShellPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class ShellPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  ShellPainter({
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
    final center = Offset(12 * scale, 11 * scale);

    // Animation - shell rotates
    final oscillation = 4 * animationValue * (1 - animationValue);
    final rotationAngle = oscillation * 0.3;

    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(rotationAngle);
    canvas.translate(-center.dx, -center.dy);

    // Shell spiral path: M14 11a2 2 0 1 1-4 0 4 4 0 0 1 8 0 6 6 0 0 1-12 0 8 8 0 0 1 16 0 10 10 0 1 1-20 0 11.93 11.93 0 0 1 2.42-7.22 a2 2 0 1 1 3.16 2.44
    final shellPath = Path();

    // Start at M14 11
    shellPath.moveTo(14 * scale, 11 * scale);

    // a2 2 0 1 1-4 0
    shellPath.arcToPoint(
      Offset(10 * scale, 11 * scale),
      radius: Radius.circular(2 * scale),
      clockwise: true,
      largeArc: true,
    );

    // 4 4 0 0 1 8 0
    shellPath.arcToPoint(
      Offset(18 * scale, 11 * scale),
      radius: Radius.circular(4 * scale),
      clockwise: true,
      largeArc: false,
    );

    // 6 6 0 0 1-12 0
    shellPath.arcToPoint(
      Offset(6 * scale, 11 * scale),
      radius: Radius.circular(6 * scale),
      clockwise: true,
      largeArc: false,
    );

    // 8 8 0 0 1 16 0
    shellPath.arcToPoint(
      Offset(22 * scale, 11 * scale),
      radius: Radius.circular(8 * scale),
      clockwise: true,
      largeArc: false,
    );

    // 10 10 0 1 1-20 0
    shellPath.arcToPoint(
      Offset(2 * scale, 11 * scale),
      radius: Radius.circular(10 * scale),
      clockwise: true,
      largeArc: true,
    );

    // 11.93 11.93 0 0 1 2.42-7.22
    shellPath.arcToPoint(
      Offset(4.42 * scale, 3.78 * scale),
      radius: Radius.circular(11.93 * scale),
      clockwise: true,
      largeArc: false,
    );

    // a2 2 0 1 1 3.16 2.44
    shellPath.arcToPoint(
      Offset(7.58 * scale, 6.22 * scale),
      radius: Radius.circular(2 * scale),
      clockwise: true,
      largeArc: true,
    );

    canvas.drawPath(shellPath, paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(ShellPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
