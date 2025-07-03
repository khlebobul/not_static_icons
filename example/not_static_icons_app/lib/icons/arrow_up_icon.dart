import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

class ArrowUpIcon extends AnimatedSVGIcon {
  const ArrowUpIcon({
    super.key,
    super.size = 24,
    super.color = Colors.black,
    super.animationDuration = const Duration(milliseconds: 1500),
  });

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
  }) {
    return _ArrowUpPainter(color: color, animationValue: animationValue);
  }

  @override
  String get animationDescription => 'Arrow moving up and back once';
}

class _ArrowUpPainter extends CustomPainter {
  final Color color;
  final double animationValue;

  _ArrowUpPainter({required this.color, required this.animationValue});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0
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

    // Arrow head
    final path1 = Path();
    path1.moveTo(5, 12);
    path1.lineTo(12, 5);
    path1.lineTo(19, 12);
    canvas.drawPath(path1, paint);

    // Main vertical line
    final path2 = Path();
    path2.moveTo(12, 19);
    path2.lineTo(12, 5);
    canvas.drawPath(path2, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
