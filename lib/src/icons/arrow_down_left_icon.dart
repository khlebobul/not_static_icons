import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

class ArrowDownLeftIcon extends AnimatedSVGIcon {
  const ArrowDownLeftIcon({
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
    return _ArrowDownLeftPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }

  @override
  String get animationDescription => 'Arrow moving down-left and back once';
}

class _ArrowDownLeftPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _ArrowDownLeftPainter({
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

    // Calculate movement animation (down-left and back)
    double offsetX = 0.0;
    double offsetY = 0.0;
    if (animationValue <= 0.5) {
      // Move down-left
      offsetX = -2.0 * (animationValue * 2);
      offsetY = 2.0 * (animationValue * 2);
    } else {
      // Move back to start
      offsetX = -2.0 * (2 - animationValue * 2);
      offsetY = 2.0 * (2 - animationValue * 2);
    }

    canvas.translate(offsetX, offsetY);

    // Main diagonal line
    final path1 = Path();
    path1.moveTo(17, 7);
    path1.lineTo(7, 17);
    canvas.drawPath(path1, paint);

    // Arrow head
    final path2 = Path();
    path2.moveTo(17, 17);
    path2.lineTo(7, 17);
    path2.lineTo(7, 7);
    canvas.drawPath(path2, paint);
  }

  @override
  bool shouldRepaint(covariant _ArrowDownLeftPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
