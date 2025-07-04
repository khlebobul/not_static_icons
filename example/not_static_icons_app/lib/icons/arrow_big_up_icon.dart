import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

class ArrowBigUpIcon extends AnimatedSVGIcon {
  const ArrowBigUpIcon({
    super.key,
    super.size = 40,
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
    return _ArrowBigUpPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }

  @override
  String get animationDescription => 'Arrow moving up and back once';
}

class _ArrowBigUpPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _ArrowBigUpPainter({
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

    // Calculate movement animation (up and back)
    double offsetY = 0.0;
    if (animationValue <= 0.5) {
      // Move up
      offsetY = -3.0 * (animationValue * 2);
    } else {
      // Move back to start
      offsetY = -3.0 * (2 - animationValue * 2);
    }

    canvas.translate(0, offsetY);

    // Main arrow path
    final path = Path();
    path.moveTo(9, 18);
    path.lineTo(9, 12);
    path.lineTo(5, 12);
    path.lineTo(12, 5);
    path.lineTo(19, 12);
    path.lineTo(15, 12);
    path.lineTo(15, 18);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _ArrowBigUpPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
