import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

class ArrowsUpFromLineIcon extends AnimatedSVGIcon {
  const ArrowsUpFromLineIcon({
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
    return _ArrowsUpFromLinePainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }

  @override
  String get animationDescription =>
      'Two arrows moving up from line and back once';
}

class _ArrowsUpFromLinePainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _ArrowsUpFromLinePainter({
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

    // Static bottom line
    final linePath = Path();
    linePath.moveTo(4, 21);
    linePath.lineTo(20, 21);
    canvas.drawPath(linePath, paint);

    // Calculate arrow movement animation (up from line and back)
    double offsetY = 0.0;
    if (animationValue <= 0.5) {
      // Move up from line
      offsetY = -3.0 * (animationValue * 2);
    } else {
      // Move back to line
      offsetY = -3.0 * (2 - animationValue * 2);
    }

    canvas.save();
    canvas.translate(0, offsetY);

    // Left arrow head
    final leftArrowHeadPath = Path();
    leftArrowHeadPath.moveTo(4, 6);
    leftArrowHeadPath.lineTo(7, 3);
    leftArrowHeadPath.lineTo(10, 6);
    canvas.drawPath(leftArrowHeadPath, paint);

    // Left arrow vertical line
    final leftArrowLinePath = Path();
    leftArrowLinePath.moveTo(7, 3);
    leftArrowLinePath.lineTo(7, 17);
    canvas.drawPath(leftArrowLinePath, paint);

    // Right arrow head
    final rightArrowHeadPath = Path();
    rightArrowHeadPath.moveTo(14, 6);
    rightArrowHeadPath.lineTo(17, 3);
    rightArrowHeadPath.lineTo(20, 6);
    canvas.drawPath(rightArrowHeadPath, paint);

    // Right arrow vertical line
    final rightArrowLinePath = Path();
    rightArrowLinePath.moveTo(17, 3);
    rightArrowLinePath.lineTo(17, 17);
    canvas.drawPath(rightArrowLinePath, paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _ArrowsUpFromLinePainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
