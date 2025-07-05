import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

class ArrowUpFromLineIcon extends AnimatedSVGIcon {
  const ArrowUpFromLineIcon({
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
    return _ArrowUpFromLinePainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }

  @override
  String get animationDescription => 'Arrow moving up from line and back once';
}

class _ArrowUpFromLinePainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _ArrowUpFromLinePainter({
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
    linePath.moveTo(5, 21);
    linePath.lineTo(19, 21);
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

    // Arrow head
    final arrowHeadPath = Path();
    arrowHeadPath.moveTo(6, 9);
    arrowHeadPath.lineTo(12, 3);
    arrowHeadPath.lineTo(18, 9);
    canvas.drawPath(arrowHeadPath, paint);

    // Arrow vertical line
    final arrowLinePath = Path();
    arrowLinePath.moveTo(12, 3);
    arrowLinePath.lineTo(12, 17);
    canvas.drawPath(arrowLinePath, paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _ArrowUpFromLinePainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
