import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

class ArrowDownUpIcon extends AnimatedSVGIcon {
  const ArrowDownUpIcon({
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
    return _ArrowDownUpPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }

  @override
  String get animationDescription =>
      'Two arrows moving down and up in opposite directions';
}

class _ArrowDownUpPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _ArrowDownUpPainter({
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

    // Calculate movement animation
    double offsetY = 0.0;
    if (animationValue <= 0.5) {
      // Move in opposite directions
      offsetY = 2.0 * (animationValue * 2);
    } else {
      // Move back to start
      offsetY = 2.0 * (2 - animationValue * 2);
    }

    // Left arrow (moving down)
    canvas.save();
    canvas.translate(0, offsetY);

    // Left arrow head (down)
    final leftArrowHeadPath = Path();
    leftArrowHeadPath.moveTo(3, 16);
    leftArrowHeadPath.lineTo(7, 20);
    leftArrowHeadPath.lineTo(11, 16);
    canvas.drawPath(leftArrowHeadPath, paint);

    // Left arrow vertical line
    final leftArrowLinePath = Path();
    leftArrowLinePath.moveTo(7, 20);
    leftArrowLinePath.lineTo(7, 4);
    canvas.drawPath(leftArrowLinePath, paint);

    canvas.restore();

    // Right arrow (moving up)
    canvas.save();
    canvas.translate(0, -offsetY);

    // Right arrow head (up)
    final rightArrowHeadPath = Path();
    rightArrowHeadPath.moveTo(13, 8);
    rightArrowHeadPath.lineTo(17, 4);
    rightArrowHeadPath.lineTo(21, 8);
    canvas.drawPath(rightArrowHeadPath, paint);

    // Right arrow vertical line
    final rightArrowLinePath = Path();
    rightArrowLinePath.moveTo(17, 4);
    rightArrowLinePath.lineTo(17, 20);
    canvas.drawPath(rightArrowLinePath, paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _ArrowDownUpPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
