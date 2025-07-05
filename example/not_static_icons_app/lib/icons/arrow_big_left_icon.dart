import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

class ArrowBigLeftIcon extends AnimatedSVGIcon {
  const ArrowBigLeftIcon({
    super.key,
    super.size = 40,
    super.color = Colors.black,
    super.animationDuration = const Duration(milliseconds: 1500),
    super.strokeWidth = 2.0,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
  });

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return _ArrowBigLeftPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }

  @override
  String get animationDescription => 'Arrow moving left and back once';
}

class _ArrowBigLeftPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _ArrowBigLeftPainter({
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

    // Calculate movement animation (left and back)
    double offsetX = 0.0;
    if (animationValue <= 0.5) {
      // Move left
      offsetX = -3.0 * (animationValue * 2);
    } else {
      // Move back to start
      offsetX = -3.0 * (2 - animationValue * 2);
    }

    canvas.translate(offsetX, 0);

    // Main arrow path
    final path = Path();
    path.moveTo(18, 15);
    path.lineTo(12, 15);
    path.lineTo(12, 19);
    path.lineTo(5, 12);
    path.lineTo(12, 5);
    path.lineTo(12, 9);
    path.lineTo(18, 9);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate is _ArrowBigLeftPainter &&
        (oldDelegate.color != color ||
            oldDelegate.animationValue != animationValue ||
            oldDelegate.strokeWidth != strokeWidth);
  }
}
