import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

class ArrowDownToLineIcon extends AnimatedSVGIcon {
  const ArrowDownToLineIcon({
    super.key,
    super.size = 24,
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
    return _ArrowDownToLinePainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }

  @override
  String get animationDescription => 'Arrow moving down to line and back once';
}

class _ArrowDownToLinePainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _ArrowDownToLinePainter({
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

    // Calculate arrow movement animation (down to line and back)
    double offsetY = 0.0;
    if (animationValue <= 0.5) {
      // Move down to line
      offsetY = 3.0 * (animationValue * 2);
    } else {
      // Move back from line
      offsetY = 3.0 * (2 - animationValue * 2);
    }

    canvas.save();
    canvas.translate(0, offsetY);

    // Arrow vertical line
    final arrowLinePath = Path();
    arrowLinePath.moveTo(12, 3);
    arrowLinePath.lineTo(12, 17);
    canvas.drawPath(arrowLinePath, paint);

    // Arrow head
    final arrowHeadPath = Path();
    arrowHeadPath.moveTo(6, 11);
    arrowHeadPath.lineTo(12, 17);
    arrowHeadPath.lineTo(18, 11);
    canvas.drawPath(arrowHeadPath, paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _ArrowDownToLinePainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
