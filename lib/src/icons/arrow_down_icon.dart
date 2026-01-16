import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

class ArrowDownIcon extends AnimatedSVGIcon {
  const ArrowDownIcon({
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
    return _ArrowDownPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }

  @override
  String get animationDescription => 'Arrow moving down and back once';
}

class _ArrowDownPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _ArrowDownPainter({
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

    // Calculate movement animation (down and back)
    double offsetY = 0.0;
    if (animationValue <= 0.5) {
      // Move down
      offsetY = 3.0 * (animationValue * 2);
    } else {
      // Move back to start
      offsetY = 3.0 * (2 - animationValue * 2);
    }

    canvas.translate(0, offsetY);

    // Main vertical line
    final path1 = Path();
    path1.moveTo(12, 5);
    path1.lineTo(12, 19);
    canvas.drawPath(path1, paint);

    // Arrow head
    final path2 = Path();
    path2.moveTo(19, 12);
    path2.lineTo(12, 19);
    path2.lineTo(5, 12);
    canvas.drawPath(path2, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
