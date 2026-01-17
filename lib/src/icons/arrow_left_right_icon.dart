import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

class ArrowLeftRightIcon extends AnimatedSVGIcon {
  const ArrowLeftRightIcon({
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
    return _ArrowLeftRightPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }

  @override
  String get animationDescription =>
      'Two arrows moving left and right in opposite directions';
}

class _ArrowLeftRightPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _ArrowLeftRightPainter({
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
    double offsetX = 0.0;
    if (animationValue <= 0.5) {
      // Move in opposite directions
      offsetX = 2.0 * (animationValue * 2);
    } else {
      // Move back to start
      offsetX = 2.0 * (2 - animationValue * 2);
    }

    // Top arrow (moving left)
    canvas.save();
    canvas.translate(-offsetX, 0);

    // Top arrow head (left)
    final topArrowHeadPath = Path();
    topArrowHeadPath.moveTo(8, 3);
    topArrowHeadPath.lineTo(4, 7);
    topArrowHeadPath.lineTo(8, 11);
    canvas.drawPath(topArrowHeadPath, paint);

    // Top arrow horizontal line
    final topArrowLinePath = Path();
    topArrowLinePath.moveTo(4, 7);
    topArrowLinePath.lineTo(20, 7);
    canvas.drawPath(topArrowLinePath, paint);

    canvas.restore();

    // Bottom arrow (moving right)
    canvas.save();
    canvas.translate(offsetX, 0);

    // Bottom arrow head (right)
    final bottomArrowHeadPath = Path();
    bottomArrowHeadPath.moveTo(16, 13);
    bottomArrowHeadPath.lineTo(20, 17);
    bottomArrowHeadPath.lineTo(16, 21);
    canvas.drawPath(bottomArrowHeadPath, paint);

    // Bottom arrow horizontal line
    final bottomArrowLinePath = Path();
    bottomArrowLinePath.moveTo(20, 17);
    bottomArrowLinePath.lineTo(4, 17);
    canvas.drawPath(bottomArrowLinePath, paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _ArrowLeftRightPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
