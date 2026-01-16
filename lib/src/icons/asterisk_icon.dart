import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../core/animated_svg_icon_base.dart';

class AsteriskIcon extends AnimatedSVGIcon {
  const AsteriskIcon({
    super.key,
    super.size = 40,
    super.color = Colors.black,
    super.animationDuration = const Duration(milliseconds: 1000),
    super.strokeWidth = 1.3,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
    super.onTap,
    super.interactive,
    super.controller,
  });

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return _AsteriskPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }

  @override
  String get animationDescription => 'Asterisk rotating 360 degrees on hover';
}

class _AsteriskPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _AsteriskPainter({
    required this.color,
    required this.animationValue,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final scaleX = size.width / 24;
    final scaleY = size.height / 24;
    canvas.scale(scaleX, scaleY);

    // Calculate rotation animation (360 degrees)
    final rotationAngle = animationValue * 2 * math.pi;

    // Translate to center, rotate, then translate back
    canvas.translate(12, 12);
    canvas.rotate(rotationAngle);
    canvas.translate(-12, -12);

    // Vertical line: M12 6v12
    final path1 = Path();
    path1.moveTo(12, 6);
    path1.lineTo(12, 18);
    canvas.drawPath(path1, paint);

    // Diagonal line 1: M17.196 9 L6.804 15
    final path2 = Path();
    path2.moveTo(17.196, 9);
    path2.lineTo(6.804, 15);
    canvas.drawPath(path2, paint);

    // Diagonal line 2: m6.804 9 l10.392 6
    final path3 = Path();
    path3.moveTo(6.804, 9);
    path3.lineTo(17.196, 15);
    canvas.drawPath(path3, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
