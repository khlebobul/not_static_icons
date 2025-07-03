import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

class ArrowDownRightIcon extends AnimatedSVGIcon {
  const ArrowDownRightIcon({
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
    return _ArrowDownRightPainter(color: color, animationValue: animationValue);
  }

  @override
  String get animationDescription => 'Arrow moving down-right and back once';
}

class _ArrowDownRightPainter extends CustomPainter {
  final Color color;
  final double animationValue;

  _ArrowDownRightPainter({required this.color, required this.animationValue});

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

    // Calculate movement animation (down-right and back)
    double offsetX = 0.0;
    double offsetY = 0.0;
    if (animationValue <= 0.5) {
      // Move down-right
      offsetX = 2.0 * (animationValue * 2);
      offsetY = 2.0 * (animationValue * 2);
    } else {
      // Move back to start
      offsetX = 2.0 * (2 - animationValue * 2);
      offsetY = 2.0 * (2 - animationValue * 2);
    }

    canvas.translate(offsetX, offsetY);

    // Main diagonal line
    final path1 = Path();
    path1.moveTo(7, 7);
    path1.lineTo(17, 17);
    canvas.drawPath(path1, paint);

    // Arrow head
    final path2 = Path();
    path2.moveTo(17, 7);
    path2.lineTo(17, 17);
    path2.lineTo(7, 17);
    canvas.drawPath(path2, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
