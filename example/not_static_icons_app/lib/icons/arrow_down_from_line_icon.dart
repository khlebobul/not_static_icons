import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

class ArrowDownFromLineIcon extends AnimatedSVGIcon {
  const ArrowDownFromLineIcon({
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
    return _ArrowDownFromLinePainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }

  @override
  String get animationDescription =>
      'Arrow moving down from line and back once';
}

class _ArrowDownFromLinePainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _ArrowDownFromLinePainter({
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

    // Calculate arrow movement animation (down from line and back)
    double offsetY = 0.0;
    if (animationValue <= 0.5) {
      // Move down from line
      offsetY = 3.0 * (animationValue * 2);
    } else {
      // Move back to line
      offsetY = 3.0 * (2 - animationValue * 2);
    }

    canvas.save();
    canvas.translate(0, offsetY);

    // Arrow vertical line
    final arrowLinePath = Path();
    arrowLinePath.moveTo(12, 7);
    arrowLinePath.lineTo(12, 21);
    canvas.drawPath(arrowLinePath, paint);

    // Arrow head
    final arrowHeadPath = Path();
    arrowHeadPath.moveTo(6, 15);
    arrowHeadPath.lineTo(12, 21);
    arrowHeadPath.lineTo(18, 15);
    canvas.drawPath(arrowHeadPath, paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _ArrowDownFromLinePainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
