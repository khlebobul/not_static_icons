import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

class ArrowRightFromLineIcon extends AnimatedSVGIcon {
  const ArrowRightFromLineIcon({
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
    return _ArrowRightFromLinePainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }

  @override
  String get animationDescription =>
      'Arrow moving right from line and back once';
}

class _ArrowRightFromLinePainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _ArrowRightFromLinePainter({
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

    // Static left line
    final linePath = Path();
    linePath.moveTo(3, 5);
    linePath.lineTo(3, 19);
    canvas.drawPath(linePath, paint);

    // Calculate arrow movement animation (right from line and back)
    double offsetX = 0.0;
    if (animationValue <= 0.5) {
      // Move right from line
      offsetX = 3.0 * (animationValue * 2);
    } else {
      // Move back to line
      offsetX = 3.0 * (2 - animationValue * 2);
    }

    canvas.save();
    canvas.translate(offsetX, 0);

    // Arrow horizontal line
    final arrowLinePath = Path();
    arrowLinePath.moveTo(7, 12);
    arrowLinePath.lineTo(21, 12);
    canvas.drawPath(arrowLinePath, paint);

    // Arrow head
    final arrowHeadPath = Path();
    arrowHeadPath.moveTo(15, 6);
    arrowHeadPath.lineTo(21, 12);
    arrowHeadPath.lineTo(15, 18);
    canvas.drawPath(arrowHeadPath, paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _ArrowRightFromLinePainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
