import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

class ArrowLeftIcon extends AnimatedSVGIcon {
  const ArrowLeftIcon({
    super.key,
    super.size = 40,
    super.color = Colors.black,
    super.animationDuration = const Duration(milliseconds: 1500),
    super.strokeWidth = 2.0,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
  });

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return _ArrowLeftPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }

  @override
  String get animationDescription => 'Arrow moving left and back once';
}

class _ArrowLeftPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _ArrowLeftPainter({
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

    // Arrow head
    final path1 = Path();
    path1.moveTo(12, 19);
    path1.lineTo(5, 12);
    path1.lineTo(12, 5);
    canvas.drawPath(path1, paint);

    // Main horizontal line
    final path2 = Path();
    path2.moveTo(19, 12);
    path2.lineTo(5, 12);
    canvas.drawPath(path2, paint);
  }

  @override
  bool shouldRepaint(covariant _ArrowLeftPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
