import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

class ArrowBigRightIcon extends AnimatedSVGIcon {
  const ArrowBigRightIcon({
    super.key,
    super.size = 24,
    super.color = Colors.black,
    super.animationDuration = const Duration(milliseconds: 1500),
    super.strokeWidth = 2.0,
  });

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return _ArrowBigRightPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }

  @override
  String get animationDescription => 'Arrow moving right and back once';
}

class _ArrowBigRightPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _ArrowBigRightPainter({
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

    // Main arrow path
    final path = Path();
    path.moveTo(6, 9);
    path.lineTo(12, 9);
    path.lineTo(12, 5);
    path.lineTo(19, 12);
    path.lineTo(12, 19);
    path.lineTo(12, 15);
    path.lineTo(6, 15);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _ArrowBigRightPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
