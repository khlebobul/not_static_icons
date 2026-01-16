import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

class ArrowUpToLineIcon extends AnimatedSVGIcon {
  const ArrowUpToLineIcon({
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
    return _ArrowUpToLinePainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }

  @override
  String get animationDescription => 'Arrow moving up to line and back once';
}

class _ArrowUpToLinePainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _ArrowUpToLinePainter({
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

    // Static top line
    final linePath = Path();
    linePath.moveTo(5, 3);
    linePath.lineTo(19, 3);
    canvas.drawPath(linePath, paint);

    // Calculate arrow movement animation (up to line and back)
    double offsetY = 0.0;
    if (animationValue <= 0.5) {
      // Move up to line
      offsetY = -3.0 * (animationValue * 2);
    } else {
      // Move back from line
      offsetY = -3.0 * (2 - animationValue * 2);
    }

    canvas.save();
    canvas.translate(0, offsetY);

    // Arrow head
    final arrowHeadPath = Path();
    arrowHeadPath.moveTo(6, 13);
    arrowHeadPath.lineTo(12, 7);
    arrowHeadPath.lineTo(18, 13);
    canvas.drawPath(arrowHeadPath, paint);

    // Arrow vertical line
    final arrowLinePath = Path();
    arrowLinePath.moveTo(12, 7);
    arrowLinePath.lineTo(12, 21);
    canvas.drawPath(arrowLinePath, paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _ArrowUpToLinePainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
