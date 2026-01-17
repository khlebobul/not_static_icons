import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

class ArrowBigRightDashIcon extends AnimatedSVGIcon {
  const ArrowBigRightDashIcon({
    super.key,
    super.size = 40,
    super.color = Colors.black,
    super.animationDuration = const Duration(milliseconds: 1500),
    super.strokeWidth = 2.0,
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
    return _ArrowBigRightDashPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }

  @override
  String get animationDescription => 'Arrow moving right and back once';
}

class _ArrowBigRightDashPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _ArrowBigRightDashPainter({
    required this.color,
    required this.animationValue,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth / 1.7
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final scaleX = size.width / 24;
    final scaleY = size.height / 24;
    canvas.scale(scaleX, scaleY);

    // Calculate movement animation (right and back)
    double offsetX = 0.0;
    if (animationValue <= 0.5) {
      // Move right
      offsetX = 3.0 * (animationValue * 2);
    } else {
      // Move back to start
      offsetX = 3.0 * (2 - animationValue * 2);
    }

    canvas.translate(offsetX, 0);

    // Left vertical line
    final path1 = Path();
    path1.moveTo(5, 9);
    path1.lineTo(5, 15);
    canvas.drawPath(path1, paint);

    // Main arrow
    final path2 = Path();
    path2.moveTo(9, 9);
    path2.lineTo(12, 9);
    path2.lineTo(12, 5);
    path2.lineTo(19, 12);
    path2.lineTo(12, 19);
    path2.lineTo(12, 15);
    path2.lineTo(9, 15);
    path2.close();
    canvas.drawPath(path2, paint);
  }

  @override
  bool shouldRepaint(covariant _ArrowBigRightDashPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
